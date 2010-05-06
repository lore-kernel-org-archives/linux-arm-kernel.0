From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:22 -0700
Subject: [PATCH 31/34] Davinci: serial - use ioremap()
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-32-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch implements davinci serial cleanups towards having this code
reusable on tnetv107x.

The change reuses the platform data membase field to hold the remapped space.
By disabling the UPF_IOREMAP flag in the platform data, we prevent
the 8250 driver from repeating the ioremap.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/serial.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 709e1a9..81af42c 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -35,14 +35,20 @@ static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
 					   int offset)
 {
 	offset <<= up->regshift;
-	return (unsigned int)__raw_readl(IO_ADDRESS(up->mapbase) + offset);
+
+	WARN_ONCE(!up->membase, "unmapped read: uart[%d]\n", offset);
+
+	return (unsigned int)__raw_readl(up->membase + offset);
 }
 
 static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
 				    int value)
 {
 	offset <<= p->regshift;
-	__raw_writel(value, IO_ADDRESS(p->mapbase) + offset);
+
+	WARN_ONCE(!p->membase, "unmapped write: uart[%d]\n", offset);
+
+	__raw_writel(value, p->membase + offset);
 }
 
 static void __init davinci_serial_reset(struct plat_serial8250_port *p)
@@ -83,14 +89,26 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
 
 		sprintf(name, "uart%d", i);
 		uart_clk = clk_get(dev, name);
-		if (IS_ERR(uart_clk))
+		if (IS_ERR(uart_clk)) {
 			printk(KERN_ERR "%s:%d: failed to get UART%d clock\n",
 					__func__, __LINE__, i);
-		else {
-			clk_enable(uart_clk);
-			p->uartclk = clk_get_rate(uart_clk);
-			davinci_serial_reset(p);
+			continue;
 		}
+
+		clk_enable(uart_clk);
+		p->uartclk = clk_get_rate(uart_clk);
+
+		if (!p->membase && p->mapbase) {
+			p->membase = ioremap(p->mapbase, SZ_4K);
+
+			if (p->membase)
+				p->flags &= ~UPF_IOREMAP;
+			else
+				pr_err("uart regs ioremap failed\n");
+		}
+
+		if (p->membase)
+			davinci_serial_reset(p);
 	}
 
 	return platform_device_register(soc_info->serial_dev);
-- 
1.7.0.2
