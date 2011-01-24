From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 11:21:03 +0000
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTikw1wThEn0h+xv3mFaXVG8H45JUt2vqfECXnn6k@mail.gmail.com>
References: <4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
	<AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
	<AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
	<20110123180110.GJ30094@n2100.arm.linux.org.uk>
	<AANLkTiko9X_ua-ZAOZ-jEaAkPTKLCKyhgCHt6hbM5C-K@mail.gmail.com>
	<20110123230932.GK30094@n2100.arm.linux.org.uk>
	<AANLkTikw1wThEn0h+xv3mFaXVG8H45JUt2vqfECXnn6k@mail.gmail.com>
Message-ID: <20110124112103.GK16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 09:18:19AM +0100, Linus Walleij wrote:
> 2011/1/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sun, Jan 23, 2011 at 10:40:05PM +0100, Linus Walleij wrote:
> >> 2011/1/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> > On Fri, Jan 21, 2011 at 01:53:06PM +0100, Linus Walleij wrote:
> >>
> >> > If we're going to move away from the blockend IRQs to using the data
> >> > counter, can we have a patch which switches the driver to use the data
> >> > counter and then a followup patch which removes the broken blockend
> >> > stuff, rather than somethign that changes the broken blockend stuff
> >> > and then removes it?
> >>
> >> 6631/1 fixes the broken blockend stuff into a state that works,
> >> then 6632/1 removes it in favor of using the MMCIDATACNT.
> >
> > What I'm saying is why do we need to fix the blockend stuff if in the
> > next patch we remove it - why not just combine the two patches and
> > remove the thing in one go as a "we give up using the blockend irq"?
> 
> OK I get it, no, of course 6631 and 6632 can be squashed. I'll do
> this, take out 6631 and have 6632 be the squashed result, will
> be fixed in a few minutes.

I think we're getting there - but what about 6630/1 as well?  Is there a
good reason to keep that separate?  After combining those two, I see this,
which doesn't look like a change we need:

@@ -199,7 +191,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
        struct variant_data *variant = host->variant;
-       unsigned int datactrl, timeout, irqmask;
+       unsigned int datactrl, timeout, irqmask0, irqmask1;
        unsigned long long clks;
        void __iomem *base;
        int blksz_bits;
@@ -230,20 +220,20 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
        datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
        if (data->flags & MMC_DATA_READ) {
                datactrl |= MCI_DPSM_DIRECTION;
-               irqmask = MCI_RXFIFOHALFFULLMASK;
+               irqmask1 = MCI_RXFIFOHALFFULLMASK;

                /*
                 * If we have less than a FIFOSIZE of bytes to transfer,
                 * trigger a PIO interrupt as soon as any data is available.
                 */
                if (host->size < variant->fifosize)
-                       irqmask |= MCI_RXDATAAVLBLMASK;
+                       irqmask1 |= MCI_RXDATAAVLBLMASK;
        } else {
                /*
                 * We don't actually need to include "FIFO empty" here
                 * since its implicit in "FIFO half empty".
                 */
-               irqmask = MCI_TXFIFOHALFEMPTYMASK;
+               irqmask1 = MCI_TXFIFOHALFEMPTYMASK;
        }

        /* The ST Micro variants has a special bit to enable SDIO */
@@ -252,8 +242,10 @@ static void mmci_start_data(struct mmci_host *host, struct
mmc_data *data)
                        datactrl |= MCI_ST_DPSM_SDIOEN;

        writel(datactrl, base + MMCIDATACTRL);
-       writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
-       mmci_set_mask1(host, irqmask);
+       irqmask0 = readl(base + MMCIMASK0);
+       irqmask0 &= ~MCI_DATAENDMASK;
+       writel(irqmask0, base + MMCIMASK0);
+       mmci_set_mask1(host, irqmask1);
 }

 static void

The rest of the combined patch looks sensible, so maybe 6630/1 should be
combined into 6632/2 as well, and the above changes stripped out?
