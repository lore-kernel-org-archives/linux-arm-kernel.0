From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 23 Jun 2010 00:03:47 +0200
Subject: [PATCH 07/12] mmci: pass power_mode to the translate_vdd callback
In-Reply-To: <1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thinking a bit about this patch tonight:

2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:

> Platforms may have some external power control which need to be
> controlled from board specific code. ?This is the case for some versions
> of the MOP500 board (U8500 platform).
>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
> ?drivers/mmc/host/mmci.c ? | ? ?3 ++-
> ?include/linux/amba/mmci.h | ? ?6 ++++--
> ?2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 322958f..63eb7f4 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -483,7 +483,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> ? ? ? ? ? ? ? ? * power control behind this translate function.
> ? ? ? ? ? ? ? ? */
> ? ? ? ? ? ? ? ?if (!host->vcc && host->plat->translate_vdd)
> - ? ? ? ? ? ? ? ? ? ? ? pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
> + ? ? ? ? ? ? ? ? ? ? ? pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ios->power_mode);
> ? ? ? ? ? ? ? ?/* The ST version does not have this, fall through to POWER_ON */
> ? ? ? ? ? ? ? ?if (host->hw_designer != AMBA_VENDOR_ST) {
> ? ? ? ? ? ? ? ? ? ? ? ?pwr |= MCI_PWR_UP;
> diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
> index f9d1bb5..61b5810 100644
> --- a/include/linux/amba/mmci.h
> +++ b/include/linux/amba/mmci.h
> @@ -17,7 +17,8 @@
> ?* mmc/host.h
> ?* @translate_vdd: a callback function to translate a MMC_VDD_*
> ?* mask into a value to be binary or:ed and written into the
> - * MMCIPWR register of the block
> + * MMCIPWR register of the block. ?May also control external power
> + * based on the power_mode.

Actually this callback is named like that for a reason: it is to be used
to translate the MMC_VDD_* into a u8:4 bitmask for the MMCIPWR
register, 4 bits possibly routed out of the PL180 block on some
designs (never seen in practice, but could be used in theory).

So it translates a voltage into a 4-bit bitmask, hence the name.

Now the semantics are altered to have other side-effects in
the platform, so the function should be renamed, something like
platform_vdd_handler() would be more appropriate.

Yours,
Linus Walleij
