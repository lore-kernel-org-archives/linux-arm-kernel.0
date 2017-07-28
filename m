From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Jul 2017 16:10:49 +0200
Subject: [PATCH] [RFC] ARM: move __bug_table into .data for XIP_KERNEL
Message-ID: <20170728141108.1283320-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Hart reports that vf610m4_defconfig kernels grew to 2GB
xipImage size after the __bug_table change.

I tried out a few things and found that moving the bug table
into the .data section avoids this problem. However, the
linker script magic is beyond my capabilities here, so this
is almost certainly not correct.

I've added a few people to Cc that understand this better
than I do, hopefully someone can turn my bogus patch into
a proper one.

Fixes: b5effd3815cc ("debug: Fix __bug_table[] in arch linker scripts")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Hart <matthew.hart@linaro.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index a8ceec3e0580..1ebb40ecf411 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -241,12 +241,17 @@ SECTIONS
 		DATA_DATA
 		CONSTRUCTORS
 
+#ifdef CONFIG_GENERIC_BUG
+		__bug_table = ALIGN(8);
+		VMLINUX_SYMBOL(__start___bug_table) = .;
+		KEEP(*(__bug_table))
+		VMLINUX_SYMBOL(__stop___bug_table) = .;
+#endif
+
 		_edata = .;
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
-	BUG_TABLE
-
 #ifdef CONFIG_HAVE_TCM
         /*
 	 * We align everything to a page boundary so we can
-- 
2.9.0
