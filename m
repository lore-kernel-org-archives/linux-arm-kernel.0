From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  3 Feb 2014 17:37:22 +0100
Subject: [PATCH 2/3] ARM: show_regs: on v7-M there are no FIQs,
 different processor modes, ...
In-Reply-To: <1391445443-28971-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1391445443-28971-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1391445443-28971-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no indication about irqs in PSR and only a single ISA. So skip the whole
decoding and just print the xPSR on v7-M.

Also mark two static variables as __maybe_unused to prevent the compiler
from emitting:

	arch/arm/kernel/process.c:51:20: warning: 'processor_modes' defined but not used [-Wunused-variable]
	arch/arm/kernel/process.c:58:20: warning: 'isa_modes' defined but not used [-Wunused-variable]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/process.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15dd221..204f7d273319 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -48,14 +48,14 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
-static const char *processor_modes[] = {
+static const char *processor_modes[] __maybe_unused = {
   "USER_26", "FIQ_26" , "IRQ_26" , "SVC_26" , "UK4_26" , "UK5_26" , "UK6_26" , "UK7_26" ,
   "UK8_26" , "UK9_26" , "UK10_26", "UK11_26", "UK12_26", "UK13_26", "UK14_26", "UK15_26",
   "USER_32", "FIQ_32" , "IRQ_32" , "SVC_32" , "UK4_32" , "UK5_32" , "UK6_32" , "ABT_32" ,
   "UK8_32" , "UK9_32" , "UK10_32", "UND_32" , "UK12_32", "UK13_32", "UK14_32", "SYS_32"
 };
 
-static const char *isa_modes[] = {
+static const char *isa_modes[] __maybe_unused = {
   "ARM" , "Thumb" , "Jazelle", "ThumbEE"
 };
 
@@ -276,12 +276,17 @@ void __show_regs(struct pt_regs *regs)
 	buf[3] = flags & PSR_V_BIT ? 'V' : 'v';
 	buf[4] = '\0';
 
+#ifndef CONFIG_CPU_V7M
 	printk("Flags: %s  IRQs o%s  FIQs o%s  Mode %s  ISA %s  Segment %s\n",
 		buf, interrupts_enabled(regs) ? "n" : "ff",
 		fast_interrupts_enabled(regs) ? "n" : "ff",
 		processor_modes[processor_mode(regs)],
 		isa_modes[isa_mode(regs)],
 		get_fs() == get_ds() ? "kernel" : "user");
+#else
+	printk("xPSR: %08lx\n", regs->ARM_cpsr);
+#endif
+
 #ifdef CONFIG_CPU_CP15
 	{
 		unsigned int ctrl;
-- 
1.8.5.3
