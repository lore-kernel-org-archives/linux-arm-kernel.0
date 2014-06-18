From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Wed, 18 Jun 2014 18:54:24 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
Message-ID: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Machine name from board description is some generic name on DT kernel.
DT provides machine name property which is specific for board, so use
it instead generic one when possible.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/kernel/setup.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a16ee5..fbc7b4f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -875,10 +875,13 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
-	if (!mdesc)
+	if (mdesc)
+		machine_name = of_flat_dt_get_machine_name();
+	else
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
-	machine_name = mdesc->name;
+	if (!machine_name)
+		machine_name = mdesc->name;
 
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;
-- 
1.7.9.5
