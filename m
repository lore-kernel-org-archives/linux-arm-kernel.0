From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 11:42:01 +0100
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
	<20110413124149.GR18850@pengutronix.de>
	<BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
Message-ID: <20110508104201.GH27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2011 at 10:48:40AM -0500, Matt Sealey wrote:
> CONFIG_ARM_PATCH_PHYS_VIRT
> 
> These two config options, with absolutely no bootloader changes, will
> basically mask off some address (instruction pointer?) at the time of
> the check and therefore derive a perfectly good PHYS_OFFSET at runtime
> and make sure it is in use... within some limits (first 128MB, assumes
> that start of memory is at some particular alignment)?

The V:P fixup will only handle bits 31-24, or 31-16 if the
ARM_PATCH_PHYS_VIRT_16BIT option is selected (for MSM).  If the offset
doesn't wholy fit into these, then the fixup function will complain and
your kernel won't boot.  So, it'll go down to 64K alignment.

It does rely on the kernel being placed correctly in memory.  So if the
start of the kernel text is built to be 32K above PAGE_OFFSET, then the
kernel will assume that physical memory starts 32K below where the
'Image' ended up in physical memory.  If you place the kernel in physical
memory 16MB above the start, then it'll assume that physical memory starts
16MB above where it actually did.

There is one thing to watch out for though - if you did place it 16MB
above, but still tell the kernel via ATAGs that the physical memory
starts where it really does, then I'd expect things to explode as
the kernel direct mapped memory would likely extend below PAGE_OFFSET.
