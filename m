From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:48:56 +0100
Subject: [PATCH 6/7] ARM: nommu: Don't build smp_tlb.c for !CONFIG_MMU
In-Reply-To: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
References: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368532137-8871-7-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without an MMU we don't need to do any TLB maintenance. Until the addition
of 93dc68876b60 (ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181
(TLBI/DSB operations)) building the tlb maintenance ops in smp_tlb.c worked,
though none of the contents were used.

Since that commit, however, SMP NOMMU has not been able to build. This patch
restores that ability by making the building of smp_tlb.c dependent on MMU.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 5f3338e..9314500 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -32,7 +32,10 @@ obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
 obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
-obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
+obj-$(CONFIG_SMP)		+= smp.o
+ifdef CONFIG_MMU
+obj-$(CONFIG_SMP)		+= smp_tlb.o
+endif
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
-- 
1.7.9.5
