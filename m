From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Aug 2015 22:56:58 +0100
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55CE63BD.2060107@ti.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com>
 <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <1439562059.13210.61.camel@pengutronix.de>
 <55CE63BD.2060107@ti.com>
Message-ID: <20150814215658.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 05:55:09PM -0400, Murali Karicheri wrote:
> On 08/14/2015 10:20 AM, Lucas Stach wrote:
> >Hi Russell,
> >
> >Am Freitag, den 14.08.2015, 15:09 +0100 schrieb Russell King - ARM
> >Linux:
> >
> >[...]
> >
> >>
> >>What causes the abort?  We shouldn't be adding hacks like this to the
> >>kernel without having the full picture...
> >>
> >
> >some of the issues with tracking down such imprecise external aborts are
> >due to the fact that we only enable the signaling of those aborts on
> >entering the user-space. So the first schedule() crashes on the previous
> >dangling abort.
> >
> >I'm carrying this patch locally to enable imprecise aborts much earlier
> >in the boot process. I think it has already been on the list some times,
> >but apparently it has fallen through the cracks. If you agree that this
> >is the right thing to do I can do a proper repost.
> Lucas,
> 
> Would you mind sharing the code? Does that help in root causing where it
> actually happens? I have spend considerable time debugging this, but so far
> not successful.

If you look below, Lucas provided the patch.

> 
> Murali
> >
> >Regards,
> >Lucas
> >
> >---------------------->8---------------------------------------------
> >>From bb9117d94cc2f1061dc364f42c446ccd9191e869 Mon Sep 17 00:00:00 2001
> >From: Lucas Stach <l.stach@pengutronix.de>
> >Date: Thu, 19 Feb 2015 18:12:50 +0100
> >Subject: [PATCH] ARM: Add imprecise abort enable/disable macro
> >
> >This patch adds imprecise abort enable/disable macros.
> >It also enables imprecise aborts when starting kernel.
> >
> >Changes in v2:
> >Only ARMv6 and later have CPSR.A bit. On earlier CPUs,
> >and ARMv7M this should be a no-op.
> >
> >Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >---
> >lst: rebased on v3.19
> >---
> >  arch/arm/include/asm/irqflags.h | 10 ++++++++++
> >  arch/arm/kernel/smp.c           |  1 +
> >  arch/arm/kernel/traps.c         |  4 ++++
> >  3 files changed, 15 insertions(+)
> >
> >diff --git a/arch/arm/include/asm/irqflags.h
> >b/arch/arm/include/asm/irqflags.h
> >index 3b763d6652a0..8301f875564e 100644
> >--- a/arch/arm/include/asm/irqflags.h
> >+++ b/arch/arm/include/asm/irqflags.h
> >@@ -51,6 +51,14 @@ static inline void arch_local_irq_disable(void)
> >
> >  #define local_fiq_enable()  __asm__("cpsie f   @ __stf" : : : "memory",
> >"cc")
> >  #define local_fiq_disable() __asm__("cpsid f   @ __clf" : : : "memory",
> >"cc")
> >+
> >+#ifndef CONFIG_CPU_V7M
> >+#define local_abt_enable()  __asm__("cpsie a   @ __sta" : : : "memory",
> >"cc")
> >+#define local_abt_disable() __asm__("cpsid a   @ __cla" : : : "memory",
> >"cc")
> >+#else
> >+#define local_abt_enable()     do { } while (0)
> >+#define local_abt_disable()    do { } while (0)
> >+#endif
> >  #else
> >
> >  /*
> >@@ -130,6 +138,8 @@ static inline void arch_local_irq_disable(void)
> >         : "memory", "cc");                                      \
> >         })
> >
> >+#define local_abt_enable()     do { } while (0)
> >+#define local_abt_disable()    do { } while (0)
> >  #endif
> >
> >  /*
> >diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> >index 86ef244c5a24..7b6b93cabef4 100644
> >--- a/arch/arm/kernel/smp.c
> >+++ b/arch/arm/kernel/smp.c
> >@@ -378,6 +378,7 @@ asmlinkage void secondary_start_kernel(void)
> >
> >         local_irq_enable();
> >         local_fiq_enable();
> >+       local_abt_enable();
> >
> >         /*
> >          * OK, it's off to the idle thread for us
> >diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> >index 788e23fe64d8..466726ba9bdb 100644
> >--- a/arch/arm/kernel/traps.c
> >+++ b/arch/arm/kernel/traps.c
> >@@ -881,6 +881,10 @@ void __init early_trap_init(void *vectors_base)
> >
> >         flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
> >         modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
> >+
> >+       /* Enable imprecise aborts */
> >+       local_abt_enable();
> >+
> >  #else /* ifndef CONFIG_CPU_V7M */
> >         /*
> >          * on V7-M there is no need to copy the vector table to a
> >dedicated
> >
> 
> 
> -- 
> Murali Karicheri
> Linux Kernel, Keystone

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
