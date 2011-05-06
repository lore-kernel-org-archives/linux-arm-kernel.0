From: charu@ti.com (Varadarajan, Charulatha)
Date: Fri, 6 May 2011 18:56:36 +0530
Subject: [PATCH V2 16/16] mmc: omap_hsmmc: add a hardware reset before
	initialization
In-Reply-To: <1304673255-31634-17-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<1304673255-31634-17-git-send-email-adrian.hunter@nokia.com>
Message-ID: <BANLkTim3aZutT36j4TE9gnmpny9gN6=GUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 6, 2011 at 14:44, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> After a warm restart, an eMMC which cannot be powered off is
> in an unknown state, so reset it to be sure it will initialize.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? 38 +++++++++++++++++++++++++++++++++++++-
> ?1 files changed, 37 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e1c9017..70b8ef8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -530,10 +530,25 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
> ? ? ? ?} else
> ? ? ? ? ? ? ? ?pdata->slots[0].gpio_wp = -EINVAL;
>
> + ? ? ? if (gpio_is_valid(pdata->slots[0].gpio_hw_reset)) {

Not required as gpio_request takes care of it.

> + ? ? ? ? ? ? ? ret = gpio_request(pdata->slots[0].gpio_hw_reset,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"mmc_hw_reset");
> + ? ? ? ? ? ? ? if (ret)
> + ? ? ? ? ? ? ? ? ? ? ? goto err_free_wp;
> + ? ? ? ? ? ? ? ret = gpio_direction_output(pdata->slots[0].gpio_hw_reset, 1);

Use gpio_request_one instead.

> + ? ? ? ? ? ? ? if (ret)
> + ? ? ? ? ? ? ? ? ? ? ? goto err_free_hw_reset;
> + ? ? ? } else
> + ? ? ? ? ? ? ? pdata->slots[0].gpio_hw_reset = -EINVAL;
> +
> ? ? ? ?return 0;
>
> +
> +err_free_hw_reset:
> + ? ? ? gpio_free(pdata->slots[0].gpio_hw_reset);
> ?err_free_wp:
> - ? ? ? gpio_free(pdata->slots[0].gpio_wp);
> + ? ? ? if (gpio_is_valid(pdata->slots[0].gpio_wp))

Not required as gpio_free takes care of it.

> + ? ? ? ? ? ? ? gpio_free(pdata->slots[0].gpio_wp);
> ?err_free_cd:
> ? ? ? ?if (gpio_is_valid(pdata->slots[0].switch_pin))
> ?err_free_sp:
> @@ -543,6 +558,8 @@ err_free_sp:
>
> ?static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
> ?{
> + ? ? ? if (gpio_is_valid(pdata->slots[0].gpio_hw_reset))

ditto

> + ? ? ? ? ? ? ? gpio_free(pdata->slots[0].gpio_hw_reset);
> ? ? ? ?if (gpio_is_valid(pdata->slots[0].gpio_wp))
> ? ? ? ? ? ? ? ?gpio_free(pdata->slots[0].gpio_wp);
> ? ? ? ?if (gpio_is_valid(pdata->slots[0].switch_pin))


<<snip>>
