From: scottwood@freescale.com (Scott Wood)
Date: Wed, 7 Oct 2015 17:31:21 -0500
Subject: [PATCH v2] serial: Enable Freescale 16550 workaround on arm
In-Reply-To: <20151002001616.GA3885@home.buserror.net>
References: <20151002001616.GA3885@home.buserror.net>
Message-ID: <1444257081-30491-1-git-send-email-scottwood@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The same serial hardware is present on LS2080A which is arm64, and
LS1021A which is arm32, so don't limit the workaround to PPC.

Unlike PPC which uses arch/powerpc/kernel/legacy_serial.c, the ARM
targets use drivers/tty/serial/of_serial.c, so add the handle_irq
override check there as well.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: Use IS_ENABLED rather than ifdef

 drivers/tty/serial/8250/Kconfig | 4 ++--
 drivers/tty/serial/of_serial.c  | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index 6823df9..fe241bd 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -150,6 +150,11 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		break;
 	}
 
+	if (IS_ENABLED(CONFIG_SERIAL_8250_FSL) &&
+	    (of_device_is_compatible(np, "fsl,ns16550") ||
+	     of_device_is_compatible(np, "fsl,16550-FIFO64")))
+		port->handle_irq = fsl8250_handle_irq;
+
 	return 0;
 out:
 	if (info->clk)
-- 
2.1.4
