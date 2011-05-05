From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 5 May 2011 15:53:45 +0300
Subject: [PATCH 13/22] mmc: omap_hsmmc: fix few bugs when set the clock
	divisor
In-Reply-To: <1304596282-4095-14-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
	<1304596282-4095-14-git-send-email-adrian.hunter@nokia.com>
Message-ID: <BANLkTikwqcgcy2dnD=2_DGUQM=0a1JtfoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 2:51 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
> There are two pieces of code which similar, but not the same. Each of them
> contains a bug.
>
> The SYSCTL register should be read before write in the
> omap_hsmmc_context_restore() to remain the state of the reserved bits.
>
> Before set the clock divisor and DTO bits the value from the SYSCTL register
> should be masked properly. We were lucky to have no problems with DTO bits. So,
> make sure we have clear DTO bits properly in the omap_hsmmc_set_ios().
>
> Additionally get rid of msleep(1). The actual time rare higher than 30us on
> OMAP 3630.
>
> The result pieces of code are split to omap_hsmmc_set_clock() function.
>
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? 59 +++++++++++++++++++---------------------
> ?1 files changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index ae6d204..3c76911 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -619,6 +619,32 @@ static u16 calc_divisor(struct mmc_ios *ios)
> ? ? ? ?return dsor;
> ?}
>
> +static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
> +{
> + ? ? ? struct mmc_ios *ios = &host->mmc->ios;
> + ? ? ? unsigned long regval;
> + ? ? ? unsigned long timeout;
> +
> + ? ? ? dev_dbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
> +
> + ? ? ? omap_hsmmc_stop_clock(host);
> +
> + ? ? ? regval = OMAP_HSMMC_READ(host->base, SYSCTL);
> + ? ? ? regval = regval & ~(CLKD_MASK | DTO_MASK);
> + ? ? ? regval = regval | (calc_divisor(ios) << 6) | (DTO << 16);
> + ? ? ? OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
> + ? ? ? OMAP_HSMMC_WRITE(host->base, SYSCTL,
> + ? ? ? ? ? ? ? OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> +
> + ? ? ? /* Wait till the ICS bit is set */
> + ? ? ? timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> + ? ? ? while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != ICS
> + ? ? ? ? ? ? ? && time_before(jiffies, timeout))
> + ? ? ? ? ? ? ? ;

Since you are busywaiting now, cpu_relax() is advisable I guess.
