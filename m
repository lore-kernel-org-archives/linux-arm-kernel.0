From: svenkatr@ti.com (S, Venkatraman)
Date: Wed, 8 Feb 2012 00:04:26 +0530
Subject: [PATCH 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always have
 vmmc supply
In-Reply-To: <1328367090-10402-7-git-send-email-rnayak@ti.com>
References: <1328367090-10402-1-git-send-email-rnayak@ti.com>
 <1328367090-10402-7-git-send-email-rnayak@ti.com>
Message-ID: <CANfBPZ-jcgQM68NW=eHkhv_ny+4_2woNxnDtiAKw8OBRdnecqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 4, 2012 at 8:21 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> MMC1 is not the only instance that can be used/wired for SD.
> So remove this assumption from the driver.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? 14 --------------
> ?1 files changed, 0 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 17e264b..97d3065 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -300,7 +300,6 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
> ?static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> ?{
> ? ? ? ?struct regulator *reg;
> - ? ? ? int ret = 0;
> ? ? ? ?int ocr_value = 0;
>
> ? ? ? ?mmc_slot(host).set_power = omap_hsmmc_set_power;
> @@ -308,15 +307,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> ? ? ? ?reg = regulator_get(host->dev, "vmmc");
> ? ? ? ?if (IS_ERR(reg)) {
> ? ? ? ? ? ? ? ?dev_dbg(host->dev, "vmmc regulator missing\n");
> - ? ? ? ? ? ? ? /*
> - ? ? ? ? ? ? ? * HACK: until fixed.c regulator is usable,
> - ? ? ? ? ? ? ? * we don't require a main regulator
> - ? ? ? ? ? ? ? * for MMC2 or MMC3
> - ? ? ? ? ? ? ? */
> - ? ? ? ? ? ? ? if (host->id == OMAP_MMC1_DEVID) {
> - ? ? ? ? ? ? ? ? ? ? ? ret = PTR_ERR(reg);
> - ? ? ? ? ? ? ? ? ? ? ? goto err;
> - ? ? ? ? ? ? ? }
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?host->vcc = reg;
> ? ? ? ? ? ? ? ?ocr_value = mmc_regulator_get_ocrmask(reg);
> @@ -358,10 +348,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> ? ? ? ?}
>
> ? ? ? ?return 0;
> -
> -err:
> - ? ? ? mmc_slot(host).set_power = NULL;
> - ? ? ? return ret;
> ?}
>
> ?static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
> --

Almost all usage of the id field is gone, except for a trivial debug print.
Would be prudent to get rid of it entirely from struct omap_hsmmc_host.
