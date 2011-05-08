From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 16:05:30 +0100
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <alpine.LFD.2.00.1105081027190.1001@xanadu.home>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
	<20110413124149.GR18850@pengutronix.de>
	<BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
	<20110508104201.GH27807@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1105081027190.1001@xanadu.home>
Message-ID: <20110508150530.GL27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2011 at 11:00:30AM -0400, Nicolas Pitre wrote:
> On Sun, 8 May 2011, Russell King - ARM Linux wrote:
> 
> > On Wed, May 04, 2011 at 10:48:40AM -0500, Matt Sealey wrote:
> > > CONFIG_ARM_PATCH_PHYS_VIRT
> > > 
> > > These two config options, with absolutely no bootloader changes, will
> > > basically mask off some address (instruction pointer?) at the time of
> > > the check and therefore derive a perfectly good PHYS_OFFSET at runtime
> > > and make sure it is in use... within some limits (first 128MB, assumes
> > > that start of memory is at some particular alignment)?
> > 
> > The V:P fixup will only handle bits 31-24, or 31-16 if the
> > ARM_PATCH_PHYS_VIRT_16BIT option is selected (for MSM).  If the offset
> > doesn't wholy fit into these, then the fixup function will complain and
> > your kernel won't boot.  So, it'll go down to 64K alignment.
> > 
> > It does rely on the kernel being placed correctly in memory.  So if the
> > start of the kernel text is built to be 32K above PAGE_OFFSET, then the
> > kernel will assume that physical memory starts 32K below where the
> > 'Image' ended up in physical memory.  If you place the kernel in physical
> > memory 16MB above the start, then it'll assume that physical memory starts
> > 16MB above where it actually did.
> 
> If CONFIG_AUTO_ZRELADDR is set, then zImage will automatically place the 
> kernel Image correctly in memory, assuming that zImage is itself loaded 
> within the first 128MB of memory.

I was only covering the requirements of the Image, rather than zImage which
you covered in a subsequent message.

> > There is one thing to watch out for though - if you did place it 16MB
> > above, but still tell the kernel via ATAGs that the physical memory
> > starts where it really does, then I'd expect things to explode as
> > the kernel direct mapped memory would likely extend below PAGE_OFFSET.
> 
> Yeah... We should probably add a warning and truncate the beginning of 
> the memory bank in that case.  This would also prevent memory from being 
> wrongly declared below PHYS_OFFSET even without the P2V feature enabled.

We don't encouter the situation today, so lets leave it until we actually
have a problem.  There's no point bloating the kernel with such checks if
they're never going to fire.
