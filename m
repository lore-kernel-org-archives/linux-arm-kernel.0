From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 11 Jan 2017 15:36:28 +0900
Subject: [PATCH v29 4/9] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20170110113248.GC21598@arm.com>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-3-takahiro.akashi@linaro.org>
 <20170110113248.GC21598@arm.com>
Message-ID: <20170111063626.GE20972@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Jan 10, 2017 at 11:32:48AM +0000, Will Deacon wrote:
> On Wed, Dec 28, 2016 at 01:36:01PM +0900, AKASHI Takahiro wrote:
> > Primary kernel calls machine_crash_shutdown() to shut down non-boot cpus
> > and save registers' status in per-cpu ELF notes before starting crash
> > dump kernel. See kernel_kexec().
> > Even if not all secondary cpus have shut down, we do kdump anyway.
> > 
> > As we don't have to make non-boot(crashed) cpus offline (to preserve
> > correct status of cpus at crash dump) before shutting down, this patch
> > also adds a variant of smp_send_stop().
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/hardirq.h  |  2 +-
> >  arch/arm64/include/asm/kexec.h    | 42 +++++++++++++++++++++++++-
> >  arch/arm64/include/asm/smp.h      |  2 ++
> >  arch/arm64/kernel/machine_kexec.c | 56 ++++++++++++++++++++++++++++++++--
> >  arch/arm64/kernel/smp.c           | 63 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 160 insertions(+), 5 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> > index d050d720a1b4..cea009f2657d 100644
> > --- a/arch/arm64/include/asm/smp.h
> > +++ b/arch/arm64/include/asm/smp.h
> > @@ -148,6 +148,8 @@ static inline void cpu_panic_kernel(void)
> >   */
> >  bool cpus_are_stuck_in_kernel(void);
> >  
> > +extern void smp_send_crash_stop(void);
> > +
> >  #endif /* ifndef __ASSEMBLY__ */
> >  
> >  #endif /* ifndef __ASM_SMP_H */
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index bc96c8a7fc79..c60346d33bb1 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -9,6 +9,9 @@
> >   * published by the Free Software Foundation.
> >   */
> >  
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> >  #include <linux/kexec.h>
> >  #include <linux/smp.h>
> >  
> > @@ -22,6 +25,7 @@
> >  extern const unsigned char arm64_relocate_new_kernel[];
> >  extern const unsigned long arm64_relocate_new_kernel_size;
> >  
> > +static bool in_crash_kexec;
> 
> Do you actually need this bool? Why not call kexec_crash_loaded() instead?

The two have different meanings:
"in_crash_kexec" indicates that kdump is taking place, while
kexec_crash_loaded() tells us only whether crash dump kernel has been
loaded or not.

It is crucial to distinguish them especially for machine_kexec()
which can be called on normal kexec even if kdump has been set up.

Thanks,
-Takahiro AKASHI

> Will
