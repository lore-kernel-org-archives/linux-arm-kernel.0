From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Feb 2011 07:52:08 +0800
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <201102131634.40468.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<20110211003533.GA9151@S2100-06.ap.freescale.net>
	<20110213175300.GA10271@S2100-06.ap.freescale.net>
	<201102131634.40468.arnd@arndb.de>
Message-ID: <20110213235207.GA10397@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 13, 2011 at 04:34:40PM +0100, Arnd Bergmann wrote:
> On Sunday 13 February 2011 18:53:02 Shawn Guo wrote:
> > On Fri, Feb 11, 2011 at 08:35:34AM +0800, Shawn Guo wrote:
> > > 
> > > > > + unsigned                        present:1;
> > > > 
> > > > Your card detection by polling through this variable is
> > > > really bad for power management. Is there really no interrupt
> > > > that gets triggered when installing or removing a card?
> > > > 
> > > Good point.  Will try to use interrupt.
> > > 
> > I'm trying to use interrupt for card detection.  But unfortunately,
> > I got stuck for some reason.
> > 
> > There is a known issue that mx28 gpio interrupt from bank0 can not
> > work, because the pin bank0 irq number 127 was used in
> > get_irqnr_and_base (entry-macro.S) to tell there is no pending
> > interrupt any more.
> > 
> > The mmc0 cd pin has no problem to trigger interrupt, as it's GPIO_2_9.
> > But mmc1 cd pin can not, because it's GPIO_0_20.
> > 
> > So I probably have to stay with polling.
> 
> I'm not sure if I understand completely. Is this a fundamental restriction,
> or something that only happens on a specific board?
> 
This is a fundamental restriction.

> Maybe you can do both polling and interrupt driven card detection in
> the driver, and make it depend on a board-specific quirk. E.g. if you
> pass an interrupt number in the platform data, it should just use the
> interrupt, but if the interrupt is missing, you can fall back to
> polling.
> 
I rewriting the code to use mmc core card detect polling framework.

static int mxs_mmc_get_cd(struct mmc_host *mmc)
{
        struct mxs_mmc_host *host = mmc_priv(mmc);

        return !(readl(host->base + HW_SSP_STATUS) &
                        BM_SSP_STATUS_CARD_DETECT);
}

static const struct mmc_host_ops mxs_mmc_ops = {
	...
        .get_cd = mxs_mmc_get_cd,
};

static int mxs_mmc_probe(struct platform_device *pdev)
{
	...
	mmc_caps |= MMC_CAP_NEEDS_POLL;
	...
}

It looks pretty simple and mmc core code has taken care of the case
of power management.  So if this looks fine to you, I will go for it
in v2 of the patch set.

Regards,
Shawn
