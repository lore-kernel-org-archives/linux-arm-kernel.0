From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Tue, 9 Nov 2010 18:11:12 -0500
Subject: Patch IMX audmux debugfs.
Message-ID: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


$ mount -t debugfs debugfs /sys/kernel/debug
$ cd /sys/kernel/debug/audmux
$ cat *
[crashes when accessing ssi7]

The index is one based, but the register map is zero based.  So the
ssi1 is actually sending info for ssi2.  Also, the ssi7 touches
non-existent data and can cause an exception (only registers sets 1-6
exist).

Alternatively, the MX31_AUDMUX_PORT6_SSI_PINS_6 and
MX27_AUDMUX_PPCR3_SSI_PINS_3 constants could be used for the loop
termination, but maybe that means conditionalization (and there are no
MX25 constants).

diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index f9e7cdb..0547145 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -66,7 +66,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 {
        ssize_t ret;
        char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-       int port = (int)file->private_data;
+       int port = ((int)file->private_data) - 1;
        u32 pdcr, ptcr;
 
        if (!buf)
@@ -150,7 +150,7 @@ static void audmux_debugfs_init(void)
                return;
        }
 
-       for (i = 1; i < 8; i++) {
+       for (i = 1; i < 7; i++) {
                snprintf(buf, sizeof(buf), "ssi%d", i);
                if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
                                         (void *)i, &audmux_debugfs_fops))
