From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 22 Oct 2009 16:09:44 -0700
Subject: [PATCH v2 23/32] OMAP3: PM: Fix INTC context save/restore
In-Reply-To: <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

Wrong index was used for ILR.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ebd3538..e9bc782 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -241,7 +241,7 @@ void omap_intc_save_context(void)
 			intc_bank_read_reg(bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_context[ind].ilr[i] =
-				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
+				intc_bank_read_reg(bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_context[ind].mir[i] =
 				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
@@ -267,7 +267,7 @@ void omap_intc_restore_context(void)
 					bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_bank_write_reg(intc_context[ind].ilr[i],
-				bank, (0x100 + 0x4*ind));
+				bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_bank_write_reg(intc_context[ind].mir[i],
 				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
-- 
1.6.4.3
