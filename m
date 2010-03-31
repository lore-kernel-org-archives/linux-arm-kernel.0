From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 31 Mar 2010 18:41:36 +0200
Subject: [PATCH 2/3] ARM: MXC: mxcmmc: Teach the driver SDIO operations
In-Reply-To: <20100331132946.GH30807@buzzloop.caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
	<1269973921-29611-2-git-send-email-daniel@caiaq.de>
	<20100331130339.GX2241@pengutronix.de>
	<20100331132946.GH30807@buzzloop.caiaq.de>
Message-ID: <m2ke2d7436a1003310941t18aeab59qb41f96bc58618960@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/31 Daniel Mack <daniel@caiaq.de>:
> On Wed, Mar 31, 2010 at 03:03:39PM +0200, Sascha Hauer wrote:
>> On Tue, Mar 30, 2010 at 08:32:00PM +0200, Daniel Mack wrote:
>> > +static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> > +{
>> > + ? struct mxcmci_host *host = mmc_priv(mmc);
>> > + ? unsigned long flags;
>> > + ? u32 int_cntr;
>> > +
>> > + ? spin_lock_irqsave(&host->lock, flags);
>> > + ? host->use_sdio = enable;
>> > + ? int_cntr = readl(host->base + MMC_REG_INT_CNTR);
>> > +
>> > + ? if (enable)
>> > + ? ? ? ? ? int_cntr |= INT_SDIO_IRQ_EN;
>> > + ? else
>> > + ? ? ? ? ? int_cntr &= ~INT_SDIO_IRQ_EN;
>> > +
>> > + ? writel(int_cntr, host->base + MMC_REG_INT_CNTR);
>> > + ? spin_unlock_irqrestore(&host->lock, flags);
>>
>> The other places where MMC_REG_INT_CNTR is touched should be protected
>> by this spinlock aswell.
> Hmm, all other place don't do a read/modify/write cycle, so I'd say the
> don't need protection?

If you miss spinlocks around the unconditional writes they might
happen between your readl() and writel().

Best Regards,
Micha? Miros?aw
