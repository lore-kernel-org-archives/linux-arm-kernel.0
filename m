From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:04 +0100
Subject: [PATCH v2 06/23] ARM: Kirkwood: ioremap the cpu_config register
 before using it.
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-7-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the move to mach-mvebu and MULTI_V5, the global iomap for all
registers will be going away. So explicitly map the CPU configuration
register before using it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dt.c                 | 22 +++++++++++++++-------
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 64151a4a378f..91b61a971af2 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -191,15 +191,23 @@ eth_fixup_skip:
 	}
 }
 
+/*
+ * Disable propagation of mbus errors to the CPU local bus, as this
+ * causes mbus errors (which can occur for example for PCI aborts) to
+ * throw CPU aborts, which we're not set up to deal with.
+ */
+void kirkwood_disable_mbus_error_propagation(void)
+{
+	void __iomem *cpu_config;
+
+	cpu_config = ioremap(CPU_CONFIG_PHYS, 4);
+	writel(readl(cpu_config) & ~CPU_CONFIG_ERROR_PROP, cpu_config);
+}
+
+
 static void __init kirkwood_dt_init(void)
 {
-	/*
-	 * Disable propagation of mbus errors to the CPU local bus,
-	 * as this causes mbus errors (which can occur for example
-	 * for PCI aborts) to throw CPU aborts, which we're not set
-	 * up to deal with.
-	 */
-	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
+	kirkwood_disable_mbus_error_propagation();
 
 	BUG_ON(mvebu_mbus_dt_init());
 
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 8b9d1c9ff199..2bd12fde1781 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -14,6 +14,7 @@
 #include <mach/kirkwood.h>
 
 #define CPU_CONFIG		(BRIDGE_VIRT_BASE + 0x0100)
+#define CPU_CONFIG_PHYS		(BRIDGE_PHYS_BASE + 0x0100)
 #define CPU_CONFIG_ERROR_PROP	0x00000004
 
 #define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
-- 
1.8.5.3
