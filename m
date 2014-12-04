From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 4 Dec 2014 14:41:25 +0100
Subject: [PATCH v6 3/7] ARM: shmobile: R-Mobile: Enable module clocks if
 !CONFIG_PM_RUNTIME
In-Reply-To: <1417614107-5985-4-git-send-email-geert+renesas@glider.be>
References: <1417614107-5985-1-git-send-email-geert+renesas@glider.be>
 <1417614107-5985-4-git-send-email-geert+renesas@glider.be>
Message-ID: <CAPDyKFogROGA+MtQcGNfa052wPKxcs9cpT43NcpcyeGVFCwPoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2014 at 14:41, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> If CONFIG_PM_RUNTIME is not set, the clocks must be enabled before the
> devices can be used.
>
> Currently these clocks are enabled by the !CONFIG_PM_RUNTIME version of
> pm_clk_notify, activated by the hack in drivers/sh/pm_runtime.c, but
> this will go away soon (at least for DT).
>
> On detach, disabling the clocks is already handled by pm_clk_destroy().
> On system suspend/resume, disabling/enabling clocks is already handled
> from the genpd->dev_ops.{start,stop}() callbacks.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v6:
>   - No changes,
> v5:
>   - No changes,
> v4:
>   - New.
> ---
>  arch/arm/mach-shmobile/pm-rmobile.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
> index 168046c355fc8368..6d912ce801aa88bd 100644
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -118,6 +118,14 @@ static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
>                 goto fail;
>         }
>
> +       if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {

This will require a fixup later on, since using genpd will always be
done for CONFIG_PM_RUNTIME (or CONFIG_PM actually) ).

I guess you knew that already, but then you can't keep my response as
a reminder. :-)

Kind regards
Uffe

> +               error = pm_clk_resume(dev);
> +               if (error) {
> +                       dev_err(dev, "pm_clk_resume failed %d\n", error);
> +                       goto fail;
> +               }
> +       }
> +
>         return 0;
>
>  fail:
> --
> 1.9.1
>
