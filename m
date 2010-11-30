From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Tue, 30 Nov 2010 16:07:35 -0500
Subject: [Patch v3] Fix audmuxv2 debugfs indexing.
In-Reply-To: <87r5ehuxh5.fsf@sympatico.ca> (Bill Pringlemeir's message of
	"Fri, 19 Nov 2010 10:47:18 -0500")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk> <87oc9rk6fe.fsf@sympatico.ca>
	<BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
	<20101115153058.GG12986@rakim.wolfsonmicro.main>
	<87oc9qeg75.fsf@sympatico.ca>
	<BLU0-SMTP55EFC1F097F339783A2A30B8360@phx.gbl>
	<20101115162636.GH12986@rakim.wolfsonmicro.main>
	<8762vy4fki.fsf@sympatico.ca> <87r5ehuxh5.fsf@sympatico.ca>
Message-ID: <BLU0-SMTP186080C581D16B63C1B06DB8250@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 Nov 2010, bpringle at sympatico.ca wrote:

> I will re-submit those patches later.

Here is the audmux debug directory after this patch,

   root at freescale /sys/kernel/debug/audmux$ ls
   SSI3       SSI4       SSI5       SSI6       SSI7       imx-ssi.0  imx-ssi.1
   root at freescale /sys/kernel/debug/audmux$ cat SSI7
   PDCR: 0000c000
   PTCR: 00000800
   TxFS input, TxClk input
   Port is symmetric
   Data received from SSI7

The ugly part is 'case 6:'.  However, there currently is no constants
defined in audmux.h for this port.  Also,
mxc_audmux_v2_configure_port() isn't protecting against ports out of
range and there are no constants for the IMX25.  I would need answers
to what should be done to invent a define for 'port 6 (SSI7)'.  Using
MX31 constants seems incomplete as this code could be active for an
MX35 and MX25 as well.

Signed-off-by: Bill Pringlemeir <bpringle@sympatico.ca>
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index f9e7cdb..205de57 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -56,6 +56,8 @@ static const char *audmux_port_string(int port)
                return "SSI5";
        case MX31_AUDMUX_PORT6_SSI_PINS_6:
                return "SSI6";
+       case 6: /* internal or pins AUDMUX_PORT7 */
+               return "SSI7";
        default:
                return "UNKNOWN";
        }
@@ -142,7 +144,6 @@ static const struct file_operations audmux_debugfs_fops = {
 static void audmux_debugfs_init(void)
 {
        int i;
-       char buf[20];
 
        audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
        if (!audmux_debugfs_root) {
@@ -150,9 +151,9 @@ static void audmux_debugfs_init(void)
                return;
        }
 
-       for (i = 1; i < 8; i++) {
-               snprintf(buf, sizeof(buf), "ssi%d", i);
-               if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
+       for (i = 0; i < 7; i++) {
+               if (!debugfs_create_file(audmux_port_string(i), 0444,
+                                        audmux_debugfs_root,
                                         (void *)i, &audmux_debugfs_fops))
                        pr_warning("Failed to create AUDMUX port %d debugfs file\n",
                                   i);
