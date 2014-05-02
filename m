From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 2 May 2014 10:56:23 +0200
Subject: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM
 with the PM core
In-Reply-To: <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
Message-ID: <CAPDyKFpTwPDu9afhOjhhQ2PKGFB+hWsp=mcaYTq8OvuGF7yT3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Geert,

Some more review comments.

> +
> +
> +#ifdef CONFIG_PM_RUNTIME
> +
> +static int of_clk_pm_runtime_suspend(struct device *dev)
> +{
> +       int ret;
> +
> +       ret = pm_generic_runtime_suspend(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = pm_clk_suspend(dev);

What about slow clocks? Those aren't handled with pm_clk_suspend().

> +       if (ret) {
> +               pm_generic_runtime_resume(dev);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int of_clk_pm_runtime_resume(struct device *dev)
> +{
> +       pm_clk_resume(dev);

What about slow clocks? Those aren't handled with pm_clk_resume().

> +       return pm_generic_runtime_resume(dev);
> +}
> +
> +static struct dev_pm_domain of_clk_pm_domain = {
> +       .ops = {
> +               .runtime_suspend = of_clk_pm_runtime_suspend,
> +               .runtime_resume = of_clk_pm_runtime_resume,

Drivers/subsystems may invoke pm_runtime_force_suspend|resume() from
some of their system PM callbacks, which requires the runtime PM
callbacks to be defined for CONFIG_PM instead of CONFIG_PM_RUNTIME, I
believe that should be changed here as well.

> +               USE_PLATFORM_PM_SLEEP_OPS

What about other buses beside the platfrom bus. Certainly we need to
handle devices attached to any other subsystem type as well.

Kind regards
Ulf Hansson
