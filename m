From: marex@denx.de (Marek Vasut)
Date: Tue, 2 Apr 2013 06:22:52 +0200
Subject: [PATCH 1/5] spi/mxs: Fix extra CS pulses and read mode in
 multi-transfer messages
In-Reply-To: <CA+7tXigx=qcDDJZGAx7JEX+Y-CDG-B0xyYgs6fHbUZofH7gnKw@mail.gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <201304020111.13969.marex@denx.de>
 <CA+7tXigx=qcDDJZGAx7JEX+Y-CDG-B0xyYgs6fHbUZofH7gnKw@mail.gmail.com>
Message-ID: <201304020622.52429.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> On Mon, Apr 1, 2013 at 4:11 PM, Marek Vasut <marex@denx.de> wrote:
> >> +#define TXRX_WRITE           1       /* This is a write */
> >> +#define TXRX_DEASSERT_CS     2       /* De-assert CS at end of txrx */
> > 
> > New flags? I'm sure the GCC can optimize function parameters pretty well,
> > esp. if you make the bool.
> 
> Nope.  I checked the actual compiled code.  Each bool takes another
> parameter.  Since the txrx functions are large and called from
> multiple sites, they are not inlined.  Gcc is not able to combine all
> the bool arguments into one single bitfield argument.

That's pretty poor, oh well.

btw. is it necessary to define new flags or is it possible to reuse some?

[...]

> >>       ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
> >> 
> >> -     ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
> >> +     ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT & ~BM_SSP_CTRL0_IGNORE_CRC &
> >> +              ~BM_SSP_CTRL0_READ;
> > 
> > Well ... ctrl0 &= ~(FOO | BAR | BAZ); ... won't cut it?
> 
> Well, by De Morgan's law the two expressions are the same.  And they
> are the same number of characters.  And both will produce a compile
> time constant and thus the same code.  However, I like the ~FOO & ~BAR
> & ~BAR form better as there is greater parallelism between each term
> of the expression.

What about the law of readability of code ? ;-)

> >>       ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
> >> 
> >> -     if (*first)
> >> -             ctrl0 |= BM_SSP_CTRL0_LOCK_CS;
> > 
> > The DMA will overwrite ctrl0 in each turn, did you try very long (>64kB
> > long) transfers with your adjustments? To test this, you can try
> > 
> > $ dd if=/dev/mtdN of=/dev/null bs=1M
> > 
> > on sufficiently large SPI flash supporting the FAST_READ opcode.
> 
> Don't have SPI flash.  I did test with logic analyzer and the current
> code is clearly broken and my changes clearly fix it.

Good, but you clearly didn't test it in the most used case. This will clearly 
piss off a lot of people if you break something. And this will clearly not be 
good ;-)

I'm clearly planning to test the code, but only once it's clearly possible to 
tell apart churn from the actual fix (see my other rambling, just reminding 
you). So I'll wait for V2 and give it a go on a large flash.

> It should be obvious from looking a the code that it is wrong.

Sorry, it is not obvious.

> The DMA does write
> ctrl0 on each segment of each transfer, but look at the previous
> paragraph to see where it comes from.  Once READ or IGNORE_CRC are
> set, nothing will clear them until PIO mode is used.

When using a flash, the DMA and PIO mode usage is intermixed. Usually, the PIO 
is used to program the command and then DMA to transmit the payload. It's hardly 
ever PIO only orr DMA only for the whole transfer.

> It's the same
> with the bug fix for 3.9 that clears the XFER_COUNT bits in DMA mode.
> Strangely, I didn't notice that bug since all my xfers are the same
> length!  But I do switch between slaves, between read and write, and
> use messages with multiple transfers, in DMA mode, all of which are
> broken in the current driver.

btw. are you using MX23 or MX28 to test this?

> >> +             if ((sg_count + 1 == sgs) && (flags & TXRX_DEASSERT_CS))
> >> 
> >>                       ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
> >>               
> >>               if (ssp->devid == IMX23_SSP) {
> >> 
> >> @@ -279,7 +267,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> >> cs,
> >> 
> >>               sg_init_one(&dma_xfer[sg_count].sg, sg_buf, min);
> >>               ret = dma_map_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
> >> 
> >> -                     write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> >> +                     (flags & TXRX_WRITE) ? DMA_TO_DEVICE :
> >> DMA_FROM_DEVICE);
> > 
> > I think this is unneeded.
> 
> Whatis ?  Setting the DMA direction or using flags?
> 
> Look at it this way:
> 
> Existing code that uses the first/last flags is wrong and needs to be
> changed.  Therefor code using 'first' and 'last' will be changed.
> 
> Passing the flags as pointers is bad practice and makes no sense to
> do.  Does it make any sense to re-write code fix the way it uses first
> and last, then re-write those same lines a second time to not use
> pointers?

You can always flip it the other way -- first rework the use of flags, then 
apply the fix. It'd make the patch much easier to understand, don't you think?

> If the way the flags are passed should change, then why not do it the
> most efficient way.  It isn't any more complicated and produces better
> code.  One flag per parameter becomes cumbersome when more flags are
> added for additional features.
> 
> I'm all for splitting my patches up.  I sent five patches when I bet 9
> out 10 developers would have just done one.  But I don't think it
> makes any sense to re-write the same line of code over and over again
> in successive patches in a series before getting to the final version.
>  It just makes more churn to review.

Splitting the patchset to make it more understandable is OK though. And I'm 
really getting lost in this patch.

> I hate it when I get a series of patches and spot a flaw, take the
> time to write up the flaw and how it should be fixed, only to discover
> that the flaw is fixed later on in the series and I wasted my time.

Best regards,
Marek Vasut
