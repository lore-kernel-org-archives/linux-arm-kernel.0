From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 14 Oct 2009 14:58:06 -0700
Subject: [PATCH 23/27] OMAP3: PM: Fix INTC context save/restore
In-Reply-To: <1255557490-16787-23-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-23-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255557490-16787-24-git-send-email-khilman@deeprootsystems.com>
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
index fa2524d..aceedd8 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -233,7 +233,7 @@ void omap3_intc_save_context(void)
 			intc_bank_read_reg(bank, INTC_THRESHOLD);
 		for (i = 0; i < INTCPS_NR_IRQS; i++)
 			intc_context[ind].ilr[i] =
-				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
+				intc_bank_read_reg(bank, (0x100 + 0x4*i));
 		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
 			intc_context[ind].mir[i] =
 				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
@@ -259,7 +259,7 @@ void omap3_intc_restore_context(void)
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
