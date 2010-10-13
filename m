From: r65037@freescale.com (Zhu Richard-R65037)
Date: Wed, 13 Oct 2010 18:22:14 +0800
Subject: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common stuff
In-Reply-To: <20101011183300.GC21335@void.printf.net>
References: <1286806866-19258-6-git-send-email-w.sang@pengutronix.de>
	<1286817032-21219-1-git-send-email-w.sang@pengutronix.de>
	<20101011183300.GC21335@void.printf.net>
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D557E@zch01exm22.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
It's better that the mdelay(100) is replaced by some litter value such
as 10ms and so on,
 since I encounter one bug ever when this values is set to 100. The
audio playback would
 be noised by the sd/mmc insertion/extraction operations.

Best Regards
Richard Zhu



> -----Original Message-----
> From: Chris Ball [mailto:cjb at laptop.org]
> Sent: Tuesday, October 12, 2010 2:33 AM
> To: Wolfram Sang
> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
Zhu
> Richard-R65037
> Subject: Re: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common
stuff
> 
> Hi Wolfram,
> 
> On Mon, Oct 11, 2010 at 07:10:32PM +0200, Wolfram Sang wrote:
> > +static inline void esdhc_set_clock(struct sdhci_host *host,
unsigned
> > +int clock) {
> > +	int pre_div = 2;
> > +	int div = 1;
> > +	u32 temp;
> > +
> > +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> > +	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
ESDHC_CLOCK_PEREN
> > +		| ESDHC_CLOCK_MASK);
> > +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > +
> > +	if (clock == 0)
> > +		goto out;
> > +
> > +	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> > +		pre_div *= 2;
> > +
> > +	while (host->max_clk / pre_div / div > clock && div < 16)
> > +		div++;
> > +
> > +	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual:
%d\n",
> > +		clock, host->max_clk / pre_div / div);
> > +
> > +	pre_div >>= 1;
> > +	div--;
> > +
> > +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> > +	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
ESDHC_CLOCK_PEREN
> > +		| (div << ESDHC_DIVIDER_SHIFT)
> > +		| (pre_div << ESDHC_PREDIV_SHIFT));
> > +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > +	mdelay(100);
> 
> This isn't directly related to this patchset (the code was there
> beforehand), but it would be nice to rework the mdelay(100).
> 
> Thanks,
> 
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
