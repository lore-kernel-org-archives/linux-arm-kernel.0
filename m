From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:07 +0000
Subject: [RFC PATCH v2 37/41] arm64/sve: Enable default vector length control
 via procfs
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-38-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the default SVE vector length at exec() for user tasks
controllable via procfs, in /proc/cpu/sve_default_vector_length.

Limited effort is made to return sensible errors when writing the
procfs file, and anyway the value gets silently clamped to the
maximum VL supported by the platform: users should close and reopen
the file and read back to see the result.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 162 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 982b1d7..ddb651a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -22,8 +22,12 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/prctl.h>
+#include <linux/proc_fs.h>
 #include <linux/sched/signal.h>
+#include <linux/seq_file.h>
 #include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/hardirq.h>
 
 #include <asm/fpsimd.h>
@@ -100,6 +104,8 @@ static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
 
 /* Maximum supported vector length across all CPUs (initially poisoned) */
 int sve_max_vl = -1;
+/* Default VL for tasks that don't set it explicitly: */
+int sve_default_vl = -1;
 
 void *__sve_state(struct task_struct *task)
 {
@@ -334,13 +340,154 @@ int sve_get_task_vl(struct task_struct *task)
 	return sve_prctl_status(task);
 }
 
+#ifdef CONFIG_PROC_FS
+
+struct default_vl_write_state {
+	bool invalid;
+	size_t len;
+	char buf[40];	/* enough for "0x" + 64-bit hex integer + NUL */
+};
+
+static int sve_default_vl_show(struct seq_file *s, void *data)
+{
+	seq_printf(s, "%d\n", sve_default_vl);
+	return 0;
+}
+
+static ssize_t sve_default_vl_write(struct file *f, const char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	struct default_vl_write_state *state =
+		((struct seq_file *)f->private_data)->private;
+	long ret;
+
+	if (!size)
+		return 0;
+
+	if (*pos > sizeof(state->buf) ||
+	    size >= sizeof(state->buf) - *pos) {
+		ret = -ENOSPC;
+		goto error;
+	}
+
+	ret = copy_from_user(state->buf + *pos, buf, size);
+	if (ret > 0)
+		ret = -EINVAL;
+	if (ret)
+		goto error;
+
+	*pos += size;
+	if (*pos > state->len)
+		state->len = *pos;
+
+	return size;
+
+error:
+	state->invalid = true;
+	return ret;
+}
+
+static int sve_default_vl_release(struct inode *i, struct file *f)
+{
+	int ret = 0;
+	int t;
+	unsigned long value;
+	struct default_vl_write_state *state =
+		((struct seq_file *)f->private_data)->private;
+
+	if (!(f->f_mode & FMODE_WRITE))
+		goto out;
+
+	if (state->invalid)
+		goto out;
+
+	if (state->len >= sizeof(state->buf)) {
+		WARN_ON(1);
+		state->len = sizeof(state->buf) - 1;
+	}
+
+	state->buf[state->len] = '\0';
+	t = kstrtoul(state->buf, 0, &value);
+	if (t)
+		ret = t;
+
+	if (!sve_vl_valid(value))
+		ret = -EINVAL;
+
+	if (!sve_vl_valid(sve_max_vl)) {
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+	if (value > sve_max_vl)
+		value = sve_max_vl;
+
+	if (!ret)
+		sve_default_vl = value;
+
+out:
+	t = seq_release_private(i, f);
+	return ret ? ret : t;
+}
+
+static int sve_default_vl_open(struct inode *i, struct file *f)
+{
+	struct default_vl_write_state *data = NULL;
+	int ret;
+
+	if (f->f_mode & FMODE_WRITE) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		data->invalid = false;
+		data->len = 0;
+	}
+
+	ret = single_open(f, sve_default_vl_show, data);
+	if (ret)
+		kfree(data);
+
+	return ret;
+}
+
+static const struct file_operations sve_default_vl_fops = {
+	.open		= sve_default_vl_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= sve_default_vl_release,
+	.write		= sve_default_vl_write,
+};
+
+static int __init sve_procfs_init(void)
+{
+	struct proc_dir_entry *dir;
+
+	/* This should be moved elsewhere is anything else ever uses it: */
+	dir = proc_mkdir("cpu", NULL);
+	if (!dir)
+		return -ENOMEM;
+
+	if (!proc_create("sve_default_vector_length",
+			 S_IRUGO | S_IWUSR, dir, &sve_default_vl_fops))
+		return -ENOMEM;
+
+	return 0;
+}
+
+#else /* ! CONFIG_PROC_FS && CONFIG_ARM64_SVE */
+static int __init sve_procfs_init(void) { return 0; }
+#endif /* ! CONFIG_PROC_FS && CONFIG_ARM64_SVE */
+
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
 extern int sve_max_vl;
+extern int sve_default_vl;
 extern void clear_sve_regs(struct task_struct *task);
 extern void *sve_pffr(struct task_struct *task);
 extern void fpsimd_to_sve(struct task_struct *task);
+extern int __init sve_procfs_init(void);
 
 /* Functions that map to no-ops without SVE: */
 static void sve_to_fpsimd(struct task_struct *task __always_unused) { }
@@ -489,13 +636,13 @@ void fpsimd_flush_thread(void)
 		clear_sve_regs(current);
 
 		current->thread.sve_vl = current->thread.sve_vl_onexec ?
-			current->thread.sve_vl_onexec : sve_max_vl;
+			current->thread.sve_vl_onexec : sve_default_vl;
 
 		/*
 		 * User tasks must have a valid vector length set, but tasks
 		 * forked early (e.g., init) may not initially have one.
 		 * By now, we will know what the hardware supports, so
-		 * sve_max_vl should be valid, and thus the above
+		 * sve_default_vl should be valid, and thus the above
 		 * assignment should ensure a valid VL for the task.
 		 * If not, something went badly wrong.
 		 */
@@ -717,6 +864,14 @@ void __init fpsimd_init_task_struct_size(void)
 	     & 0xf) == 1) {
 		/* FIXME: This should be the minimum across all CPUs */
 		sve_max_vl = sve_get_vl();
+		sve_default_vl = sve_max_vl;
+
+		/*
+		 * To avoid enlarging the signal frame by default, clamp to
+		 * 512 bits until/unless overridden by userspace:
+		 */
+		if (sve_default_vl > 512 / 8)
+			sve_default_vl = 512 / 8;
 
 		BUG_ON(!sve_vl_valid(sve_max_vl));
 		vq = sve_vq_from_vl(sve_max_vl);
@@ -746,6 +901,9 @@ static int __init fpsimd_init(void)
 	if (!(elf_hwcap & HWCAP_SVE))
 		pr_info("Scalable Vector Extension available\n");
 
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
+		return sve_procfs_init();
+
 	return 0;
 }
 late_initcall(fpsimd_init);
-- 
2.1.4
