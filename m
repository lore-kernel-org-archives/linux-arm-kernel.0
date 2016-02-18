From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 18 Feb 2016 18:46:40 +0100
Subject: [BUG FIX] PM / cpu_domains: Check for NULL callbacks
In-Reply-To: <1455816573-43849-1-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-4-git-send-email-lina.iyer@linaro.org>
 <1455816573-43849-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAJZ5v0gXd573OM_xQBsqqaZoRWvT_px64Cx2avR5dCxCwmMWjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 6:29 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Check for NULL platform callback before calling.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/cpu_domains.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
> index 7069411..bcaa474 100644
> --- a/drivers/base/power/cpu_domains.c
> +++ b/drivers/base/power/cpu_domains.c
> @@ -157,16 +157,22 @@ static int cpu_pd_power_on(struct generic_pm_domain *genpd)
>  {
>         struct cpu_pm_domain *pd = to_cpu_pd(genpd);
>
> -       return pd->ops.power_on();
> +       if (pd->ops.power_on)
> +               return pd->ops.power_on();
> +
> +       return 0;
>  }

I usually write things like that as

return pd->ops.power_on ? pd->ops.power_on() : 0;

That gets the job done in just one line of code instead of 4 and in
one statement instead of 3.

Thanks,
Rafael
