From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 25 Sep 2017 19:11:41 +0100
Subject: [PATCH] ARM: better diagnostics with missing/corrupt dtb
Message-ID: <E1dwXr3-0002DE-1d@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a kernel containing both DT and atag support, the diagnostics
output when the dtb is missing or corrupt assume that we're trying
to boot using atags and the machine ID, and only print the machine
ID.  This is not useful for diagnosing a missing or corrupt dtb.

Move the message into arch/arm/kernel/setup.c, and print the address
of the dtb/atag list, and the first 16 bytes of memory of the dtb or
atag list.

This allows us to see whether the dtb was corrupted in some way,
causing the fallback to the machine ID / atag list.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/atags_parse.c |  7 ++-----
 arch/arm/kernel/setup.c       | 10 ++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 98fbfd235ac8..c10a3e8ee998 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -196,11 +196,8 @@ setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 			break;
 		}
 
-	if (!mdesc) {
-		early_print("\nError: unrecognized/unsupported machine ID"
-			    " (r1 = 0x%08x).\n\n", machine_nr);
-		dump_machine_table(); /* does not return */
-	}
+	if (!mdesc)
+		return NULL;
 
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8e9a3e40d949..fc40a2b40595 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1069,6 +1069,16 @@ void __init setup_arch(char **cmdline_p)
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
+	if (!mdesc) {
+		early_print("\nError: invalid dtb and unrecognized/unsupported machine ID\n");
+		early_print("  r1=0x%08x, r2=0x%08x\n", __machine_arch_type,
+			    __atags_pointer);
+		if (__atags_pointer)
+			early_print("  r2[]=%*ph\n", 16,
+				    phys_to_virt(__atags_pointer));
+		dump_machine_table();
+	}
+
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
 	dump_stack_set_arch_desc("%s", mdesc->name);
-- 
2.7.4
