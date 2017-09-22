From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Sep 2017 15:09:51 +0200
Subject: [PATCH] pinctrl: samsung: add pinctrl_force_sleep() for "sleep"
 pinctrl state
In-Reply-To: <006801d332d5$b0ca09d0$125e1d70$@samsung.com>
References: <CGME20170921123230epcas1p4d3c1de108af7d34053d2c4f40dd42119@epcas1p4.samsung.com>
 <006801d332d5$b0ca09d0$125e1d70$@samsung.com>
Message-ID: <CACRpkdZSCyEWWptfSHr+EOW-RVh4sgVT5yNkiVqZs=nXwHxZGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 2:32 PM, ??? <youngmin.nam@samsung.com> wrote:

I'm copying the whole patch so that everyone added to To: can see it.

> This patch adds pinctrl_for_sleep() in samsung_pinctrl_suspend()
> to support configuration of "sleep" pinctrl state.
>
> For example, we can configure "sleep" pinctrl state of "gpf1-6"
> as "INPUT, PULL DOWN" by configuring power down mode register.
>
> &pinctrl_5 {
>         pinctrl-names = "default","sleep";
>         pinctrl-0 = <&initial5>;
>         pinctrl-1 = <&sleep5>;
>
>         initial5: initial-state {
>                 samsung,pins = gpf1-6;
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
>         };
>         sleep5: sleep-state {
>                 samsung,pins = gpf1-6;
>                 samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
>                 samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_DOWN>;
>         };
> };
>
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index e04f7fe0a65d..b4d12f8db475 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1099,6 +1099,11 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
>  {
>         struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
>         int i;
> +       int ret;
> +
> +       ret = pinctrl_force_sleep(drvdata->pctl_dev);
> +       if (ret)
> +               dev_err(dev, "could not set sleep pinstate %d\n", ret);
>
>         for (i = 0; i < drvdata->nr_banks; i++) {
>                 struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
> @@ -1187,6 +1192,11 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
>         if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
>                 drvdata->retention_ctrl->disable(drvdata);
>
> +       /* For changing state without writing register. */
> +       if (!IS_ERR(drvdata->pctl_dev->p) &&
> +           !IS_ERR(drvdata->pctl_dev->hog_default))
> +               drvdata->pctl_dev->p->state = drvdata->pctl_dev->hog_default;
> +
>         return 0;
>  }

Oddly this business of forcing the hardware into different "sleep" states
is coming up from the left and right at the moment.

Please check a bit at:
commit 6606bc9dee63 ("pinctrl: Add sleep related state to indicate
sleep related configs")
and how the Spreadtrum driver handles this.

That is for the case where the hardware autonomously defines
a sleep state that need to be programmed from somewhere.

This seems to be what this hardware needs to use?

Yours,
Linus Walleij
