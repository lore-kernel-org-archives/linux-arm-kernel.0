From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2012 16:09:31 +0000
Subject: [PATCH 2/2] ARM: cache: assume 64-byte L1 cachelines for ARMv7
 CPUs
In-Reply-To: <CAMQu2gxj_MZd_6BxYy2abshA-hcckrF0S1Zoi6v+5ELzc06rJQ@mail.gmail.com>
References: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
 <1326728658-10029-2-git-send-email-will.deacon@arm.com>
 <CAMQu2gxj_MZd_6BxYy2abshA-hcckrF0S1Zoi6v+5ELzc06rJQ@mail.gmail.com>
Message-ID: <20120116160931.GA32049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 04:52:14PM +0100, Shilimkar, Santosh wrote:
> Will,
> On Mon, Jan 16, 2012 at 4:44 PM, Will Deacon <will.deacon@arm.com> wrote:
> > To ensure correct alignment of cacheline-aligned data, the maximum
> > cacheline size needs to be known at compile time.
> >
> > Since Cortex-A8 and Cortex-A15 have 64-byte cachelines (and it is likely
> > that there will be future ARMv7 implementations with the same line size)
> > then it makes sense to assume that CPU_V7 implies a 64-byte L1 cacheline
> > size. For CPUs with smaller caches, this will result in some harmless
> > padding but will help with single zImage work and avoid hitting subtle
> > bugs with misaligned data structures.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > ?arch/arm/mm/Kconfig | ? ?2 +-
> > ?1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 4cefb57..493e5ea5 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -887,7 +887,7 @@ config ARM_L1_CACHE_SHIFT_6
> >
> > ?config ARM_L1_CACHE_SHIFT
> > ? ? ? ?int
> > - ? ? ? default 6 if ARM_L1_CACHE_SHIFT_6
> > + ? ? ? default 6 if ARM_L1_CACHE_SHIFT_6 || CPU_V7
> 
> Will be really harmless on A9 ? We have L2 also to be
> considered here which hard codes the line size as 32.

Going for a larger cache line size is safe: this is used for aligning
data structures and similar, and aligning to 64-byte means that it's
also 32-byte aligned.
