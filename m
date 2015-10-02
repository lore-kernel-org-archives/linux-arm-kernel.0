From: scottwood@freescale.com (Scott Wood)
Date: Thu, 1 Oct 2015 19:16:16 -0500
Subject: [PATCH] serial: Enable Freescale 16550 workaround on arm
Message-ID: <20151002001616.GA3885@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The same serial hardware is present on LS2080A which is arm64, and
LS1021A which is arm32, so don't limit the workaround to PPC.

Unlike PPC which uses arch/powerpc/kernel/legacy_serial.c, the ARM
targets use drivers/tty/serial/of_serial.c, so add the handle_irq
override check there as well.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/tty/serial/8250/Kconfig | 4 ++--
 drivers/tty/serial/of_serial.c  | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e1de118..5a2ae57 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -274,8 +274,8 @@ config SERIAL_8250_ACORN
 
 config SERIAL_8250_FSL
 	bool
-	depends on SERIAL_8250_CONSOLE && PPC_UDBG_16550
-	default PPC
+	depends on SERIAL_8250_CONSOLE
+	default PPC || ARM || ARM64
 
 config SERIAL_8250_DW
 	tristate "Support for Synopsys DesignWare 8250 quirks"
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 6823df9..9cd0061 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -150,6 +150,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		break;
 	}
 
+#ifdef CONFIG_SERIAL_8250_FSL
+	if (of_device_is_compatible(np, "fsl,ns16550") ||
+	    of_device_is_compatible(np, "fsl,16550-FIFO64"))
+		port->handle_irq = fsl8250_handle_irq;
+#endif
+
 	return 0;
 out:
 	if (info->clk)
-- 
2.1.4
