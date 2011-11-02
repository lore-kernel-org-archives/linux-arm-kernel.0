From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 12:37:30 +0000
Subject: [PATCH 5/5] ARM: restart: only perform setup for restart when
	soft-restarting
In-Reply-To: <20111102121159.GF645@mudshark.cambridge.arm.com>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<E1RLGuL-0005If-Od@rmk-PC.arm.linux.org.uk>
	<20111102121159.GF645@mudshark.cambridge.arm.com>
Message-ID: <20111102123730.GA19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 12:12:00PM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Tue, Nov 01, 2011 at 04:09:49PM +0000, Russell King - ARM Linux wrote:
> > We only need to set the system up for a soft-restart if we're going to
> > be doing a soft-restart.  Provide a new function (soft_restart()) which
> > does the setup and final call for this, and make platforms use it.
> > Eliminate the call to setup_restart() from the default handler.
> > 
> > This means that platforms arch_reset() function is no longer called with
> > the page tables prepared for a soft-restart, and caches will still be
> > enabled.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/system.h                     |    1 +
> >  arch/arm/kernel/process.c                         |   10 +++++++---
> >  arch/arm/mach-clps711x/include/mach/system.h      |    2 +-
> >  arch/arm/mach-ebsa110/include/mach/system.h       |    2 +-
> >  arch/arm/mach-footbridge/include/mach/system.h    |    2 +-
> >  arch/arm/mach-iop32x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-iop33x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-ixp4xx/include/mach/system.h        |    2 +-
> >  arch/arm/mach-ks8695/include/mach/system.h        |    2 +-
> >  arch/arm/mach-mmp/include/mach/system.h           |    4 ++--
> >  arch/arm/mach-mxs/system.c                        |    2 +-
> >  arch/arm/mach-nuc93x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-pnx4008/include/mach/system.h       |    2 +-
> >  arch/arm/mach-pxa/reset.c                         |    2 +-
> >  arch/arm/mach-rpc/include/mach/system.h           |    2 +-
> >  arch/arm/mach-s3c2410/include/mach/system-reset.h |    4 ++--
> >  arch/arm/mach-s3c64xx/include/mach/system.h       |    2 +-
> >  arch/arm/mach-sa1100/include/mach/system.h        |    2 +-
> >  arch/arm/mach-shmobile/include/mach/system.h      |    2 +-
> >  arch/arm/mach-w90x900/include/mach/system.h       |    2 +-
> >  arch/arm/plat-mxc/system.c                        |    2 +-
> >  arch/arm/plat-spear/include/plat/system.h         |    2 +-
> >  22 files changed, 30 insertions(+), 25 deletions(-)
> 
> Which branch is this patch taken against? I'm getting conflicts if I try to
> apply it against mainline, next, 3.1 or your devel branch.

It's at some random point during the merge window at the moment.

It's probably going to be a good idea to wait until after the merge window
closes before tackling this stuff seriously, because things are still
changing quite quickly - eg, we have new platforms merged last night which
wouldn't have been updated with these patches.

I'd suggest not rushing this; we'll have a full 2-3 months before they
can be merged into mainline.
