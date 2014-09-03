From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 03 Sep 2014 10:07:15 +0200
Subject: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
In-Reply-To: <1409710239-19941-3-git-send-email-caesar.wang@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <1409710239-19941-3-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <11280986.L6lv82O8Qv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar Wang:
> This add the necessary binding documentation for the thermal
> found on Rockchip SoCs
> 
> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  .../devicetree/bindings/thermal/rockchip-thermal.txt | 20
> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt new file
> mode 100644
> index 0000000..1ed4d4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -0,0 +1,20 @@
> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> +
> +Required properties:
> +- compatible: "rockchip,rk3288-tsadc"
> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier
> format +	      depends on the interrupt controller.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb_pclk" for
> +	       the peripheral clock.

You're using the passive-temp, critical-temp and force-shut-temp properties in 
your driver without declaring them here.

But more importantly, please use the generic trip-points for this. I guess it 
shouldn't be a problem to introduce a "forced-shutdown" trippoint [0] for the 
additional trip-point you have - thermal maintainers, please shout if I'm 
wrong :-)


Heiko


[0] in a separate patch, changing
- thermal_trip_type enum in include/linux/thermal.h
- trip_types mapping in drivers/thermal/of-thermal.c
- Documentation/devicetree/bindings/thermal/thermal.txt

> +
> +Example:
> +tsadc: tsadc at ff280000 {
> +	compatible = "rockchip,rk3288-tsadc";
> +	reg = <0xff280000 0x100>;
> +	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> +	clock-names = "tsadc", "apb_pclk";
> +};
