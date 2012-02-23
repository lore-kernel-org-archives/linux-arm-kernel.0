From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Feb 2012 15:25:55 +0100
Subject: [PATCH v3 11/21] ARM: at91/PMC: move assignment out of printf
In-Reply-To: <cover.1330006537.git.nicolas.ferre@atmel.com>
References: <cover.1330006537.git.nicolas.ferre@atmel.com>
Message-ID: <940192e3c651eb6b97b42cb4c28e9e8471675cd2.1330006537.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We move the assignment of values of register out of the
seq_printf() calls: It is obviously more readable.

Reported-by: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/clock.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index d1b4e07..9ab8627 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -432,19 +432,24 @@ static int at91_clk_show(struct seq_file *s, void *unused)
 	u32		scsr, pcsr, uckr = 0, sr;
 	struct clk	*clk;
 
-	seq_printf(s, "SCSR = %8x\n", scsr = at91_sys_read(AT91_PMC_SCSR));
-	seq_printf(s, "PCSR = %8x\n", pcsr = at91_sys_read(AT91_PMC_PCSR));
+	scsr = at91_sys_read(AT91_PMC_SCSR);
+	pcsr = at91_sys_read(AT91_PMC_PCSR);
+	sr = at91_sys_read(AT91_PMC_SR);
+	seq_printf(s, "SCSR = %8x\n", scsr);
+	seq_printf(s, "PCSR = %8x\n", pcsr);
 	seq_printf(s, "MOR  = %8x\n", at91_sys_read(AT91_CKGR_MOR));
 	seq_printf(s, "MCFR = %8x\n", at91_sys_read(AT91_CKGR_MCFR));
 	seq_printf(s, "PLLA = %8x\n", at91_sys_read(AT91_CKGR_PLLAR));
 	if (cpu_has_pllb())
 		seq_printf(s, "PLLB = %8x\n", at91_sys_read(AT91_CKGR_PLLBR));
-	if (cpu_has_utmi())
-		seq_printf(s, "UCKR = %8x\n", uckr = at91_sys_read(AT91_CKGR_UCKR));
+	if (cpu_has_utmi()) {
+		uckr = at91_sys_read(AT91_CKGR_UCKR);
+		seq_printf(s, "UCKR = %8x\n", uckr);
+	}
 	seq_printf(s, "MCKR = %8x\n", at91_sys_read(AT91_PMC_MCKR));
 	if (cpu_has_upll())
 		seq_printf(s, "USB  = %8x\n", at91_sys_read(AT91_PMC_USB));
-	seq_printf(s, "SR   = %8x\n", sr = at91_sys_read(AT91_PMC_SR));
+	seq_printf(s, "SR   = %8x\n", sr);
 
 	seq_printf(s, "\n");
 
-- 
1.7.9
