From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 13 Jun 2014 17:08:33 +0200
Subject: [PATCH/RFC V6 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <538468B5.6090505@linaro.org>
References: <1400520171-6698-1-git-send-email-s.nawrocki@samsung.com>
 <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
 <538468B5.6090505@linaro.org>
Message-ID: <539B13F1.8090804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/14 12:28, Tushar Behera wrote:
> On 05/19/2014 10:52 PM, Sylwester Nawrocki wrote:
>> This patch adds a helper function to configure clock parents and
>> rates as specified in clock-parents, clock-rates DT properties
>> for a consumer device and a call to it before driver is bound to
>> a device.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> [ ... ]
> 
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 5b47210..f622733 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/idr.h>
>>  #include <linux/acpi.h>
>> +#include <linux/clk/clk-conf.h>
>>
>>  #include "base.h"
>>  #include "power/power.h"
>> @@ -486,6 +487,10 @@ static int platform_drv_probe(struct device *_dev)
>>  	struct platform_device *dev = to_platform_device(_dev);
>>  	int ret;
>>
>> +	ret = of_clk_set_defaults(_dev->of_node, false);
>> +	if (ret < 0)
>> +		return ret;
>> +
> 
> of_clk_set_defaults() is not getting called when the related driver is
> not registered through platform_driver_register().
> 
> I came across this issue while testing this patch on peach-pit board with
> following dts change. max98090 audio codec driver is registered through
> module_i2c_driver().

Yes, that shouldn't be surprising, since now in this RFC the clocks setting
is done only for platform bus devices. Similarly the above call would need to
be added to i2c, amba, spi and maybe other busses.

We just need to be careful to avoid attempting to set up clocks of a clock
provider device before it is probed and actually registers its clocks.

I'm still not sure if we should carry on with this approach or do all the
clocks set up in one place, similarly to disabling unused clocks. I'm afraid
when attempting to set up all clocks at one point in time the clock parent/rate
dependencies may get even more hairy.

The deferred probe mechanism helps to resolve the dependencies when the
clock defaults setting is done before or within a driver probe() call. Either
for clock supplier and consumer nodes or a supplier only.

> * arch/arm/boot/dts/exynos5420-peach-pit.dts
> 
> &hsi2c_7 {
> 
> 	status = "okay";
> 
> 	max98090: codec at 10 {
> 		compatible = "maxim,max98090";
> 		reg = <0x10>;
> 		interrupts = <2 0>;
> 		interrupt-parent = <&gpx0>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&max98090_irq>;
> +		clocks = <&pmu_system_controller 0>;
> +		clock-names = "mclk";
> +		clock-parents = <&clock CLK_FIN_PLL>;
> +		clock-rates = <24000000>;
> 	};
> };

--
Regards,
Sylwester
