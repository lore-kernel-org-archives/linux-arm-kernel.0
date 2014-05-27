From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 27 May 2014 15:58:05 +0530
Subject: [PATCH/RFC V6 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
References: <1400520171-6698-1-git-send-email-s.nawrocki@samsung.com>
 <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <538468B5.6090505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2014 10:52 PM, Sylwester Nawrocki wrote:
> This patch adds a helper function to configure clock parents and
> rates as specified in clock-parents, clock-rates DT properties
> for a consumer device and a call to it before driver is bound to
> a device.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ ... ]

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 5b47210..f622733 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/idr.h>
>  #include <linux/acpi.h>
> +#include <linux/clk/clk-conf.h>
> 
>  #include "base.h"
>  #include "power/power.h"
> @@ -486,6 +487,10 @@ static int platform_drv_probe(struct device *_dev)
>  	struct platform_device *dev = to_platform_device(_dev);
>  	int ret;
> 
> +	ret = of_clk_set_defaults(_dev->of_node, false);
> +	if (ret < 0)
> +		return ret;
> +

of_clk_set_defaults() is not getting called when the related driver is
not registered through platform_driver_register().

I came across this issue while testing this patch on peach-pit board with
following dts change. max98090 audio codec driver is registered through
module_i2c_driver().

* arch/arm/boot/dts/exynos5420-peach-pit.dts

&hsi2c_7 {

	status = "okay";

	max98090: codec at 10 {
		compatible = "maxim,max98090";
		reg = <0x10>;
		interrupts = <2 0>;
		interrupt-parent = <&gpx0>;
		pinctrl-names = "default";
		pinctrl-0 = <&max98090_irq>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
+		clock-parents = <&clock CLK_FIN_PLL>;
+		clock-rates = <24000000>;
	};
};

-- 
Tushar Behera
