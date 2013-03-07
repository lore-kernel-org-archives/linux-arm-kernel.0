From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:09 +0100
Subject: [PATCH 03/11] intoduce dmesg to print the barebox printk to dmesg
 ring buffer
In-Reply-To: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307215402.GA32347@game.jcrosoft.org>
 <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362693497-2964-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the size can be configured vai DMESG_KFIFO_OSIZE

1024 by default
4096 if DEBUG_INFO

the verbosity of the printk can now be change at runtime and default via
PRINTK_LEVEL

rename dev_printf to dev_printk and update to printk

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 commands/Kconfig                |   19 +++++++
 common/console.c                |  107 +++++++++++++++++++++++++++++++++++++++
 drivers/base/driver.c           |   16 +++---
 include/linux/barebox-wrapper.h |   11 ----
 include/linux/kern_levels.h     |   25 +++++++++
 include/printk.h                |   59 ++++++++++++++-------
 6 files changed, 203 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/kern_levels.h

diff --git a/commands/Kconfig b/commands/Kconfig
index c1454c7..7412257 100644
--- a/commands/Kconfig
+++ b/commands/Kconfig
@@ -122,6 +122,25 @@ config CMD_TIME
 	  checking for ctrl-c, so the time command can be used with commands
 	  which are interruptible with ctrl-c.
 
+config CMD_DMESG
+	bool "dmesg"
+	depends on CONSOLE_FULL
+	  help
+	  print the barebox output ring buffer
+
+if CMD_DMESG
+config PRINTK_LEVEL
+	int "printk level"
+	range 0 7
+	default 7
+
+config DMESG_KFIFO_SIZE
+	prompt "kfifo dmesg size"
+	int
+	default 4096 if DEBUG_INFO
+	default 1024
+endif
+
 config CMD_LINUX_EXEC
 	bool "linux exec"
 	depends on LINUX
diff --git a/common/console.c b/common/console.c
index 243d402..c707c9d 100644
--- a/common/console.c
+++ b/common/console.c
@@ -349,3 +349,110 @@ int ctrlc (void)
 }
 EXPORT_SYMBOL(ctrlc);
 #endif /* ARCH_HAS_CTRC */
+
+#ifdef CONFIG_CMD_DMESG
+#include <command.h>
+#include <complete.h>
+#include <init.h>
+#include <globalvar.h>
+
+static char dmesg_output_buffer[CONFIG_DMESG_KFIFO_SIZE];
+static struct kfifo __dmesg_output_fifo;
+static struct kfifo *dmesg_output_fifo = &__dmesg_output_fifo;
+static int printk_level = CONFIG_PRINTK_LEVEL;
+static char printk_level_str[2] = __stringify(CONFIG_PRINTK_LEVEL);
+
+static int printk_level_set(struct device_d *dev, struct param_d *p, const char *val)
+{
+	unsigned long level = simple_strtoul(val, NULL, 10);
+
+	if (level > 7)
+		return -EINVAL;
+
+	printk_level = level;
+	printk_level_str[0] = level + '0';
+
+	return 0;
+}
+
+const char *printk_level_get(struct device_d *d, struct param_d *p)
+{
+	return printk_level_str;
+}
+
+static int printk_init(void)
+{
+	return globalvar_add("printk_level", printk_level_set, printk_level_get, 0);
+}
+coredevice_initcall(printk_init);
+
+static int printk_fifo_init(void)
+{
+	kfifo_init(dmesg_output_fifo, dmesg_output_buffer,
+			CONFIG_DMESG_KFIFO_SIZE);
+
+	return 0;
+}
+pure_initcall(printk_fifo_init);
+
+static int do_dmesg(int argc, char *argv[])
+{
+	kfifo_dump_str(dmesg_output_fifo, console_output_dump);
+
+	return 0;
+}
+
+static const __maybe_unused char cmd_dmesg_help[] =
+"print the barebox output ring buffer\n";
+
+BAREBOX_CMD_START(dmesg)
+	.cmd		= do_dmesg,
+	.usage		= "dmesg",
+	BAREBOX_CMD_HELP(cmd_dmesg_help)
+	BAREBOX_CMD_COMPLETE(empty_complete)
+BAREBOX_CMD_END
+
+int vprintk(const char *fmt, va_list args)
+{
+	uint i, fi;
+	char printbuffer[CFG_PBSIZE];
+	char *s = printbuffer;
+	int level;
+
+	/* For this to work, printbuffer must be larger than
+	 * anything we ever want to print.
+	 */
+	fi = i = vsprintf(printbuffer, fmt, args);
+
+	level = printk_get_level(printbuffer);
+	if (level) {
+		s += 2;
+		fi -= 2;
+		kfifo_putc(dmesg_output_fifo, '<');
+		kfifo_putc(dmesg_output_fifo, level);
+		kfifo_putc(dmesg_output_fifo, '>');
+	}
+
+	/* Print the string */
+	if (level <= printk_level + '0')
+		puts(s);
+
+	kfifo_put(dmesg_output_fifo, s, fi);
+
+	return i;
+}
+EXPORT_SYMBOL(vprintk);
+
+int printk(const char *fmt, ...)
+{
+	va_list args;
+	uint i;
+
+	va_start (args, fmt);
+	i = vprintk(fmt, args);
+	va_end (args);
+
+	return i;
+}
+EXPORT_SYMBOL(printk);
+#endif
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index fa30c68..04b9451 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -364,23 +364,27 @@ const char *dev_id(const struct device_d *dev)
 	return buf;
 }
 
