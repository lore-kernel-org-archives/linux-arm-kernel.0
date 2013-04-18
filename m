From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 18 Apr 2013 16:23:39 +0200
Subject: [PATCH RFC] ARM: don't allow to register the early_console twice
In-Reply-To: <1366295019-30335-1-git-send-email-gregory.clement@free-electrons.com>
References: <1366295019-30335-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1366295019-30335-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If on the kernel command line the parameter "earlyprintk" is written
twice, then setup_early_printk is called twice. This can happen for
example with the option CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is
selected, and the "earlyprintk" is passed from the ATAG_CMDLINE and
from the dtb.

This lead to an infinite loop on the message "Booting Linux on
physical CPU 0" displayed from smp_setup_processor_id() in
arch/arm/kernel/setup.c. This behavior as been reproduced on ARMv7
architecture (Armada XP and Armada 370), and on a ARMv5 one
(AT91SAMG35 thanks to Richard Genoud), with and with CONFIG_SMP
selected.

This patch simply doesn't allow to call twice register_console() with
the early_console.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/kernel/early_printk.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 85aa2b2..435577a 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -50,7 +50,11 @@ asmlinkage void early_printk(const char *fmt, ...)
 
 static int __init setup_early_printk(char *buf)
 {
-	register_console(&early_console);
+	static int done;
+	if (!done) {
+		register_console(&early_console);
+		done = 1;
+	}
 	return 0;
 }
 
-- 
1.7.9.5
