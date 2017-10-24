From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 12:50:13 -0500
Subject: [RFC PATCH v2] Dcoumentation: dt: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1508265184-17799-1-git-send-email-jliang@xilinx.com>
References: <1508265184-17799-1-git-send-email-jliang@xilinx.com>
Message-ID: <20171024175013.sovbmrpagrtcvq2u@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 11:33:04AM -0700, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.

"dt-bindings: mailbox: " for the subject prefix please.

> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
> V2: Each ZynqMP IPI mailbox controller instance for one physical connection
>     between two ZynqMP IPI agents.
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 103 +++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> new file mode 100644
> index 0000000..ba02b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> @@ -0,0 +1,103 @@
> +Xilinx IPI Mailbox Driver
> +========================================
> +
> +The Xilinx IPI(Inter Processor Interrupt) mailbox driver is a mailbox

Bindings are for h/w, not drivers.

> +controller that manages the messaging between two Xilinx Zynq UltraScale+
> +MPSoC IPI agents. Each IPI agent owns registers used for notification and
> +buffers for message.
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
> +- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> +- reg:			IPI buffers address range
> +- reg-names:		Names of the reg resources
> +- #mbox-cells:		Shall be 1. It contains:
> +			* tx(0) or rx(1) channel
> +- ipi-ids:		IPI agent IDs of the two ends of the
> +			communication.

This needs a better description and a vendor prefix if not something 
that should be common.

> +- interrupt-parent:	Phandle for the interrupt controller
> +- interrupts:		Interrupt information corresponding to the
> +			interrupt-names property.
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
> +	/* APU IPI mailbox driver */
> +	ipi_mailbox_rpu0: ipi_mailbox at 0xff90400 {

Don't use '_' or '0x'. Building your dts with W=2 will give you these 
warnings. Also, should be a generic node name, so: "mailbox at ff90400"

> +		compatible = "xlnx,zynqmp-ipi-mailbox";
> +		reg = <0x0 0xff990400 0x0 0x20>,
> +		      <0x0 0xff990420 0x0 0x20>,
> +		      <0x0 0xff990080 0x0 0x20>,
> +		      <0x0 0xff9900a0 0x0 0x20>;
> +		reg-names = "local_request_region", "local_response_region",
> +			    "remote_request_region", "remote_response_region";
> +		#mbox-cells = <1>;
> +		ipi-ids = <0 1>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 29 4>;
> +	};
> +	ipi_mailbox_rpu1: ipi_mailbox at ff990440 {

mailbox at ...

> +		compatible = "xlnx,zynqmp-ipi-mailbox";
> +		reg = <0x0 0xff990440 0x0 0x20>,
> +		      <0x0 0xff990460 0x0 0x20>,
> +		      <0x0 0xff990280 0x0 0x20>,
> +		      <0x0 0xff9902a0 0x0 0x20>;
> +		reg-names = "local_request_region", "local_response_region",
> +			    "remote_request_region", "remote_response_region";
> +		#mbox-cells = <1>;
> +		ipi-ids = <0 2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 29 4>;
> +	};
> +	rpu_subsystem0: rpu_subsystem at 0 {

rpu-subsystem at 0

Though without a reg property, you shouldn't have '@0'.

> +		rpu0 {
> +			...
> +			mbox-clients = <&ipi_mailbox_rpu0 0>,
> +					<&ipi_mailbox_rpu0 1>;
> +			mbox-clients-names = "tx", "rx";
> +		};
> +		rpu1 {
> +			...
> +			mbox-clients = <&ipi_mailbox_rpu1 0>,
> +					<&ipi_mailbox_rpu1 1>;
> +			mbox-clients-names = "tx", "rx";
> +		};
> +	};
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
