From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 29 Sep 2011 11:22:13 +0100
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <4E8403BE.9050302@ti.com>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
	<4E8403BE.9050302@ti.com>
Message-ID: <20110929102213.GB7453@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 06:35:58AM +0100, Santosh Shilimkar wrote:
> Barry,
> 
> On Monday 26 September 2011 08:56 AM, Barry Song wrote:
> > we save the l2x0 registers at the first initialization, and platform codes
> > can get them to restore l2x0 status after wakeup.
> > 
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---

[...]

> > +
> > +struct l2x0_regs {
> > +	unsigned long aux_ctrl;
> > +	/*
> > +	 * Whether the following registers need to be saved/restored
> > +	 * depends on platform
> > +	 */
> > +	unsigned long tag_latency;
> > +	unsigned long data_latency;
> > +	unsigned long filter_start;
> > +	unsigned long filter_end;
> > +};
> > +
> You are missing POR register here which is available on
> PL310 versions. You should add that.
> 

In latest versions there are Prefetch and Power control registers, but
it depends on the revision. What should we do in this case Santosh ?
PCR is a superset of POR from r3p0 onwards, but Power control ? Leave it
to platform code ?

> [...]
> >  static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
> > diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> > index 16baba2..b8d72a8 100644
> > --- a/arch/arm/kernel/asm-offsets.c
> > +++ b/arch/arm/kernel/asm-offsets.c
> > @@ -20,6 +20,7 @@
> >  #include <asm/thread_info.h>
> >  #include <asm/memory.h>
> >  #include <asm/procinfo.h>
> > +#include <asm/hardware/cache-l2x0.h>
> >  #include <linux/kbuild.h>
> >  
> >  /*
> > @@ -92,6 +93,14 @@ int main(void)
> >    DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
> >    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
> >    BLANK();
> > +#ifdef CONFIG_CACHE_L2X0
> > +  DEFINE(L2X0_R_AUX_CTRL,	offsetof(struct l2x0_regs, aux_ctrl));
> > +  DEFINE(L2X0_R_TAG_LATENCY,	offsetof(struct l2x0_regs, tag_latency));
> > +  DEFINE(L2X0_R_DATA_LATENCY,	offsetof(struct l2x0_regs, data_latency));
> > +  DEFINE(L2X0_R_FILTER_START,	offsetof(struct l2x0_regs, filter_start));
> > +  DEFINE(L2X0_R_FILTER_END,	offsetof(struct l2x0_regs, filter_end));
> Add POR as commented earlier.

See above.

Thanks,
Lorenzo
