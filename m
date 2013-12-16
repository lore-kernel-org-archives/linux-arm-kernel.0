From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Dec 2013 10:48:16 +0100
Subject: [PATCH] ARM: show_regs: on v7-M there are no FIQs,
 different processor modes, ...
In-Reply-To: <20131210212550.GF18888@pengutronix.de>
References: <20131210212550.GF18888@pengutronix.de>
Message-ID: <1387187296-7558-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no indication about irqs in PSR and only a single ISA. So skip the whole
decoding and just print the xPSR on v7-M.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 541843b..e9d4b42 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
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
+	printk("xPSR: %08x\n", regs->ARM_cpsr);
+#endif
+
 #ifdef CONFIG_CPU_CP15
 	{
 		unsigned int ctrl;
-- 
1.8.4.4
