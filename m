From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 16:24:00 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
Message-ID: <20110124162400.GC24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 04:13:14PM +0000, Pawel Moll wrote:
> > I don't think enlarging the FIFO will help too much.  The issue is
> > whether the CPU can keep up with the data rate coming off the card.
> > If it can't, then no matter how large the FIFO is, it will
> > eventually overflow.
> 
> Yes, I realize that. But so far the only time when problem happens is
> the timeout caused by ISP1761 handler.

That's fixable by having the block driver retry.

I have patches lodged with cjb which rework the MMC block driver error
handling, and I now have MMC rootfs entirely usable with the ISP1761
driver.  With ISP1761 also fixed (god knows why the driver maintainer
isn't doing anything with that patch) then the problem goes away.

So really this is a non-issue.

> If we substantially increase the FIFO depth, we'll just have much more
> margin - enough to "mostly work". To my taste, the 1.3ms required to
> service the USB interrupt is already waaay to long. I'd consider any
> substantially larger latencies pathological, so making sure that we
> have margin of 3, maybe even 5 ms sounds good enough to me.

Well, fixing MMCI because ISP1761 is buggy is not the way forward.  The
answer is to fix the broken ISP1761 driver.

We know as it currently stands in mainline that it's utterly unusable
with certain serial devices.  That doesn't mean we go off and fix MMCI.

> > The real answer is to avoid PIO mode, and use DMA support.
> > However,
> > I've had problems using DMA on the ARM development boards.  You can
> 
> Well, using DMA won't be easy on VE, will it? ;-) Besides even with
> this, in some extreme situation, the bus could be potentially stalled
> long enough to cause an underrun. Yes, very unlikely, but not impossible.

I'm running SD rootfs alongside NFS/ssh/NTP and the buggy ISP1761.  With the
pile of 'fixes' patches I have here (which are currently stuck with various
maintainers) I have a completely stable system.

I've also had it running gstreamer on CLCD with AACI too, again with SD
rootfs.  Provided the video is already loaded off the SD card (because
the transfer rate is too slow) it's fine.

The only remaining problem I have with it is !"?$%% busybox shell which
doesn't like readonly rootfs with command history.  The last command is
/sbin/reboot - I'm sure you can imagine what keeps on happening,
particularly at the most annoying points in time.

> > The alternative answer, I believe implemented by some of ARMs silicon
> > partners, is to turn the card clock off when the FIFO becomes full/empty
> > to stop it sending more data.  I think this violates some of the MMC/SD
> > requirements, but it seems to work for the silicon partners just fine.
> 
> Oh no, that's absolutely legal - see JEDEC 84-A441, p. 7.7:
> "The MultiMediaCard bus clock signal can be used by the host to put the
> card into energy saving mode, or to control the data flow (to avoid
> under-run or over-run conditions) on the bus."
> 
> So this would be the technically correct fix. The problem is that this
> would require even more MMCI modifications then enlarging FIFO, so it's
> unlikely to happen.

Well as I see it, it's pointless enlarging the FIFO.  ARM Ltd isn't going
to give me updated FPGA images for the Integrator/CP, Versatile PB926,
Realview EB and Versatile Express.

Given that the problem is already fixed via a set of patches, I see no
reason to mess about with the hardware, thereby making the driver more
complicated for *no* benefit.
