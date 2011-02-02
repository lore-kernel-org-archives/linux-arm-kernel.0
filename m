From: ecc@cmu.edu (Eric Cooper)
Date: Wed,  2 Feb 2011 17:16:11 -0500
Subject: [PATCH v2 3/3] Kirkwood: enable PCIe for kexec
In-Reply-To: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
References: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
Message-ID: <1296684971-10577-3-git-send-email-ecc@cmu.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the machine-specific kexec_reinit hook to make sure
PCIe is enabled before starting a new kernel.

Signed-off-by: Eric Cooper <ecc@cmu.edu>
---
 arch/arm/mach-kirkwood/common.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 3688123..78eeb63 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -974,6 +974,8 @@ static void __init kirkwood_l2_init(void)
 
 void __init kirkwood_init(void)
 {
+	extern void (*kexec_reinit)(void);
+
 	printk(KERN_INFO "Kirkwood: %s, TCLK=%d.\n",
 		kirkwood_id(), kirkwood_tclk);
 	kirkwood_ge00_shared_data.t_clk = kirkwood_tclk;
@@ -1003,6 +1005,8 @@ void __init kirkwood_init(void)
 	kirkwood_xor0_init();
 	kirkwood_xor1_init();
 	kirkwood_crypto_init();
+
+	kexec_reinit = kirkwood_enable_pcie;
 }
 
 static int __init kirkwood_clock_gate(void)
-- 
1.7.2.3
