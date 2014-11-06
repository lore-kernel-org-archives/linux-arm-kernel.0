From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 6 Nov 2014 10:09:56 -0800
Subject: [RFC PATCH v4 3/3] PM / clock_ops: add and enable clocks always
 if !CONFIG_PM_RUNTIME
In-Reply-To: <1415281862-23764-4-git-send-email-grygorii.strashko@ti.com>
References: <1415281862-23764-1-git-send-email-grygorii.strashko@ti.com>
 <1415281862-23764-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141106180956.GE34214@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 03:51:02PM +0200, Grygorii Strashko wrote:
> Device's clocks need to be enabled always at probing time
> if !CONFIG_PM_RUNTIME - in that way, device will become accesible
> and, later, its clocks can be disabled/enabled during system
> suspend/resume by using pm_clk_suspend/pm_clk_resume APIs.
> 
> But now, the clocks management code doesn't enable clocks when
> clocks are being registered per-device by using pm_clk_add/_clk().
> So, update pm_clk_acquire(), which is called from pm_clk_add/_clk(),
> to enable clock always if !CONFIG_PM_RUNTIME.
> 
> Also, Platform PM domains drivers will not have to add code like below
> each time they need to handle the case when !CONFIG_PM_RUNTIME [1 - 3]:
> 
>        if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
>                ret = pm_clk_resume(dev);
>                if (ret) {
>                        dev_err(dev, "pm_clk_resume failed %d\n", ret);
>                        goto clk_err;
>                };
>        }
> 
> [1] https://lkml.org/lkml/2014/10/3/306
> [2] https://lkml.org/lkml/2014/10/16/305
> [3] https://lkml.org/lkml/2014/10/20/249
> 
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Kevin Hilman <khilman@linaro.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> CC: Caesar Wang <caesar.wang@rock-chips.com>
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Hi,
> 
> I marked it as RFC, because:
>   Generic clock manipulation PM callbacks can be used for any device
>   for which list of clocks need to be maintained - and it doesn't mean
>   that this framework need to be always connected to GPD/Runtime PM or
>   used during suspend resume. Also, for DT-use case - it doesn't perform
>   any actions (except clk_prepare) on clocks by itself and only
>   by request from framework's consumer.
> 
>  For example, it can be reused by Power domain/controller drivers like:
>  - Rockchip RK3288 PM Domain (https://lkml.org/lkml/2014/11/6/30)
>  - IMX.6 PU power domain (http://www.spinics.net/lists/arm-kernel/msg360709.html)
> 
>  to maintain list of clocks for GPD itself and these clocks should not
>  be enabled by default, because they are used to power on/off Power domain
>  in a specific way:
>      - enable all clocks assigned to PD
>      - power on/off PD
>      - disable all clocks assigned to PD.
>  After this patch it will be impossible to reuse Generic clock manipulation PM
>  callbacks in cases described above.

I'd rather keep it separate and concentrate on making pm_clk* code
working with the power management core. Individual drivers can easily
keep list of their clocks for whatever additional purpose they need
without involving pm_clk* API.

Thanks.

-- 
Dmitry