-int dev_printf(const struct device_d *dev, const char *format, ...)
+int dev_printk(const struct device_d *dev, int level, const char *format, ...)
 {
 	va_list args;
-	int ret = 0;
+	char printbuffer[CFG_PBSIZE];
+	char *s = printbuffer;
 
 	if (dev->driver && dev->driver->name)
-		ret += printf("%s ", dev->driver->name);
+		s += sprintf(s, "%s ", dev->driver->name);
 
-	ret += printf("%s: ", dev_name(dev));
+	s += sprintf(s, "%s: ", dev_name(dev));
 
 	va_start(args, format);
 
-	ret += vprintf(format, args);
+	vsprintf(s, format, args);
 
 	va_end(args);
 
-	return ret;
+	if (IS_ENABLED(CONFIG_CMD_DMESG))
+		return printk(KERN_SOH "%d%s", level, printbuffer);
+	else
+		return printk("%s", printbuffer);
 }
 
 void devices_shutdown(void)
diff --git a/include/linux/barebox-wrapper.h b/include/linux/barebox-wrapper.h
index 1d1f846..ce68060 100644
--- a/include/linux/barebox-wrapper.h
+++ b/include/linux/barebox-wrapper.h
@@ -9,17 +9,6 @@
 #define kfree(ptr)		free(ptr)
 #define vfree(ptr)		free(ptr)
 
-#define KERN_EMERG      ""   /* system is unusable                   */
-#define KERN_ALERT      ""   /* action must be taken immediately     */
-#define KERN_CRIT       ""   /* critical conditions                  */
-#define KERN_ERR        ""   /* error conditions                     */
-#define KERN_WARNING    ""   /* warning conditions                   */
-#define KERN_NOTICE     ""   /* normal but significant condition     */
-#define KERN_INFO       ""   /* informational                        */
-#define KERN_DEBUG      ""   /* debug-level messages                 */
-
-#define printk			printf
-
 #define pr_warn			pr_warning
 
 #define __init
diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
new file mode 100644
index 0000000..866caaa
--- /dev/null
+++ b/include/linux/kern_levels.h
@@ -0,0 +1,25 @@
+#ifndef __KERN_LEVELS_H__
+#define __KERN_LEVELS_H__
+
+#define KERN_SOH	"\001"		/* ASCII Start Of Header */
+#define KERN_SOH_ASCII	'\001'
+
+#define KERN_EMERG	KERN_SOH "0"	/* system is unusable */
+#define KERN_ALERT	KERN_SOH "1"	/* action must be taken immediately */
+#define KERN_CRIT	KERN_SOH "2"	/* critical conditions */
+#define KERN_ERR	KERN_SOH "3"	/* error conditions */
+#define KERN_WARNING	KERN_SOH "4"	/* warning conditions */
+#define KERN_NOTICE	KERN_SOH "5"	/* normal but significant condition */
+#define KERN_INFO	KERN_SOH "6"	/* informational */
+#define KERN_DEBUG	KERN_SOH "7"	/* debug-level messages */
+
+#define KERN_DEFAULT	KERN_SOH "d"	/* the default kernel loglevel */
+
+/*
+ * Annotation for a "continued" line of log printout (only done after a
+ * line that had no enclosing \n). Only to be used by core/arch code
+ * during early bootup (a continued line is not SMP-safe otherwise).
+ */
+#define KERN_CONT	""
+
+#endif
diff --git a/include/printk.h b/include/printk.h
index 3cd7335..fb0dba0 100644
--- a/include/printk.h
+++ b/include/printk.h
@@ -1,6 +1,8 @@
 #ifndef __PRINTK_H
 #define __PRINTK_H
 
