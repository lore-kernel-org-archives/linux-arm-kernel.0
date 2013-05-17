From: dianders@chromium.org (Doug Anderson)
Date: Fri, 17 May 2013 12:24:04 -0700
Subject: [PATCH 3/6] ARM: SAMSUNG: pm: Adjust for pinctrl- and DT-enabled
 platforms
In-Reply-To: <1368807872-2601-4-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-4-git-send-email-t.figa@samsung.com>
Message-ID: <CAD=FV=XJ=_o+hVbD=pPqXxXo=1PZdeRWyn-xyfS+Jf5LYfe2dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Fri, May 17, 2013 at 9:24 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch makes legacy code on suspend/resume path being executed
> conditionally, on non-DT platforms only, to fix suspend/resume of
> DT-enabled systems, for which the code is inappropriate.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/pm.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 53210ec..8ac2b2d 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -261,7 +261,8 @@ static int s3c_pm_enter(suspend_state_t state)
>          * require a full power-cycle)
>         */
>
> -       if (!any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&
> +       if (!of_have_populated_dt() &&
> +           !any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&

I'd rather see you modify patch set #2 to provide some function to
retrieve just the eint mask and then use it here.  Your patch removes
this test and doesn't replace it with anything.  If you moved this
test to pinctrl directly you'd lose the test against intallow.

...or do you think this test is no longer useful for some reason?


>             !any_allowed(s3c_irqwake_eintmask, s3c_irqwake_eintallow)) {
>                 printk(KERN_ERR "%s: No wake-up sources!\n", __func__);
>                 printk(KERN_ERR "%s: Aborting sleep\n", __func__);
> @@ -270,8 +271,11 @@ static int s3c_pm_enter(suspend_state_t state)
>
>         /* save all necessary core registers not covered by the drivers */
>
> -       samsung_pm_save_gpios();
> -       samsung_pm_saved_gpios();
> +       if (!of_have_populated_dt()) {
> +               samsung_pm_save_gpios();
> +               samsung_pm_saved_gpios();
> +       }
> +

Ah, the important part here is the "saved", not the "save"!  The
"save" should get a NULL chip for all GPIOs and effectively be a
no-op.

Skipping the "saved" is important of s3c64xx and s5p64x0 where the
"saved" seems to transition things over to powerdown mode.  Hopefully
a future patch of yours adds that back for those platforms in the
pinmux world.  ...same for restore.


Summary: I've tested this on exynos5250-snow and it's reasonable but
I'd love a response about the missing test before adding Reviewed-by.

-Doug
