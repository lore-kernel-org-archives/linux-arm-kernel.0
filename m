From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:21 -0700
Subject: [PATCH 30/34] Davinci: serial - remove unnecessary define
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-31-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

The uart pdata array is already terminated by a zero flag field.

This patch reuses this terminator and eliminates DAVINCI_MAX_NR_UARTS
definition.  This way, future platforms can have different number of uarts
initialized via davinci_serial_init().

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/serial.h |    1 -
 arch/arm/mach-davinci/serial.c              |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index a584697..f6c4f34 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -13,7 +13,6 @@
 
 #include <mach/hardware.h>
 
-#define DAVINCI_MAX_NR_UARTS	3
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
 #define DAVINCI_UART2_BASE	(IO_PHYS + 0x20800)
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 7ce5ba0..709e1a9 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -77,7 +77,7 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on if not needed.
 	 */
-	for (i = 0; i < DAVINCI_MAX_NR_UARTS; i++, p++) {
+	for (i = 0; p->flags; i++, p++) {
 		if (!(info->enabled_uarts & (1 << i)))
 			continue;
 
-- 
1.7.0.2
