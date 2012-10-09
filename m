From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:22:58 +0200
Subject: [PATCH 4/9] ARM: export default read_current_timer
In-Reply-To: <1349796183-30648-1-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796183-30648-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read_current_timer is used by get_cycles since "ARM: 7538/1: delay:
add registration mechanism for delay timer sources", and get_cycles
can be used by device drivers in loadable modules, so it has to
be exported.

Without this patch, building imote2_defconfig fails with

ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/lib/delay.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 9d0a300..0dc5385 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -45,6 +45,7 @@ int read_current_timer(unsigned long *timer_val)
 	*timer_val = delay_timer->read_current_timer();
 	return 0;
 }
+EXPORT_SYMBOL_GPL(read_current_timer);
 
 static void __timer_delay(unsigned long cycles)
 {
-- 
1.7.10
