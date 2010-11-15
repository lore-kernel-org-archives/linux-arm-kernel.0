From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Mon, 15 Nov 2010 10:24:42 -0500
Subject: [Patch v3] Fix audmuxv2 debugfs indexing.
In-Reply-To: <87zktavd2f.fsf_-_@sympatico.ca> (Bill Pringlemeir's message of
	"Mon, 15 Nov 2010 10:09:12 -0500")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk> <87oc9rk6fe.fsf@sympatico.ca>
	<87zktavd2f.fsf_-_@sympatico.ca>
Message-ID: <BLU0-SMTP89E97E6B26509C27743756B8360@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 Nov 2010, bpringle at sympatico.ca wrote:
> Following is the simple patch which corrects improper file indexing of
> audmux port numbers.  Ie, ssi6, ssi7.  It also adds the ssi0 file.
> The directory looks like this,

> root at uclibc /sys/kernel/debug/audmux$ ls
> ssi0  ssi1  ssi2  ssi3  ssi4  ssi5

The attached incremental patch changes the audmux v2 file naming to
correspond to the names used within the file.

   root at uclibc /sys/kernel/debug/audmux$ ls
   SSI3       SSI4       SSI5       SSI6       imx-ssi.0  imx-ssi.1

   root at uclibc /sys/kernel/debug/audmux$ cat imx-ssi.1 
   PDCR: 00008000
   PTCR: a5000800
   TxFS output from SSI5, TxClk output from SSI5
   Port is symmetric
   Data received from SSI5

The file 'imx-ssi.1' was 'ssi1'.  Here, the imx-ssi.1 driver is
connected to audmux pin set 5.  Perhaps 'audmux[3-5]' are better names
than SSI[3-5], if we are updating the naming scheme.  I think the
upper case names shout hardware loud enough.

Signed-off-by: Bill Pringlemeir <bpringle@sympatico.ca>
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 2a1021f..8157704 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -142,7 +142,6 @@ static const struct file_operations audmux_debugfs_fops = {
 static void audmux_debugfs_init(void)
 {
        int i;
-       char buf[20];
 
        audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
        if (!audmux_debugfs_root) {
@@ -151,8 +150,8 @@ static void audmux_debugfs_init(void)
        }
 
        for (i = 0; i < 6; i++) {
-               snprintf(buf, sizeof(buf), "ssi%d", i);
-               if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
+               if (!debugfs_create_file(audmux_port_string(i), 0444,
+                                        audmux_debugfs_root,
                                         (void *)i, &audmux_debugfs_fops))
                        pr_warning("Failed to create AUDMUX port %d debugfs file\n",
                                   i);
