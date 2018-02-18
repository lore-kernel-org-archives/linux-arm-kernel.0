From: mturquette@baylibre.com (Michael Turquette)
Date: Sun, 18 Feb 2018 11:09:25 -0800
Subject: [PATCH 2/3] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <11171053.oOJPuGlHoK@phil>
References: <1516375101-29836-1-git-send-email-geert+renesas@glider.be>
 <1516375101-29836-3-git-send-email-geert+renesas@glider.be>
 <11171053.oOJPuGlHoK@phil>
Message-ID: <CAEG3pNCioW_FVXj3-j4KC_yO6ZYGXQB_eanHWSb9NUE9kYsWag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko, Geert,

On Sat, Feb 10, 2018 at 8:35 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Geert,
>
> Am Freitag, 19. Januar 2018, 16:18:20 CET schrieb Geert Uytterhoeven:
>> As of_clk_get_parent_count() returns zero on failure, while
>> of_count_phandle_with_args() might return a negative error code, this
>> also fixes the issue of possibly using a negative number in the
>> allocation below.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/soc/rockchip/pm_domains.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
>> index 5c342167b9db7a16..9936038d38771784 100644
>> --- a/drivers/soc/rockchip/pm_domains.c
>> +++ b/drivers/soc/rockchip/pm_domains.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>
> not wanting to be to nitpicky, but clk-provider.h seems that it should be
> used from drivers exposing clocks to the system, not from clock users.
>
> I just remember that in the past clk maintainers tried to keep their
> layering intact, so I've included them for clarification.
>
> Mike, Stephen: the power-domain driver of Rockchip socs needs
> to toggle all clocks of domain peripherals when turning a domain
> on or off, so has a variable list of clocks in the clocks property in dt.
> Hence the of_count_... call which could be replaced with
> of_clk_get_parent_count to not open-code this.

Moving of_clk_get_parent_count to clk.h seems reasonable to me. It's
more of an of-specific helper than a provider-specific helper.

Anyone up to submit a patch so that this one doesn't need to include
clk-provider.h?

Regards,
Mike

>
>
> Heiko
>
>>  #include <linux/regmap.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <dt-bindings/power/rk3288-power.h>
>> @@ -391,7 +392,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>>               return -EINVAL;
>>       }
>>
>> -     clk_cnt = of_count_phandle_with_args(node, "clocks", "#clock-cells");
>> +     clk_cnt = of_clk_get_parent_count(node);
>>       pd = devm_kzalloc(pmu->dev,
>>                         sizeof(*pd) + clk_cnt * sizeof(pd->clks[0]),
>>                         GFP_KERNEL);
>>
>
>



-- 
Michael Turquette
CEO
BayLibre - At the Heart of Embedded Linux
http://baylibre.com/
