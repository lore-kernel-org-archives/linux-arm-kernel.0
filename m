From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Fri, 27 Nov 2009 09:37:46 +0300
Subject: [PATCH] arm: convert /proc/cpu/aligment to seq_file
Message-ID: <20091127063746.GB25983@x200.malnet.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm/mm/alignment.c |   54 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
@@ -91,36 +92,29 @@ static const char *usermode_action[] = {
 	"signal+warn"
 };
 
-static int
-proc_alignment_read(char *page, char **start, off_t off, int count, int *eof,
-		    void *data)
+static int alignment_proc_show(struct seq_file *m, void *v)
 {
-	char *p = page;
-	int len;
-
-	p += sprintf(p, "User:\t\t%lu\n", ai_user);
-	p += sprintf(p, "System:\t\t%lu\n", ai_sys);
-	p += sprintf(p, "Skipped:\t%lu\n", ai_skipped);
-	p += sprintf(p, "Half:\t\t%lu\n", ai_half);
-	p += sprintf(p, "Word:\t\t%lu\n", ai_word);
+	seq_printf(m, "User:\t\t%lu\n", ai_user);
+	seq_printf(m, "System:\t\t%lu\n", ai_sys);
+	seq_printf(m, "Skipped:\t%lu\n", ai_skipped);
+	seq_printf(m, "Half:\t\t%lu\n", ai_half);
+	seq_printf(m, "Word:\t\t%lu\n", ai_word);
 	if (cpu_architecture() >= CPU_ARCH_ARMv5TE)
-		p += sprintf(p, "DWord:\t\t%lu\n", ai_dword);
-	p += sprintf(p, "Multi:\t\t%lu\n", ai_multi);
-	p += sprintf(p, "User faults:\t%i (%s)\n", ai_usermode,
+		seq_printf(m, "DWord:\t\t%lu\n", ai_dword);
+	seq_printf(m, "Multi:\t\t%lu\n", ai_multi);
+	seq_printf(m, "User faults:\t%i (%s)\n", ai_usermode,
 			usermode_action[ai_usermode]);
 
-	len = (p - page) - off;
-	if (len < 0)
-		len = 0;
-
-	*eof = (len <= count) ? 1 : 0;
-	*start = page + off;
+	return 0;
+}
 
-	return len;
+static int alignment_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, alignment_proc_show, NULL);
 }
 
-static int proc_alignment_write(struct file *file, const char __user *buffer,
-				unsigned long count, void *data)
+static ssize_t alignment_proc_write(struct file *file, const char __user *buffer,
+				    size_t count, loff_t *pos)
 {
 	char mode;
 
@@ -133,6 +127,14 @@ static int proc_alignment_write(struct file *file, const char __user *buffer,
 	return count;
 }
 
+static const struct file_operations alignment_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= alignment_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= alignment_proc_write,
+};
 #endif /* CONFIG_PROC_FS */
 
 union offset_union {
@@ -902,12 +904,10 @@ static int __init alignment_init(void)
 	if (!res)
 		return -ENOMEM;
 
-	res = create_proc_entry("alignment", S_IWUSR | S_IRUGO, res);
+	res = proc_create("alignment", S_IWUSR | S_IRUGO, res,
+			  &alignment_proc_fops);
 	if (!res)
 		return -ENOMEM;
-
-	res->read_proc = proc_alignment_read;
-	res->write_proc = proc_alignment_write;
 #endif
 
 	/*
