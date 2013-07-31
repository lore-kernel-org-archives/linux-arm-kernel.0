From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:01 -0700
Subject: [PATCH 02/18] ARM: clps711x: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-clps711x/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 4ca2f3c..5e5a6ac 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -259,7 +259,7 @@ asmlinkage void __exception_irq_entry clps711x_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-static u32 notrace clps711x_sched_clock_read(void)
+static u64 notrace clps711x_sched_clock_read(void)
 {
 	return ~readw_relaxed(CLPS711X_VIRT_BASE + TC1D);
 }
@@ -366,7 +366,7 @@ void __init clps711x_timer_init(void)
 	tmp = clps_readl(SYSCON1) & ~(SYSCON1_TC1S | SYSCON1_TC1M);
 	clps_writel(tmp, SYSCON1);
 
-	setup_sched_clock(clps711x_sched_clock_read, 16, timl);
+	sched_clock_register(clps711x_sched_clock_read, 16, timl);
 
 	clocksource_mmio_init(CLPS711X_VIRT_BASE + TC1D,
 			      "clps711x_clocksource", timl, 300, 16,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
