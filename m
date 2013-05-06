From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 May 2013 11:30:59 +0200
Subject: [RFC PATCH] implement read_cpuid_ext for v7-M (Was: Re: [PATCHv2
 2/3] ARM: Detect support for SDIV/UDIV from ISAR0) register
In-Reply-To: <20130418091019.GA21099@pengutronix.de>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
 <20130418091019.GA21099@pengutronix.de>
Message-ID: <20130506093059.GH23285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Apr 18, 2013 at 11:10:19AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Mar 18, 2013 at 11:28:56AM -0700, Stephen Boyd wrote:
> > The ISAR0 register indicates support for the SDIV and UDIV
> > instructions in both the Thumb and ARM instruction set. Read the
> > register to detect the supported instructions and update the
> > elf_hwcap mask as appropriate. This is better than adding more
> > and more cpuid checks in proc-v7.S for each new cpu variant that
> > supports these instructions.
> you pointed out yesterday that this could work on v7-m, too. As I based
> my patches on 3.9-rc1 this patch (8164f7af88) wasn't included. When
> updating this results in a warning, because I have
> 
> 	6ebd4d0 (ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n)
> 
> from rmk's devel-stable branch.
>  
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  arch/arm/kernel/setup.c | 20 ++++++++++++++++++++
> >  arch/arm/mm/proc-v7.S   |  4 ++--
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index e2c8bbf..f3ac13f 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -353,6 +353,23 @@ void __init early_print(const char *str, ...)
> >  	printk("%s", buf);
> >  }
> >  
> > +static void __init cpuid_init_hwcaps(void)
> > +{
> > +	unsigned int divide_instrs;
> > +
> > +	if (cpu_architecture() < CPU_ARCH_ARMv7)
> > +		return;
> > +
> > +	divide_instrs = (read_cpuid_ext(CPUID_EXT_ISAR0) & 0x0f000000) >> 24;
> The problem is that read_cpuid_ext is called which doesn't map to
> something useful for v7-m. So maybe add a check:
> 
> 	if (!IS_ENABLED(CONFIG_CPU_CP15))
> 		return;
> 
> ?
The patch below fixes the issue for me on V7-M. The only drawback is
that the list of registers isn't shared. Maybe someone has a nice idea?

BTW, there doesn't seem to be an equivalent register set for 
CPUID_{CACHETYPE,TCM,TLBTYPE,MPIDR} on v7-M.

Best regards
Uwe

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 4eb94a3..ec635ff 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -10,6 +10,22 @@
 #define CPUID_TLBTYPE	3
 #define CPUID_MPIDR	5
 
+#ifdef CONFIG_CPU_V7M
+#define CPUID_EXT_PFR0	0x40
+#define CPUID_EXT_PFR1	0x44
+#define CPUID_EXT_DFR0	0x48
+#define CPUID_EXT_AFR0	0x4c
+#define CPUID_EXT_MMFR0	0x50
+#define CPUID_EXT_MMFR1	0x54
+#define CPUID_EXT_MMFR2	0x58
+#define CPUID_EXT_MMFR3	0x5c
+#define CPUID_EXT_ISAR0	0x60
+#define CPUID_EXT_ISAR1	0x64
+#define CPUID_EXT_ISAR2	0x68
+#define CPUID_EXT_ISAR3	0x6c
+#define CPUID_EXT_ISAR4	0x70
+#define CPUID_EXT_ISAR5	0x74
+#else
 #define CPUID_EXT_PFR0	"c1, 0"
 #define CPUID_EXT_PFR1	"c1, 1"
 #define CPUID_EXT_DFR0	"c1, 2"
@@ -24,6 +40,7 @@
 #define CPUID_EXT_ISAR3	"c2, 3"
 #define CPUID_EXT_ISAR4	"c2, 4"
 #define CPUID_EXT_ISAR5	"c2, 5"
+#endif
 
 #define MPIDR_SMP_BITMASK (0x3 << 30)
 #define MPIDR_SMP_VALUE (0x2 << 30)
@@ -79,7 +96,23 @@ extern unsigned int processor_id;
 		__val;							\
 	})
 
-#else /* ifdef CONFIG_CPU_CP15 */
+#elif defined(CONFIG_CPU_V7M)
+
+#include <asm/io.h>
+#include <asm/v7m.h>
+
+#define read_cpuid(reg)							\
+	({								\
+		WARN_ON_ONCE(1);					\
+		0;							\
+	})
+
+static inline unsigned int __attribute_const__ read_cpuid_ext(unsigned offset)
+{
+	return readl(BASEADDR_V7M_SCB + offset);
+}
+
+#else /* ifdef CONFIG_CPU_CP15 / elif defined (CONFIG_CPU_V7M) */
 
 /*
  * read_cpuid and read_cpuid_ext should only ever be called on machines that
@@ -108,9 +141,6 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 
 #elif defined(CONFIG_CPU_V7M)
 
-#include <asm/io.h>
-#include <asm/v7m.h>
-
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
 {
 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 000499c..0c93588 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -144,7 +144,7 @@ __v7m_proc_info:
 	b	__v7m_setup		@ proc_info_list.__cpu_flush
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_IDIVT
+	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT
 	.long	cpu_v7m_name
 	.long	v7m_processor_functions	@ proc_info_list.proc
 	.long	0			@ proc_info_list.tlb

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
