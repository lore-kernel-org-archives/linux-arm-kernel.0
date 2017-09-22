From: jliang@xilinx.com (Jiaying Liang)
Date: Fri, 22 Sep 2017 06:05:18 +0000
Subject: [RFC LINUX PATCH] Dcoumentation: dt: mailbox: Add Xilinx IPI
 Mailbox
In-Reply-To: <1506034724-14639-1-git-send-email-jliang@xilinx.com>
References: <1506034724-14639-1-git-send-email-jliang@xilinx.com>
Message-ID: <BY1PR0201MB0885E6563EBAFE83DF8822A4B0670@BY1PR0201MB0885.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wendy Liang [mailto:wendy.liang at xilinx.com]
> Sent: Thursday, September 21, 2017 3:59 PM
> To: linux-kernel at vger.kernel.org
> Cc: jassisinghbrar at gmail.com; Cyril Chemparathy <cyrilc@xilinx.com>;
> Michal Simek <michals@xilinx.com>; Jiaying Liang <jliang@xilinx.com>
> Subject: [RFC LINUX PATCH] Dcoumentation: dt: mailbox: Add Xilinx IPI
> Mailbox
> 
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block in ZynqMP
> SoC used for the communication between various processor systems.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 88
> ++++++++++++++++++++++
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
> +- reg:			IPI request and response buffers address range. It
> +			can be the IPI buffers from the hardware or it can
> +			be carved out shared memory.
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
> +	};
> +	device0: device0 {
> +		...
> +		mbox-names = "rpu0", "rpu1",
> +		mboxes = <&ipi_mailbox_apu_rpu0 0>,
> +			 < &ipi_mailbox_apu_rpu1 0>;
> +	};
> --
> 2.7.4

cc: device tree and linux arm kernel mailing lists.
