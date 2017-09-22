From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 22 Sep 2017 12:10:05 +0100
Subject: [RFC LINUX PATCH] Dcoumentation: dt: mailbox: Add Xilinx IPI
 Mailbox
In-Reply-To: <BY1PR0201MB0885E6563EBAFE83DF8822A4B0670@BY1PR0201MB0885.namprd02.prod.outlook.com>
References: <1506034724-14639-1-git-send-email-jliang@xilinx.com>
 <BY1PR0201MB0885E6563EBAFE83DF8822A4B0670@BY1PR0201MB0885.namprd02.prod.outlook.com>
Message-ID: <20170922111005.GA11613@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 06:05:18AM +0000, Jiaying Liang wrote:
> 
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block in ZynqMP
> SoC used for the communication between various processor systems.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-
> mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-
> mailbox.txt
> new file mode 100644
> index 0000000..5d915d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.
> +++ txt
> @@ -0,0 +1,88 @@
> +Xilinx IPI Mailbox Driver
> +========================================
> +
> +The Xilinx IPI(Inter Processor Interrupt) mailbox driver is a mailbox
> +controller that manages the messaging between two IPI agents. Each IPI
> +mailbox has request and response buffers between the two IPI agents.
> +
> ++-------------------------------------+
> +|                                     | Xilinx ZynqMP IPI Mailbox
> +| Controller|
> +|                                     |
> +|                       +-------------+
> +|                       |     SMC     |
> +|                       |             |
> ++--------+--------------+------+------+
> +         |                     |
> +         |          +-----------------+
> +         |                     |   ATF (ARM trusted firmware)

I suppose it should work with any EL3 firmware, ATF reference can be
removed IMO.

> +         |                     |
> ++-------------------------------------+
> +         |                     |   Hardware
> +         |                     |
> + +--------------------------------------+
> +                               |        |
> + +----------------------+ +-----------+ |
> + | | Buffers between    | | IPI Agent | |
> + | | two IPI agents     | | Registers | |
> + | +--------------------+ +-----------+ |
> + |                                      |
> + |   Xilinx ZynqMP IPI                  |
> + +--------------------------------------+
> +
> +
> +Message Manager Device Node:
> +===========================
> +Required properties:
> +--------------------
> +- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> +- ipi-smc-fid-base	Base offset of SMC function IDs for IPI mailbox SMC.
> +			It contains the IPI IDs of the two IPI agents.

Why is "SMC" associated with this hardware block ? Is it secure device ?
Can Linux access it ? If so, why do you need SMC ?

> +- reg:			IPI request and response buffers address range. It
> +			can be the IPI buffers from the hardware or it can
> +			be carved out shared memory.

It sounds like buffer used for communication and not part of this IP.
Shouldn't this be part of mailbox client binding rather than controller
binding.

> +- reg-names:		Reg resource name of the IPI request and response
> +			buffers.
> +- #mbox-cells:		Shall be 1. Contains the logical channel IDs of the
> +			channels on the IPI mailbox.
> +- interrupt-parent:	Phandle for the interrupt controller.
> +- interrupts:		Interrupt mapping.
> +
> +Required properties:
> +--------------------
> +- method:		The method of accessing the IPI agent registers.
> +			Permitted values are: "smc" and "hvc". Default is
> +			"smc".
> +Example:
> +------------
> +	/* APU IPI mailbox driver */
> +	ipis {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ipi_mailbox_apu_rpu0: ipi_mailbox at 0 {
> +			compatible = "xlnx,zynqmp-ipi-mailbox";
> +			reg = <0 0xff990400 40>;
> +			reg-names = "apu-rpu0";
> +			ipi-smc-fid-base = <0x1010>;
> +			method = "smc";
> +			#mbox-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 35 4>;
> +		};
> +		ipi_mailbox_apu_rpu1: ipi_mailbox at 1 {
> +			compatible = "xlnx,zynqmp-ipi-mailbox";
> +			reg = <0 0xff990440 40>;
> +			reg-names = "apu-rpu1";
> +			ipi-smc-fid-base = <0x1020>;
> +			method = "smc";
> +			#mbox-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 35 4>;
> +		};

Why do you need the above 2 ? They don't look like 2 controller blocks.
You just need to represent single mailbox controller.

--
Regards,
Sudeep
