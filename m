From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 14 Sep 2011 13:14:08 -0600
Subject: [PATCH v4] power: bq20z75: devicetree init support
In-Reply-To: <1316023462-3287-1-git-send-email-rklein@nvidia.com>
References: <1316023462-3287-1-git-send-email-rklein@nvidia.com>
Message-ID: <CACxGe6uWvWz-8rFVv4HPs_DgoJabV2N0aUQTx7xJ8Zr6thkSMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 12:04 PM, Rhyland Klein <rklein@nvidia.com> wrote:
> Adding support to generate platform data when kernel is configured
> through device tree.
>
> Also adding the binding for the TI bq20z75 fuel gadge and the
> bq20z75 driver.
>
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> ---
> ? ? ? ?v2: Fixed typo in binding description
> ? ? ? ?v3: Changed to use "ti," for properties
> ? ? ? ? ? ?Changed to use single gpio entry for battery detect info.
> ? ? ? ? ? ?Removed unnecessary call to of_match_device.
> ? ? ? ?v4: squashed bindings and drivers changes together.
> ? ? ? ? ? ?fixed case where CONFIG_OF is not selected, to return existing
> ? ? ? ? ? ?pdata pointer if it exists.

Nit: Personally, I'm much happier when the revision list is above the
--- line so it appears in the linux commit text.  That helps when
trying to figure out exactly which posting of a patch got merged.

>
> diff --git a/drivers/power/bq20z75.c b/drivers/power/bq20z75.c
> index 9c5e5be..4c4669e 100644
> --- a/drivers/power/bq20z75.c
> +++ b/drivers/power/bq20z75.c
> @@ -613,6 +613,78 @@ static void bq20z75_delayed_work(struct work_struct *work)
> ? ? ? ?}
> ?}
>
> +#if defined(CONFIG_OF)
> +#include <linux/of_device.h>
> +static const struct of_device_id bq20z75_dt_ids[] = {
> + ? ? ? { .compatible = "ti,bq20z75" },
> + ? ? ? { }
> +};
> +MODULE_DEVICE_TABLE(platform, bq20z75_dt_ids);

MODULE_DEVICE_TABLE(of, ...)

It's not a platform_device_id table.

Otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>
