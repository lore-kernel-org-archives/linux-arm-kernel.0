From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 14 May 2012 21:46:11 +0400
Subject: [PATCH 4/4] ARM clps711x: Removed unused header mach/time.h
In-Reply-To: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
References: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
Message-ID: <1337017571-16208-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All functions from this header already provided by common.c

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/time.h |   49 ----------------------------
 1 files changed, 0 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/time.h

diff --git a/arch/arm/mach-clps711x/include/mach/time.h b/arch/arm/mach-clps711x/include/mach/time.h
deleted file mode 100644
index 5f65865..0000000
--- a/arch/arm/mach-clps711x/include/mach/time.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/time.h
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <asm/leds.h>
-#include <mach/hardware.h>
-
-extern void clps711x_setup_timer(void);
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t
-p720t_timer_interrupt(int irq, void *dev_id)
-{
-	struct pt_regs *regs = get_irq_regs();
-	do_leds();
-	xtime_update(1);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
-	do_profile(regs);
-	return IRQ_HANDLED;
-}
-
-/*
- * Set up timer interrupt, and return the current time in seconds.
- */
-void __init time_init(void)
-{
-	clps711x_setup_timer();
-	timer_irq.handler = p720t_timer_interrupt;
-	setup_irq(IRQ_TC2OI, &timer_irq);
-}
-- 
1.7.3.4
