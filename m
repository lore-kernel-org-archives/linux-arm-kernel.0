From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 Apr 2016 10:52:00 +0200
Subject: [PATCH 2/2] mmc: omap_hsmmc: Check if MMC slot name is passed in
 pdata
In-Reply-To: <1461714383-9956-3-git-send-email-tony@atomide.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-3-git-send-email-tony@atomide.com>
Message-ID: <CAPDyKFqCMfBx=VFy05MNDhO5ZpLw9x=Xmdst9JR0zHy+GHYJyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2016 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> The legacy user space for n900 relies on the MMC slot names.
> Let's check if those are passed in pdata and use them.
>
> Then when we have a generic MMC slot name binding we can
> switch to use that assuming it works for the n900 legacy
> user space too.

I dropped this section, because I don't think it will happen.

>
> As this makes the DT booting compatible with legacy booting,
> we should be able to start dropping omap3 legacy booting
> support in v4.8.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Ulf, this is safe to pick separately to the MMC tree if it looks
> acceptable to you.
>
>
>  drivers/mmc/host/omap_hsmmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e9d75c6..3563321 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1946,13 +1946,17 @@ MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>
>  static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>  {
> -       struct omap_hsmmc_platform_data *pdata;
> +       struct omap_hsmmc_platform_data *pdata, *legacy;
>         struct device_node *np = dev->of_node;
>
>         pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>         if (!pdata)
>                 return ERR_PTR(-ENOMEM); /* out of memory */
>
> +       legacy = dev_get_platdata(dev);
> +       if (legacy && legacy->name)
> +               pdata->name = legacy->name;
> +
>         if (of_find_property(np, "ti,dual-volt", NULL))
>                 pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
>
> --
> 2.8.1
>
