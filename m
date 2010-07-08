From: tony@atomide.com (Tony Lindgren)
Date: Thu, 08 Jul 2010 16:54:25 +0300
Subject: [PATCH 01/13] omap: Add back UART MDR1 check into uncompress.h
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Message-ID: <20100708135425.26276.39703.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent DEBUG_LL and uncompress.h changes removed the check_port()
as pointed out by Cory Maccarrone <darkstar6262@gmail.com>.

This causes some boards to not boot, so add back the MDR1 register
check. The MDR1 register tells the mode of omap uart. Based on
an earlier patch by Cory Maccarrone <darkstar6262@gmail.com>.

Tested-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index bbedd71..ddf723b 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -25,6 +25,8 @@
 
 #include <plat/serial.h>
 
+#define MDR1_MODE_MASK			0x07
+
 static volatile u8 *uart_base;
 static int uart_shift;
 
@@ -42,6 +44,10 @@ static void putc(int c)
 	if (!uart_base)
 		return;
 
+	/* Check for UART 16x mode */
+	if ((uart_base[UART_OMAP_MDR1 << uart_shift] & MDR1_MODE_MASK) != 0)
+		return;
+
 	while (!(uart_base[UART_LSR << uart_shift] & UART_LSR_THRE))
 		barrier();
 	uart_base[UART_TX << uart_shift] = c;
