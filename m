From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 17 Feb 2013 22:57:36 +0800
Subject: [PATCH v2 3/8] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to System Reset Controller (SRC)
In-Reply-To: <1360776872-18584-4-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-4-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130217145734.GE6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:34:27PM +0100, Philipp Zabel wrote:
> The SRC has auto-deasserting reset bits that control reset lines to
> the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
> controller that can be controlled by those devices using the
> reset controller API.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changes since v1:
>  - Removed .is_asserted op.
>  - Added struct reset_controller_dev pointer to .reset op.
> ---
>  .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 ++++++++++++++++++
>  arch/arm/mach-imx/src.c                            |   54 ++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
> new file mode 100644
> index 0000000..1330177
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
> @@ -0,0 +1,49 @@
> +Freescale i.MX System Reset Controller
> +======================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be "fsl,<chip>-src"
> +- reg: should be register base and length as documented in the
> +  datasheet
> +- interrupts: Should contain SRC interrupt and CPU WDOG interrupt,
> +  in this order.
> +- #reset-cells: 1, see below
> +
> +example:
> +
> +src: src at 020d8000 {
> +        compatible = "fsl,imx6q-src";
> +        reg = <0x020d8000 0x4000>;
> +        interrupts = <0 91 0x04 0 96 0x04>;
> +        #reset-cells = <1>;
> +};
> +
> +Specifying reset lines connected to IP modules
> +==============================================
> +
> +The system reset controller can be used to reset the GPU, VPU,
> +IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
> +nodes should specify the reset line on the SRC in their resets
> +property, containing a phandle to the SRC device node and a
> +RESET_INDEX specifying which module to reset, as described in
> +reset.txt
> +
> +example:
> +
> +        ipu1: ipu at 02400000 {
> +                resets = <&src 2>;
> +        };
> +        ipu2: ipu at 02800000 {
> +                resets = <&src 4>;
> +        };
> +
> +The following RESET_INDEX values are valid for i.MX5:
> +GPU_RESET     0
> +VPU_RESET     1
> +IPU1_RESET    2
> +OPEN_VG_RESET 3
> +The following additional RESET_INDEX value is valid for i.MX6:
> +IPU2_RESET    4
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> index e15f155..3228484 100644
> --- a/arch/arm/mach-imx/src.c
> +++ b/arch/arm/mach-imx/src.c
> @@ -14,17 +14,68 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/reset-controller.h>
>  #include <linux/smp.h>
>  #include <asm/smp_plat.h>
>  
>  #define SRC_SCR				0x000
>  #define SRC_GPR1			0x020
>  #define BP_SRC_SCR_WARM_RESET_ENABLE	0
> +#define BP_SRC_SCR_SW_GPU_RST		1
> +#define BP_SRC_SCR_SW_VPU_RST		2
> +#define BP_SRC_SCR_SW_IPU1_RST		3
> +#define BP_SRC_SCR_SW_OPEN_VG_RST	4
> +#define BP_SRC_SCR_SW_IPU2_RST		12
>  #define BP_SRC_SCR_CORE1_RST		14
>  #define BP_SRC_SCR_CORE1_ENABLE		22
>  
>  static void __iomem *src_base;
>  
> +static int sw_reset_bits[5] = {
> +	BP_SRC_SCR_SW_GPU_RST,
> +	BP_SRC_SCR_SW_VPU_RST,
> +	BP_SRC_SCR_SW_IPU1_RST,
> +	BP_SRC_SCR_SW_OPEN_VG_RST,
> +	BP_SRC_SCR_SW_IPU2_RST
> +};
> +
> +static int imx_src_reset_module(struct reset_controller_dev *rcdev,
> +		unsigned long sw_reset_idx)
> +{
> +	unsigned long timeout;
> +	int bit;
> +	u32 val;
> +
> +	if (!src_base)
> +		return -ENODEV;
> +
> +	if (sw_reset_idx >= ARRAY_SIZE(sw_reset_bits))
> +		return -EINVAL;
> +
> +	bit = 1 << sw_reset_bits[sw_reset_idx];
> +
> +	val = readl_relaxed(src_base + SRC_SCR);
> +	val |= bit;
> +	writel_relaxed(val, src_base + SRC_SCR);

Now, SRC_SCR is read/modify/write in a few contexts.  I'm wondering if
we need some locking mechanism protecting against it.

Shawn

> +
> +	timeout = jiffies + msecs_to_jiffies(1000);
> +	while (readl(src_base + SRC_SCR) & bit) {
> +		if (time_after(jiffies, timeout))
> +			return -ETIME;
> +		cpu_relax();
> +	}
> +
> +	return 0;
> +}
> +
> +static struct reset_control_ops imx_src_ops = {
> +	.reset = imx_src_reset_module,
> +};
> +
> +static struct reset_controller_dev imx_reset_controller = {
> +	.ops = &imx_src_ops,
> +};
> +
>  void imx_enable_cpu(int cpu, bool enable)
>  {
>  	u32 mask, val;
> @@ -65,6 +116,9 @@ void __init imx_src_init(void)
>  	src_base = of_iomap(np, 0);
>  	WARN_ON(!src_base);
>  
> +	imx_reset_controller.of_node = np;
> +	reset_controller_register(&imx_reset_controller);
> +
>  	/*
>  	 * force warm reset sources to generate cold reset
>  	 * for a more reliable restart
> -- 
> 1.7.10.4
> 
