From: horms@verge.net.au (Simon Horman)
Date: Thu,  9 Dec 2010 08:01:14 +0900
Subject: [PATCH] [rfc] ARM: mach-shmobile: mackerel: Add zboot support
Message-ID: <1291849274-8115-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
boot loader and may be burned to rom or flash.

This patch assumes that head-mackerel.txt will be the same as head-ap4evb.txt.
I am waiting for verification of this.

This patch depends on
* ARM: 6515/1: Add zboot support for SuperH Mobile ARM
  (merged into the devel branch of Russel King's linux-2.6-arm tree)
* ARM: 6514/1: mach-shmobile: Add zboot support for SuperH Mobile ARM
  (merged into the devel branch of Russel King's linux-2.6-arm tree)
* MACH_MACKEREL (3211) being present in arch/arm/tools/mach-types

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../mach-shmobile/include/mach/head-mackerel.txt   |   87 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/zboot.h        |    3 +
 2 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/head-mackerel.txt

diff --git a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
new file mode 100644
index 0000000..e3ebfa7
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
@@ -0,0 +1,87 @@
+LIST "partner-jet-setup.txt"
+LIST "(C) Copyright 2010 Renesas Solutions Corp"
+LIST "Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>"
+
+LIST "RWT Setting"
+EW 0xE6020004, 0xA500
+EW 0xE6030004, 0xA500
+
+DD 0x01001000, 0x01001000
+
+LIST "GPIO Setting"
+EB 0xE6051013, 0xA2
+
+LIST "CPG"
+ED 0xE6150080, 0x00000180
+ED 0xE61500C0, 0x00000002
+
+WAIT 1, 0xFE40009C
+
+LIST "FRQCR"
+ED 0xE6150000, 0x2D1305C3
+ED 0xE61500E0, 0x9E40358E
+ED 0xE6150004, 0x80331050
+
+WAIT 1, 0xFE40009C
+
+ED 0xE61500E4, 0x00002000
+
+WAIT 1, 0xFE40009C
+
+LIST "PLL"
+ED 0xE6150028, 0x00004000
+
+WAIT 1, 0xFE40009C
+
+ED 0xE615002C, 0x93000040
+
+WAIT 1, 0xFE40009C
+
+LIST "BSC"
+ED 0xFEC10000, 0x00E0001B
+
+LIST "SBSC1"
+ED 0xFE400354, 0x01AD8000
+ED 0xFE400354, 0x01AD8001
+
+WAIT 5, 0xFE40009C
+
+ED 0xFE400008, 0xBCC90151
+ED 0xFE400040, 0x41774113
+ED 0xFE400044, 0x2712E229
+ED 0xFE400048, 0x20C18505
+ED 0xFE40004C, 0x00110209
+ED 0xFE400010, 0x00000087
+
+WAIT 10, 0xFE40009C
+
+ED 0xFE400084, 0x0000003F
+EB 0xFE500000, 0x00
+
+WAIT 5, 0xFE40009C
+
+ED 0xFE400084, 0x0000FF0A
+EB 0xFE500000, 0x00
+
+WAIT 1, 0xFE40009C
+
+ED 0xFE400084, 0x00002201
+EB 0xFE500000, 0x00
+ED 0xFE400084, 0x00000302
+EB 0xFE500000, 0x00
+EB 0xFE5C0000, 0x00
+ED 0xFE400008, 0xBCC90159
+ED 0xFE40008C, 0x88800004
+ED 0xFE400094, 0x00000004
+ED 0xFE400028, 0xA55A0032
+ED 0xFE40002C, 0xA55A000C
+ED 0xFE400020, 0xA55A2048
+ED 0xFE400008, 0xBCC90959
+
+LIST "Change CPGA setting"
+ED 0xE61500E0, 0x9E40352E
+ED 0xE6150004, 0x80331050
+
+WAIT 1, 0xFE40009C
+
+ED 0xE6150354, 0x00000002
diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
index 3ad86b7..994b891 100644
--- a/arch/arm/mach-shmobile/include/mach/zboot.h
+++ b/arch/arm/mach-shmobile/include/mach/zboot.h
@@ -13,6 +13,9 @@
 #ifdef CONFIG_MACH_AP4EVB
 #define MACH_TYPE	MACH_TYPE_AP4EVB
 #include "mach/head-ap4evb.txt"
+#elif CONFIG_MACH_MACKEREL
+#define MACH_TYPE	MACH_TYPE_MACKEREL
+#include "mach/head-ap4evb.txt"
 #else
 #error "unsupported board."
 #endif
-- 
1.7.2.3
