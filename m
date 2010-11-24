From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 24 Nov 2010 11:09:03 -0800
Subject: [PATCH] OMAP: UART: don't resume UARTs that are not enabled.
Message-ID: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add additional check to omap_uart_resume_idle() so that only
enabled (specfically, idle-enabled) UARTs are allowed to resume.
This matches the existing check in prepare idle.

Cc: Govindraj R. <govindraj.raja@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Unless there are any objections, this will be queued in pm-next for 2.6.38.

 arch/arm/mach-omap2/serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index becf0e3..bc934db 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -406,7 +406,7 @@ void omap_uart_resume_idle(int num)
 	struct omap_uart_state *uart;
 
 	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num) {
+		if (num == uart->num && uart->can_sleep) {
 			omap_uart_enable_clocks(uart);
 
 			/* Check for IO pad wakeup */
-- 
1.7.2.1
