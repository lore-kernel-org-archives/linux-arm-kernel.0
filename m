From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 11 Jul 2018 20:32:39 +0200
Subject: [PATCH] ARM: early_printk: respect keep parameter
Message-ID: <20180711183239.21023-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse and use the keep parameter of earlyprintk to avoid having the kernel
output stop with:

Console: colour dummy device 80x30
console [tty0] enabled
bootconsole [earlycon0] disabled

This happens because once tty0, the virtual terminal console is registered,
it is selected as the default console, disregarding an existing stdout-path
DT property and the early console is shutdown before the console driver is
probed.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/kernel/early_printk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 9257736ec9fa..bbb10150b11a 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -42,6 +42,9 @@ static struct console early_console_dev = {
 
 static int __init setup_early_printk(char *buf)
 {
+	if (buf && strstr(buf, "keep"))
+		early_console_dev.flags &= ~CON_BOOT;
+
 	early_console = &early_console_dev;
 	register_console(&early_console_dev);
 	return 0;
-- 
2.18.0
