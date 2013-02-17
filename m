From: hechtb@gmail.com (Bastian Hecht)
Date: Sun, 17 Feb 2013 16:20:25 -0600
Subject: [PATCH 05/06] ARM: shmobile: Common shmobile_scu_base in
 headsmp-scu.S
In-Reply-To: <20130213134717.12153.6162.sendpatchset@w520>
References: <20130213134628.12153.47120.sendpatchset@w520>
 <20130213134717.12153.6162.sendpatchset@w520>
Message-ID: <CABYn4syysDVAKRpjDUc9j26SgmUcjxV3rNf3u2kZMZWurhrjiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this breaks the secondary CPU startup when I test it. I think you
can't access shmobile_scu_address this way with the MMU still turned
off.

But instead of
> +       ldr     r1, =shmobile_scu_base
> +       ldr     r1, [r1]                @ SCU base address

try

+        mrc     p15, 4, r1, c15, c0, 0 @ get SCU base address

to get it from the coprocessor.

Cheers,

 Bastian


2013/2/13 Magnus Damm <magnus.damm@gmail.com>:
> From: Magnus Damm <damm@opensource.se>
>
> Update the code in headsmp-scu.S to use a global
> shmobile_scu_base variable both for convenient SCU
> base address storage and for the early SCU setup
> code in shmobile_secondary_vector_scu.
>
> With this patch applied r8a7779, sh73a0 and EMEV2
> all make use of the global shmobile_scu_base
> variable. However only sh73a0 makes use of the SCU
> bring up code in shmobile_secondary_vector_scu.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/Makefile              |    4 ++--
>  arch/arm/mach-shmobile/headsmp-scu.S         |    8 +++++++-
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/smp-emev2.c           |    2 --
>  arch/arm/mach-shmobile/smp-r8a7779.c         |    2 --
>  arch/arm/mach-shmobile/smp-sh73a0.c          |    2 --
>  6 files changed, 10 insertions(+), 9 deletions(-)
>
> --- 0009/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile        2013-02-13 21:54:34.000000000 +0900
> @@ -16,8 +16,8 @@ obj-$(CONFIG_ARCH_EMEV2)      += setup-emev2.
>  smp-y                          := platsmp.o headsmp.o
>  smp-$(CONFIG_HOTPLUG_CPU)      += hotplug.o
>  smp-$(CONFIG_ARCH_SH73A0)      += smp-sh73a0.o headsmp-scu.o
> -smp-$(CONFIG_ARCH_R8A7779)     += smp-r8a7779.o
> -smp-$(CONFIG_ARCH_EMEV2)       += smp-emev2.o
> +smp-$(CONFIG_ARCH_R8A7779)     += smp-r8a7779.o headsmp-scu.o
> +smp-$(CONFIG_ARCH_EMEV2)       += smp-emev2.o headsmp-scu.o
>
>  # IRQ objects
>  obj-$(CONFIG_ARCH_SH7372)      += entry-intc.o
> --- 0009/arch/arm/mach-shmobile/headsmp-scu.S
> +++ work/arch/arm/mach-shmobile/headsmp-scu.S   2013-02-13 21:54:27.000000000 +0900
> @@ -39,7 +39,8 @@ ENTRY(shmobile_secondary_vector_scu)
>         mrc     p15, 0, r0, c0, c0, 5   @ read MIPDR
>         and     r0, r0, #3              @ mask out cpu ID
>         lsl     r0, r0, #3              @ we will shift by cpu_id * 8 bits
> -       mov     r1, #0xf0000000         @ SCU base address
> +       ldr     r1, =shmobile_scu_base
> +       ldr     r1, [r1]                @ SCU base address
>         ldr     r2, [r1, #8]            @ SCU Power Status Register
>         mov     r3, #3
>         bic     r2, r2, r3, lsl r0      @ Clear bits of our CPU (Run Mode)
> @@ -48,3 +49,8 @@ ENTRY(shmobile_secondary_vector_scu)
>         ldr     pc, 1f
>  1:     .long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
>  ENDPROC(shmobile_secondary_vector_scu)
> +
> +       .text
> +       .globl  shmobile_scu_base
> +shmobile_scu_base:
> +       .space  4
> --- 0009/arch/arm/mach-shmobile/include/mach/common.h
> +++ work/arch/arm/mach-shmobile/include/mach/common.h   2013-02-13 21:54:27.000000000 +0900
> @@ -96,6 +96,7 @@ extern int shmobile_cpu_is_dead(unsigned
>  static inline int shmobile_cpu_is_dead(unsigned int cpu) { return 1; }
>  #endif
>
> +extern void __iomem *shmobile_scu_base;
>  extern void shmobile_smp_init_cpus(unsigned int ncores);
>
>  static inline void __init shmobile_init_late(void)
> --- 0008/arch/arm/mach-shmobile/smp-emev2.c
> +++ work/arch/arm/mach-shmobile/smp-emev2.c     2013-02-13 21:54:27.000000000 +0900
> @@ -32,8 +32,6 @@
>
>  #define EMEV2_SCU_BASE 0x1e000000
>
> -static void __iomem *shmobile_scu_base;
> -
>  static DEFINE_SPINLOCK(scu_lock);
>
>  static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
> --- 0007/arch/arm/mach-shmobile/smp-r8a7779.c
> +++ work/arch/arm/mach-shmobile/smp-r8a7779.c   2013-02-13 21:54:27.000000000 +0900
> @@ -33,8 +33,6 @@
>  #define AVECR IOMEM(0xfe700040)
>  #define R8A7779_SCU_BASE IOMEM(0xf0000000)
>
> -static void __iomem *shmobile_scu_base;
> -
>  static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
>         .chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
>         .chan_bit = 1, /* ARM1 */
> --- 0009/arch/arm/mach-shmobile/smp-sh73a0.c
> +++ work/arch/arm/mach-shmobile/smp-sh73a0.c    2013-02-13 21:54:27.000000000 +0900
> @@ -41,8 +41,6 @@
>
>  #define SH73A0_SCU_BASE IOMEM(0xf0000000)
>
> -static void __iomem *shmobile_scu_base;
> -
>  #ifdef CONFIG_HAVE_ARM_TWD
>  static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
>  void __init sh73a0_register_twd(void)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
