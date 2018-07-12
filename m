From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 12 Jul 2018 15:54:28 +0200
Subject: [PATCH] ARM: dts: imx6sl: Add vivante gpu nodes
In-Reply-To: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
References: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
Message-ID: <1531403668.3163.72.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 12.07.2018, 16:37 +0300 schrieb Leonard Crestez:
> The imx6sl soc has gpu_2d and gpu_vg, no 3d support:
> 
> etnaviv-gpu 2200000.gpu: model: GC320, revision: 5007
> etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> 
> The IP blocks are close enough to supported hardware that they "just
> work" with etnaviv and x11.

According to the kernel log above, they aren't just close enough, but
actually the same revision as the cores on the i.MX6Q.

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

I think this DT is ordered by unit address, so both GPU nodes should
move to the end of the dts file, right?

With this fixed:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> 
> ---
> ?arch/arm/boot/dts/imx6sl.dtsi | 20 ++++++++++++++++++++
> ?1 file changed, 20 insertions(+)
> 
> Tested by using yocto fsl community bsp built in "mainline" mode.
> This
> patch makes x11 start up and turning on drm.debug shows that the
> etnaviv
> driver is being used.
> 
> I don't know if such a patch requires much more testing: all it
> really
> does is "describe the hardware".
> 
> Patch is against shawguo/imx/dt, it depends on newly accepted
> commit 13211eec7b0e ("ARM: dts: imx6sl: Convert gpc to new bindings")
> This is only because of the way it references the PU power domain.
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> b/arch/arm/boot/dts/imx6sl.dtsi
> index a6bc21433839..49a56b4fd393 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -130,10 +130,30 @@
> ?			cache-level = <2>;
> ?			arm,tag-latency = <4 2 3>;
> ?			arm,data-latency = <4 2 3>;
> ?		};
> ?
> +		gpu_2d: gpu at 2200000 {
> +			compatible = "vivante,gc";
> +			reg = <0x02200000 0x4000>;
> +			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +				?<&clks IMX6SL_CLK_GPU2D_OVG>;
> +			clock-names = "bus", "core";
> +			power-domains = <&pd_pu>;
> +		};
> +
> +		gpu_vg: gpu at 2204000 {
> +			compatible = "vivante,gc";
> +			reg = <0x02204000 0x4000>;
> +			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +				?<&clks IMX6SL_CLK_GPU2D_OVG>;
> +			clock-names = "bus", "core";
> +			power-domains = <&pd_pu>;
> +		};
> +
> ?		aips1: aips-bus at 2000000 {
> ?			compatible = "fsl,aips-bus", "simple-bus";
> ?			#address-cells = <1>;
> ?			#size-cells = <1>;
> ?			reg = <0x02000000 0x100000>;
