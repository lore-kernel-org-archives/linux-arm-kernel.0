From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jul 2015 13:50:29 +0100
Subject: [RFC PATCH 2/2] Documentation: DTS: bindings: add ZynqMP RPU
 remoteproc
In-Reply-To: <1436962975-13918-3-git-send-email-jliang@xilinx.com>
References: <1436962975-13918-1-git-send-email-jliang@xilinx.com>
 <1436962975-13918-3-git-send-email-jliang@xilinx.com>
Message-ID: <20150715125029.GE10239@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 01:22:55PM +0100, Wendy Liang wrote:
> Add documentation about the ZynqMP RPU remoteproc driver
> DTS bindings.
> 
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../bindings/remoteproc/zynqmp_r5_remoteproc.txt   | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/zynqmp_r5_remoteproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/zynqmp_r5_remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/zynqmp_r5_remoteproc.txt
> new file mode 100644
> index 0000000..94c1d00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/zynqmp_r5_remoteproc.txt
> @@ -0,0 +1,49 @@
> +Xilinx ARM Cortex A53-R5 remoteproc driver
> +==========================================
> +
> +ZynqMP family of devices use two Cortex R5 processors to help with various
> +low power / real time tasks.
> +
> +This driver requires specific ZynqMP hardware design.
> +
> +ZynqMP R5 RemoteProc Device Node:
> +=================================
> +A zynqmp_r5_remoteproc device node is used to represent a R5 IP instance
> +within ZynqMP SoC.
> +
> +Required properties:
> +--------------------
> + - compatible : Should be "xlnx,zynqmp-r5-remoteproc-1.0"
> + - reg : Address and length of the register set for the device. It
> +        contains in the same order as described reg-names
> + - reg-names: Contain the register set names. For direct control method,
> +              ipi, rpu_base and apb_base must be provided
> + - interrupts : Interrupt mapping for remoteproc IPI
> + - interrupt-parent : Phandle for the interrupt controller
> +
> +Optional properties:
> +--------------------
> + - firmware : Default firmware image name "rproc-rpu-fw" which can be
> +              loaded by remoteproc framework. This value can be override
> +              by "firmware" module parameter.

The binding shouldn't mention Linux specifics, to the stuff about
modules should go.

Why do you think you need the firmware name in the DT? It breaks
layering (the DT has to know about the user's filesystem), so I'm not
sure that makes much sense.

> + - bootmem : R5 boot device (valid string, ocm or tcm), default is ocm.
> + - core_conf : R5 core configuration (valid string - split0 or split1 or
> +               lock-step), default is lock-step.

What do these mean, when would I choose each?

s/_/-/ in property names.

> + - method : RPU and IPI control method - direct, smc, hvc, default is smc.

Likewise.

> + - ipi_dest_mask : IPI channel destination mask. This is used to clear
> +         ipi SR and let the rpu know the kernel has completed the work.
> +         default mask is "0x100"

We shouldn't encode masks like this in DT.

Could you elaborate on how this is used?

Thanks,
Mark.

> +
> +Example:
> +--------
> +	zynqmp-r5-remoteproc at 0 {
> +		compatible = "xlnx,zynqmp-r5-remoteproc";
> +		reg = <0x0 0x3ed00000 0x800000>, <0x0 0xff300000 0x100>, <0x0 0xff9a0000 0x400>, <0x0 0xff5e0000 0x400>;
> +		reg-names = "shared", "ipi", "rpu_base", "apb_base";
> +		core_conf = "split0";
> +		method = "direct";
> +		bootmem = "ocm";
> +		firmware = "r5_image";
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 49 4>;
> +	} ;
> -- 
> 2.1.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