+#include <linux/kern_levels.h>
+
 #define MSG_EMERG      0    /* system is unusable */
 #define MSG_ALERT      1    /* action must be taken immediately */
 #define MSG_CRIT       2    /* critical conditions */
@@ -16,38 +18,61 @@
 #define LOGLEVEL	CONFIG_COMPILE_LOGLEVEL
 #endif
 
+#ifdef CONFIG_CMD_DMESG
+int	printk(const char *fmt, ...) __attribute__ ((format(__printf__, 1, 2)));
+int	vprintk(const char *fmt, va_list args);
+#define __pr_printk(level, format, args...) \
+	({	\
+		(level) <= LOGLEVEL ? printk(KERN_SOH "%d" format, level, ##args) : 0; \
+	 })
+#else
+#define printk			printf
+#define vprintk			vprintf
+#define __pr_printk(level, format, args...) \
+	({	\
+		(level) <= LOGLEVEL ? printk(format, ##args) : 0; \
+	 })
+#endif
+
+static inline int printk_get_level(const char *buffer)
+{
+	if (buffer[0] == KERN_SOH_ASCII && buffer[1]) {
+		switch (buffer[1]) {
+		case '0' ... '7':
+		case 'd':	/* KERN_DEFAULT */
+			return buffer[1];
+		}
+	}
+	return 0;
+}
+
 /* debugging and troubleshooting/diagnostic helpers. */
 
-int dev_printf(const struct device_d *dev, const char *format, ...)
-	__attribute__ ((format(__printf__, 2, 3)));
+int dev_printk(const struct device_d *dev, int level, const char *format, ...)
+	__attribute__ ((format(__printf__, 3, 4)));
 
-#define __dev_printf(level, dev, format, args...) \
+#define __dev_printk(level, dev, format, args...) \
 	({	\
-		(level) <= LOGLEVEL ? dev_printf((dev), (format), ##args) : 0; \
+		(level) <= LOGLEVEL ? dev_printk((dev), level, format, ##args) : 0; \
 	 })
 
 
 #define dev_emerg(dev, format, arg...)		\
-	__dev_printf(0, (dev) , format , ## arg)
+	__dev_printk(0, (dev) , format , ## arg)
 #define dev_alert(dev, format, arg...)		\
-	__dev_printf(1, (dev) , format , ## arg)
+	__dev_printk(1, (dev) , format , ## arg)
 #define dev_crit(dev, format, arg...)		\
-	__dev_printf(2, (dev) , format , ## arg)
+	__dev_printk(2, (dev) , format , ## arg)
 #define dev_err(dev, format, arg...)		\
-	__dev_printf(3, (dev) , format , ## arg)
+	__dev_printk(3, (dev) , format , ## arg)
 #define dev_warn(dev, format, arg...)		\
-	__dev_printf(4, (dev) , format , ## arg)
+	__dev_printk(4, (dev) , format , ## arg)
 #define dev_notice(dev, format, arg...)		\
-	__dev_printf(5, (dev) , format , ## arg)
+	__dev_printk(5, (dev) , format , ## arg)
 #define dev_info(dev, format, arg...)		\
-	__dev_printf(6, (dev) , format , ## arg)
+	__dev_printk(6, (dev) , format , ## arg)
 #define dev_dbg(dev, format, arg...)		\
-	__dev_printf(7, (dev) , format , ## arg)
-
-#define __pr_printk(level, format, args...) \
-	({	\
-		(level) <= LOGLEVEL ? printk((format), ##args) : 0; \
-	 })
+	__dev_printk(7, (dev) , format , ## arg)
 
 #ifndef pr_fmt
 #define pr_fmt(fmt) fmt
-- 
1.7.10.4
