From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 14:07:32 +0100
Subject: [PATCH] ARM: save/restore diagnostic register on ARMv7
 suspend/resume
In-Reply-To: <20140618123906.GI8860@dragon>
References: <1403081398-32116-1-git-send-email-shawn.guo@freescale.com>
 <20140618104009.GH32699@arm.com> <20140618123906.GI8860@dragon>
Message-ID: <20140618130731.GC32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 08:39:08PM +0800, Shawn Guo wrote:
> On Wed, Jun 18, 2014 at 11:40:09AM +0100, Will Deacon wrote:
> > On Wed, Jun 18, 2014 at 09:49:58AM +0100, Shawn Guo wrote:
> > > The CP15 diagnostic register holds ARM errata bits on ARMv7, so it
> > > needs to be saved/restored on suspend/resume.  Otherwise, the
> > > effectiveness of errata workaround gets lost together with diagnostic
> > > register bit across suspend/resume cycle.
> > 
> > This should be conditional on Cortex-A9, since this register is certainly
> > not architected.
> 
> Ah, yes.  In that case, I should probably handle it at platform level to
> avoid messing up generic ARMv7 suspend/resume routines.

We don't need more platform code repeating this kind of stuff...

All Cortex-A9 which have these work-arounds enabled may need this and
as the generic kernel already fiddles with this, it's something that
should not be platform specific - indeed, some of these workarounds
are supposed to be in place before the MMU is enabled.

So, it's being done at the preferred place in the kernel... just not
in a way that results in only Cortex A9 being affected.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
