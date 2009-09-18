From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Sep 2009 23:51:41 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <20090918202055.GH6601@n2100.arm.linux.org.uk>
References: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<20090914142333.GF21580@n2100.arm.linux.org.uk>
	<1252938577.16853.122.camel@pc1117.cambridge.arm.com>
	<20090918202055.GH6601@n2100.arm.linux.org.uk>
Message-ID: <1253314301.26613.11.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-09-18 at 21:20 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 14, 2009 at 03:29:36PM +0100, Catalin Marinas wrote:
> > The other case where I replied was discussing the need for CLREX at
> > context switch and that's needed to get the correct behaviour (T1 and T2
> > are OS threads in this case).
> 
> Well, lets get your patch in then.  Please try to get it to me (patch
> system / git pull) by tomorrow evening, thanks.

The patch pretty much as it was originally posted but with Jamie's
comment is available on the for-rmk branch below (the patch has
atomic_set modified to STR and CLREX removed from __switch_to as it is
no longer needed - explicit calls to schedule() don't have a problem as
they don't happen in the middle of an atomic LDREX/STREX construct).

I added two more patches to the for-rmk branch - the W macro fix in
unified.h and kernel (not user) undefined instructions handling in
Thumb-2 (I run it on a model without VFP and reading FPSID was causing
an oops).

You can merge the branch as it is but you can skip the Thumb-2 patches
by merging for-rmk^ or for-rmk^^ (in case you find any issues, I'm not
sure I'll be able to reply before tomorrow night).

Thanks.


The following changes since commit df58bee21ed218cb7dfb561a590b1bd2a99531cf:
  Linus Torvalds (1):
        Merge branch 'x86-mce-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://linux-arm.org/linux-2.6 for-rmk

Alexey Dobriyan (1):
      Fix "W" macro in arch/arm/include/asm/unified.h

Catalin Marinas (2):
      Clear the exclusive monitor when returning from an exception
      Thumb-2: Correctly handle undefined instructions in the kernel

 arch/arm/include/asm/atomic.h  |   26 +++++++-------------------
 arch/arm/include/asm/unified.h |    4 ++++
 arch/arm/kernel/entry-armv.S   |   19 +++++++++++--------
 arch/arm/kernel/entry-header.S |   14 ++++++++++++++
 4 files changed, 36 insertions(+), 27 deletions(-)

-- 
Catalin
