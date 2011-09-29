From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Thu, 29 Sep 2011 19:10:30 +0530
Subject: [PATCH V2 11/16] mmc: omap_hsmmc: ensure pbias configuration is
	always done
In-Reply-To: <1304673255-31634-12-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<1304673255-31634-12-git-send-email-adrian.hunter@nokia.com>
Message-ID: <CANrkHUYp-6a+qBZLk7SL9zHoy0wKuoYYYVEo0yb5=qzzicGepQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2011 at 2:44 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> Go through the driver's set_power() functions rather than
> calling regulator_enable/disable() directly because otherwise
> pbias configuration for MMC1 is not done.
Hi Chris,

Are you OK to queue this patch as bug fix. Rest of the patches of this
series is either
merged or not needed. Should I rebase and repost this alone ?

FWIW:
Acked-by: Balaji T K <balajitk@ti.com>

>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? 17 ++++++++---------
> ?1 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4f6e552..8aa9440 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -445,15 +445,14 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> ? ? ? ? ? ? ? ?* framework is fixed, we need a workaround like this
> ? ? ? ? ? ? ? ?* (which is safe for MMC, but not in general).
> ? ? ? ? ? ? ? ?*/
> - ? ? ? ? ? ? ? if (regulator_is_enabled(host->vcc) > 0) {
> - ? ? ? ? ? ? ? ? ? ? ? regulator_enable(host->vcc);
> - ? ? ? ? ? ? ? ? ? ? ? regulator_disable(host->vcc);
> - ? ? ? ? ? ? ? }
> - ? ? ? ? ? ? ? if (host->vcc_aux) {
> - ? ? ? ? ? ? ? ? ? ? ? if (regulator_is_enabled(reg) > 0) {
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? regulator_enable(reg);
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? regulator_disable(reg);
> - ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if (regulator_is_enabled(host->vcc) > 0 ||
> + ? ? ? ? ? ? ? ? ? (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
> + ? ? ? ? ? ? ? ? ? ? ? int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
> +
> + ? ? ? ? ? ? ? ? ? ? ? mmc_slot(host).set_power(host->dev, host->slot_id,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?1, vdd);
> + ? ? ? ? ? ? ? ? ? ? ? mmc_slot(host).set_power(host->dev, host->slot_id,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0, 0);
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
