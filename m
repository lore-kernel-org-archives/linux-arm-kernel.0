From: per.forlin@stericsson.com (Per Forlin)
Date: Thu, 15 Mar 2012 16:12:21 +0100
Subject: [PATCH 3/5] MMC: mmci: Add generic Device Tree bindings to mmci
 core code
In-Reply-To: <1331734803-17954-4-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CAFEEs1mQr4hDC6RuvchfWe7HNq67Eh2bPtwyWN-tukw32-V0rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 3:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
> This adds the necessary bindings for collection of shared
> attributes used in the mmci driver.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?drivers/mmc/host/mmci.c | ? 43 +++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 43 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 23b41a5..9132ca8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -30,6 +30,7 @@
> ?#include <linux/dma-mapping.h>
> ?#include <linux/amba/mmci.h>
> ?#include <linux/pm_runtime.h>
> +#include <linux/of_gpio.h>
>
> ?#include <asm/div64.h>
> ?#include <asm/io.h>
> @@ -1056,11 +1057,47 @@ static const struct mmc_host_ops mmci_ops = {
> ? ? ? ?.get_cd ? ? ? ? = mmci_get_cd,
> ?};
>
> +#ifdef CONFIG_OF
> +static void mmci_dt_populate_generic_pdata(struct device_node *np,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct mmci_platform_data *pdata)
> +{
> + ? ? ? const void *prop;
> + ? ? ? int len;
> +
> + ? ? ? of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
> + ? ? ? if (!pdata->gpio_wp)
> + ? ? ? ? ? ? ? pdata->gpio_wp = -1;
> +
> + ? ? ? of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
> + ? ? ? if (!pdata->gpio_cd)
> + ? ? ? ? ? ? ? pdata->gpio_cd = -1;
> +
> + ? ? ? if (of_get_property(np, "cd-invert", NULL))
> + ? ? ? ? ? ? ? pdata->cd_invert = true;
> + ? ? ? else
> + ? ? ? ? ? ? ? pdata->cd_invert = false;
> +
> + ? ? ? of_property_read_u32(np, "clock_frequency", &pdata->f_max);
> + ? ? ? if (!pdata->f_max)
> + ? ? ? ? ? ? ? pr_warning("%s has no 'clock_frequency' property\n", np->full_name);
> +
> + ? ? ? if (of_get_property(np, "mmc_cap_4_bit_data", NULL))
I have no previous experience with DT. Could you please bring some
light on this.
Is it really necessary to represent each bit in the CAP with a string?
To add CAP_ERASE for instance I need to change the code here and
update the DT, right?

BR
Per
