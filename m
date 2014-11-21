From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 21 Nov 2014 22:32:48 +0100
Subject: IRQ #0 broken on ARM
In-Reply-To: <546F1F45.7080103@arm.com> (Marc Zyngier's message of "Fri, 21
 Nov 2014 11:17:25 +0000")
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
 <20141121110135.GS4042@n2100.arm.linux.org.uk>
 <546F1F45.7080103@arm.com>
Message-ID: <87egsw5jen.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:
>> Linus has decreed it to not be a valid IRQ number, and that's basically
>> the end of the discussion.  Generic code, and drivers, will increasingly
>> decide that IRQ0 is not valid, and objecting to it has, and will continue
>> to elicit a response of "fix ARM".
>
> I'm fine with that.
For pxa, why not do something like that [1] ?

Cheers.

--
Robert

[1]
---8>---

>From 551eaf75934bd84939a40781470ed3c04d17507a Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 21 Nov 2014 22:11:42 +0100
Subject: [PATCH] ARM: pxa: arbitrarily set first interrupt number

As IRQ0, the legacy timer interrupt should not be used as an interrupt
number, shift the interrupts by a fixed number.

As we had in a special case a shift of 16 when ISA bus was used on a
PXA, use that value as the first interrupt number, regardless of ISA or
not.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/include/mach/irqs.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 48c2fd8..9d8983f 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -14,12 +14,9 @@
 
 #ifdef CONFIG_PXA_HAVE_ISA_IRQS
 #define PXA_ISA_IRQ(x)	(x)
-#define PXA_ISA_IRQ_NUM	(16)
-#else
-#define PXA_ISA_IRQ_NUM	(0)
 #endif
 
-#define PXA_IRQ(x)	(PXA_ISA_IRQ_NUM + (x))
+#define PXA_IRQ(x)	(16 + (x))
 
 #define IRQ_SSP3	PXA_IRQ(0)	/* SSP3 service request */
 #define IRQ_MSL		PXA_IRQ(1)	/* MSL Interface interrupt */
-- 
2.1.0
