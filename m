From: ppannuto@codeaurora.org (Patrick Pannuto)
Date: Wed, 18 Aug 2010 12:15:43 -0700
Subject: [PATCH 4/4] msm: serial: Move msm_uart_driver onto msm bus
In-Reply-To: <1282158943-11902-1-git-send-email-ppannuto@codeaurora.org>
References: <1282158943-11902-1-git-send-email-ppannuto@codeaurora.org>
Message-ID: <1282158943-11902-5-git-send-email-ppannuto@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proof of concept; move one device / driver pair

Change-Id: I1afb6f54e6574057699db5b8f9fb7f4456a52010
Signed-off-by: Patrick Pannuto <ppannuto@codeaurora.org>
---
 arch/arm/mach-msm/board-qsd8x50.c |    3 ++-
 drivers/serial/msm_serial.c       |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index e3cc807..0deb369 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -27,6 +27,7 @@
 #include <asm/setup.h>
 
 #include <mach/board.h>
+#include <mach/msm_device.h>
 #include <mach/irqs.h>
 #include <mach/sirc.h>
 #include <mach/gpio.h>
@@ -65,7 +66,7 @@ static void __init qsd8x50_init_irq(void)
 static void __init qsd8x50_init(void)
 {
 	msm8x50_init_uart3();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	msm_device_register(&msm_device_uart3);
 }
 
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
diff --git a/drivers/serial/msm_serial.c b/drivers/serial/msm_serial.c
index f8c816e..3332fe7 100644
--- a/drivers/serial/msm_serial.c
+++ b/drivers/serial/msm_serial.c
@@ -32,6 +32,8 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 
+#include <mach/msm_device.h>
+
 #include "msm_serial.h"
 
 struct msm_port {
@@ -732,7 +734,7 @@ static int __init msm_serial_init(void)
 	if (unlikely(ret))
 		return ret;
 
-	ret = platform_driver_probe(&msm_platform_driver, msm_serial_probe);
+	ret = msm_driver_probe(&msm_platform_driver, msm_serial_probe);
 	if (unlikely(ret))
 		uart_unregister_driver(&msm_uart_driver);
 
-- 
1.7.2.1
