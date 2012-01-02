From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  2 Jan 2012 18:11:53 -0200
Subject: [PATCH] ARM: setup.c: Change the order of include files to avoid
 build warning
Message-ID: <1325535113-26551-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warning:

  CC      arch/arm/kernel/setup.o
In file included from arch/arm/kernel/setup.c:39:
arch/arm/include/asm/elf.h:102:1: warning: "vmcore_elf64_check_arch" redefined
In file included from arch/arm/kernel/setup.c:24:
include/linux/crash_dump.h:30:1: warning: this is the location of the previous definition

If <asm/elf.h> is defined prior to <linux/crash_dump.h> the warning does not happen because 
vmcore_elf64_check_arch is defined at <asm/elf.h>, so change the order of the includes to avoid the warning.

This warning was introduced by commit cea0bb1b (ARM: 6122/1: kdump: add support for elfcorehdr parameter).

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/kernel/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 129fbd5..749e0b2 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
-#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -55,6 +54,8 @@
 #include <asm/unwind.h>
 #include <asm/memblock.h>
 
+#include <linux/crash_dump.h>
+
 #if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 #include "compat.h"
 #endif
-- 
1.7.1
