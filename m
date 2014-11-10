From: dianders@chromium.org (Doug Anderson)
Date: Mon, 10 Nov 2014 14:42:06 -0800
Subject: [PATCH v7 2/5] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <1415368177-6637-3-git-send-email-zyw@rock-chips.com>
References: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
 <1415368177-6637-3-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=Wdw5OqSv3Zbw=wd19swaRV6QtNdVAzdTf4pCV37r4MKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Fri, Nov 7, 2014 at 5:49 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> It's a basic version of suspend and resume for rockchip,
> it only support RK3288 now.
>
> Signed-off-by: Tony Xie <xxx@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v7:
> - get rid all of unused code
>
> Changes in v6:
> - get rid of the save/restore of SRAM
> - doing the copy of resume code once at init time
> - remove ROCKCHIP_ARM_OFF_LOGIC_DEEP from rk3288_fill_in_bootram
> - add of_platform_populate in rockchip_dt_init
>
> Changes in v5:
> - use rk3288_bootram_sz for memcpy size
> - fixed error of sram save and restore
>
> Changes in v4:
> - remove grf regmap
>
> Changes in v3:
> - move the pinmux of gpio6_c6 save and restore to pinctrl-rockchip
>
> Changes in v2:
> - add the regulator calls in prepare and finish.
> - add the pinmux of gpio6_c6 save and restore
>
>  arch/arm/mach-rockchip/Makefile   |   1 +
>  arch/arm/mach-rockchip/pm.c       | 264 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-rockchip/pm.h       |  99 ++++++++++++++
>  arch/arm/mach-rockchip/rockchip.c |   2 +
>  arch/arm/mach-rockchip/sleep.S    |  73 +++++++++++
>  5 files changed, 439 insertions(+)

I haven't done a full re-review of this version, but...


> +static int rk3288_suspend_iomap(void)
> +{
> +       struct device_node *node;
> +       struct resource res;
> +
> +       node = of_find_compatible_node(NULL, NULL, "rockchip,rk3288-pmu-sram");
> +       if (!node) {
> +               pr_err("%s: could not find bootram dt node\n", __func__);
> +               return -1;
> +       }
> +
> +       rk3288_bootram_base = of_iomap(node, 0);
> +       if (!rk3288_bootram_base) {
> +               pr_err("%s: could not map bootram base\n", __func__);
> +               return -1;
> +       }
> +
> +       if (of_address_to_resource(node, 0, &res)) {
> +               pr_err("%s: could not get bootram phy addr\n", __func__);
> +               return -1;
> +       }
> +
> +       rk3288_bootram_phy = res.start;
> +
> +       /* copy resume code and data to bootsram */
> +       memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
> +              rk3288_bootram_sz);
> +
> +       rk3288_config_bootdata();

Note that much of the above is no longer really part of the "iomap".
It should probably be moved out into "rk3288_suspend_init".
