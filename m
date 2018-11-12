From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 11:55:35 -0600
Subject: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1541457421-14820-3-git-send-email-wendy.liang@xilinx.com>
References: <1541457421-14820-1-git-send-email-wendy.liang@xilinx.com>
 <1541457421-14820-3-git-send-email-wendy.liang@xilinx.com>
Message-ID: <5bea0eb3.1c69fb81.20e73.a4f9@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 02:37:01PM -0800, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> new file mode 100644
> index 0000000..18fd7b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> @@ -0,0 +1,128 @@
> +Xilinx IPI Mailbox Controller
> +========================================
> +
> +The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> +messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> +agent owns registers used for notification and buffers for message.
> +
> +               +-------------------------------------+
> +               | Xilinx ZynqMP IPI Controller        |
> +               +-------------------------------------+
> +    +--------------------------------------------------+
> +ATF                    |                     |
> +                       |                     |
> +                       |                     |
> +    +--------------------------+             |
> +                       |                     |
> +                       |                     |
> +    +--------------------------------------------------+
> +            +------------------------------------------+
> +            |  +----------------+   +----------------+ |
> +Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> +            |  |  Registers     |   |                | |
> +            |  |                |   |                | |
> +            |  +----------------+   +----------------+ |
> +            |                                          |
> +            | Xilinx IPI Agent Block                   |
> +            +------------------------------------------+
> +
> +
> +Controller Device Node:
> +===========================
> +Required properties:
> +--------------------
> +IPI agent node:
> +- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> +- interrupt-parent:	Phandle for the interrupt controller
> +- interrupts:		Interrupt information corresponding to the
> +			interrupt-names property.
> +- xlnx,ipi-id:		local Xilinx IPI agent ID
> +- #address-cells:	number of address cells of internal IPI mailbox nodes
> +- #size-cells:		number of size cells of internal IPI mailbox nodes
> +
> +Internal IPI mailbox node:
> +- reg:			IPI buffers address ranges
> +- reg-names:		Names of the reg resources. It should have:
> +			* local_request_region
> +			  - IPI request msg buffer written by local and read
> +			    by remote
> +			* local_response_region
> +			  - IPI response msg buffer written by local and read
> +			    by remote
> +			* remote_request_region
> +			  - IPI request msg buffer written by remote and read
> +			    by local
> +			* remote_response_region
> +			  - IPI response msg buffer written by remote and read
> +			    by local
> +- #mbox-cells:		Shall be 1. It contains:
> +			* tx(0) or rx(1) channel
> +- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
> +			connected to.
> +
> +Optional properties:
> +--------------------
> +- method:              The method of accessing the IPI agent registers.
> +                       Permitted values are: "smc" and "hvc". Default is
> +                       "smc".
> +
> +Client Device Node:
> +===========================
> +Required properties:
> +--------------------
> +- mboxes:		Standard property to specify a mailbox
> +			(See ./mailbox.txt)
> +- mbox-names:		List of identifier  strings for each mailbox
> +			channel.
> +
> +Example:
> +===========================
> +	zynqmp_ipi {
> +		compatible = "xlnx,zynqmp-ipi-mailbox";
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 29 4>;
> +		xlnx,ipi-id = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Both the parent and children are mailbox providers?

> +
> +		/* APU<->RPU0 IPI mailbox controller */
> +		ipi_mailbox_rpu0: mailbox at ff90400 {
> +			compatible = "xlnx,zynqmp-ipi-mailbox";

You can't have the same compatible in the parent and here.

> +			reg = <0xff990400 0x20>,
> +			      <0xff990420 0x20>,
> +			      <0xff990080 0x20>,
> +			      <0xff9900a0 0x20>;
> +			reg-names = "local_request_region",
> +				    "local_response_region",
> +				    "remote_request_region",
> +				    "remote_response_region";
> +			#mbox-cells = <1>;
> +			xlnx,ipi-id = <1>;
> +		};
> +		/* APU<->RPU1 IPI mailbox controller */
> +		ipi_mailbox_rpu1: mailbox at ff990440 {
> +			compatible = "xlnx,zynqmp-ipi-mailbox";
> +			reg = <0xff990440 0x20>,
> +			      <0xff990460 0x20>,
> +			      <0xff990280 0x20>,
> +			      <0xff9902a0 0x20>;
> +			reg-names = "local_request_region",
> +				    "local_response_region",
> +				    "remote_request_region",
> +				    "remote_response_region";
> +			#mbox-cells = <1>;
> +			xlnx,ipi-id = <2>;
> +		};
> +	};
> +	rpu0 {
> +		...
> +		mboxes = <&ipi_mailbox_rpu0 0>,
> +			 <&ipi_mailbox_rpu0 1>;
> +		mbox-names = "tx", "rx";
> +	};
> +	rpu1 {
> +		...
> +		mboxes = <&ipi_mailbox_rpu1 0>,
> +			 <&ipi_mailbox_rpu1 1>;
> +		mbox-names = "tx", "rx";
> +	};
> -- 
> 2.7.4
> 
