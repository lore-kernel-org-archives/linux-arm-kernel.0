From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Aug 2011 17:21:21 +0100
Subject: [PATCH 1/3] ARM: Make cpu_alignment into a global variable
In-Reply-To: <alpine.LFD.2.00.1108161214520.20358@xanadu.home>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313504053-27873-2-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1108161214520.20358@xanadu.home>
Message-ID: <20110816162121.GD1993@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 12:15:59PM -0400, Nicolas Pitre wrote:
> On Tue, 16 Aug 2011, Dave Martin wrote:
> 
> > The CPU architecture really should not be changing at runtime, so
> > make it a global variable instead of a function.
> > 
> > The cpu_architecture() function in <asm/system.h> remains the
> > correct way to read this variable from C code.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks
---Dave

> 
> > ---
> >  arch/arm/include/asm/system.h |   11 ++++++++++-
> >  arch/arm/kernel/setup.c       |    5 ++++-
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > index 832888d..b0445f7 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -57,6 +57,8 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > +#include <linux/bug.h>
> > +#include <linux/compiler.h>
> >  #include <linux/linkage.h>
> >  #include <linux/irqflags.h>
> >  
> > @@ -104,7 +106,14 @@ struct mm_struct;
> >  extern void show_pte(struct mm_struct *mm, unsigned long addr);
> >  extern void __show_regs(struct pt_regs *);
> >  
> > -extern int cpu_architecture(void);
> > +extern int __cpu_architecture;
> > +
> > +static inline int __pure cpu_architecture(void)
> > +{
> > +	BUG_ON(__cpu_architecture == CPU_ARCH_UNKNOWN);
> > +	return __cpu_architecture;
> > +}
> > +
> >  extern void cpu_init(void);
> >  
> >  void arm_machine_restart(char mode, const char *cmd);
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 70bca64..1e0c1b3 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -42,6 +42,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/cachetype.h>
> >  #include <asm/tlbflush.h>
> > +#include <asm/system.h>
> >  
> >  #include <asm/prom.h>
> >  #include <asm/mach/arch.h>
> > @@ -114,6 +115,7 @@ struct cpu_cache_fns cpu_cache __read_mostly;
> >  struct outer_cache_fns outer_cache __read_mostly;
> >  EXPORT_SYMBOL(outer_cache);
> >  #endif
> > +int __cpu_architecture __read_mostly = CPU_ARCH_UNKNOWN;
> >  
> >  struct stack {
> >  	u32 irq[3];
> > @@ -210,7 +212,7 @@ static const char *proc_arch[] = {
> >  	"?(17)",
> >  };
> >  
> > -int cpu_architecture(void)
> > +static int __init __get_cpu_architecture(void)
> >  {
> >  	int cpu_arch;
> >  
> > @@ -413,6 +415,7 @@ static void __init setup_processor(void)
> >  	}
> >  
> >  	cpu_name = list->cpu_name;
> > +	__cpu_architecture = __get_cpu_architecture();
> >  
> >  #ifdef MULTI_CPU
> >  	processor = *list->proc;
> > -- 
> > 1.7.4.1
> > 
