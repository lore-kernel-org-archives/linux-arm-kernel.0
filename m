From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Wed, 14 Dec 2016 22:12:43 +0100
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE in
 case DT does not provide /chosen/bootargs
Message-ID: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage") broke
support for setting cmdline on Nokia N900 via CONFIG_CMDLINE.

It is because arm code booted in DT mode parse cmdline only via function
early_init_dt_scan_chosen() and that function does not fill variable
boot_command_line when DTB does not contain /chosen entry. It is called
from function early_init_dt_scan_nodes() in setup_machine_fdt().

This patch fixes it by explicitly filling boot_command_line in function
setup_machine_fdt() after calling early_init_dt_scan_nodes() in case
boot_command_line still remains empty.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/kernel/devtree.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f676feb..dbe25b1 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -260,6 +260,11 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	early_init_dt_scan_nodes();
 
+#ifdef CONFIG_CMDLINE
+	if (!boot_command_line[0])
+		strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
 
-- 
1.7.9.5
