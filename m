From: prakity@marvell.com (Philip Rakity)
Date: Wed, 27 Apr 2011 08:02:39 -0700
Subject: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
In-Reply-To: <20110427093328.GU17290@n2100.arm.linux.org.uk>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
	<20110427093328.GU17290@n2100.arm.linux.org.uk>
Message-ID: <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





Begin forwarded message:

> From: Philip Rakity <prakity@marvell.com>
> Date: April 22, 2011 1:18:33 PM PDT
> To: "linux-mmc at vger.kernel.org" <linux-mmc@vger.kernel.org>
> Cc: Zhangfei Gao <zgao6@marvell.com>
> Subject: [PATCH] sdhci: sdhci-pxa.c: Add post reset processing for chip specific registers 
> 
> 
> RESET_ALL resets chips private registers.
> Reset to values specified in board file.
> 
> depends on board specific mach-mmp/plat-pxa sdhci.h definitions
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> drivers/mmc/host/sdhci-pxa.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index c8abf0f..1dc0988 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -29,6 +29,13 @@
> 
> #define DRIVER_NAME	"sdhci-pxa"
> 
> +#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
> +#define SDCLK_DELAY_MASK     0x1F
> +#define SDCLK_SEL_MASK       0x1
> +#define SDCLK_DELAY_SHIFT    9
> +#define SDCLK_SEL_SHIFT      8
> +
> +
> struct sdhci_pxa {
> 	struct sdhci_host		*host;
> 	struct sdhci_pxa_platdata	*pdata;
> @@ -53,7 +60,42 @@ static void enable_clock(struct sdhci_host *host)
> 	}
> }
> 
> +static void set_clock_and_burst_size(struct sdhci_host *host)
> +{
> +	u16 tmp;
> +	struct sdhci_pxa *pxa = sdhci_priv(host);
> +
> +	pr_debug("%s:%s: adjust = %d\n",
> +		__func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
> +
> +	if (pxa->pdata->adjust_clocks) {
> +		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
> +		pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
> +			"delay = %d, sel = %d\n",
> +			__func__, mmc_hostname(host->mmc), tmp,
> +			pxa->pdata->clk_delay, pxa->pdata->clk_select);
> +		tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
> +		tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
> +		tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
> +			SDCLK_DELAY_SHIFT;
> +		tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
> +			SDCLK_SEL_SHIFT;
> +		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
> +		pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = %04X\n",
> +			__func__, mmc_hostname(host->mmc), tmp);
> +	}
> +}
> +
> +static void platform_reset_exit(struct sdhci_host *host, u8 mask)
> +{
> +	if (mask == SDHCI_RESET_ALL) {
> +		/* reset private registers */
> +		set_clock_and_burst_size(host);
> +	}
> +}
> +
> static struct sdhci_ops sdhci_pxa_ops = {
> +	.platform_reset_exit = platform_reset_exit,
> };
> 
> /*****************************************************************************\
> -- 
> 1.7.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


On Apr 27, 2011, at 2:33 AM, Russell King - ARM Linux wrote:

> On Fri, Apr 22, 2011 at 01:13:28PM -0700, Philip Rakity wrote:
>> The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
>> clock.  This feature is useful and required depending on the board
>> design.  Add infrastructure to support SD clock tuning.
> 
> It just adds fields to a structure which remain unused.  On its own this
> patch is useless, and I don't see a patch which makes use of these new
> fields in any way.  Did you forget to copy it to the linux-arm-kernel
> list?
