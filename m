From: vesa.jaaskelainen@vaisala.com (=?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?=)
Date: Sun, 16 Jul 2017 23:00:56 +0300
Subject: [RFC PATCH 2/2] arm: setup: Show the board revision from devicetree
 in cpuinfo
In-Reply-To: <1500235256-48937-1-git-send-email-vesa.jaaskelainen@vaisala.com>
References: <1500235256-48937-1-git-send-email-vesa.jaaskelainen@vaisala.com>
Message-ID: <1500235256-48937-3-git-send-email-vesa.jaaskelainen@vaisala.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get board revision information from devicetree's /board-revision property.

When using devicetree's board-revision property board revision will be
free form string as defined by device/SoM manufacturer.

In case it is not available fallback to using ATAGs and format it as 4
digit hex string as previously.

Signed-off-by: Vesa J??skel?inen <vesa.jaaskelainen@vaisala.com>
---
 arch/arm/kernel/setup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4e80bf7..325604e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -97,6 +97,8 @@ unsigned int __atags_pointer __initdata;
 unsigned int system_rev;
 EXPORT_SYMBOL(system_rev);
 
+static const char *board_revision;
+
 const char *system_serial;
 EXPORT_SYMBOL(system_serial);
 
@@ -940,6 +942,11 @@ static int __init init_machine_late(void)
 					      &system_serial);
 		if (ret)
 			system_serial = NULL;
+
+		ret = of_property_read_string(root, "board-revision",
+					      &board_revision);
+		if (ret)
+			board_revision = NULL;
 	}
 
 	if (!system_serial)
@@ -947,6 +954,9 @@ static int __init init_machine_late(void)
 					  system_serial_high,
 					  system_serial_low);
 
+	if (!board_revision)
+		board_revision = kasprintf(GFP_KERNEL, "%04x", system_rev);
+
 	return 0;
 }
 late_initcall(init_machine_late);
@@ -1271,7 +1281,7 @@ static int c_show(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m, "Hardware\t: %s\n", machine_name);
-	seq_printf(m, "Revision\t: %04x\n", system_rev);
+	seq_printf(m, "Revision\t: %s\n", board_revision);
 	seq_printf(m, "Serial\t\t: %s\n", system_serial);
 
 	return 0;
-- 
2.1.4
