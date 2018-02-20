From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 22:59:52 +0100
Subject: [PATCH 5/7] ARM: fix __inflate_kernel_data stack warning for LTO
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
Message-ID: <20180220215954.4092811-6-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ca8b5d97d6bf ("ARM: XIP kernel: store .data compressed in ROM")
moved the decompressor workspace to the stack and added a compiler
flag to avoid the stack size warning.

With LTO, that warning comes back. Moving the workspace into an initdata
variable avoids that warning but presumably also undoes the optimization.

We could also try disabling the warning locally in that file with
_Pragma("GCC disagnostic"), but we lack a little bit of infrastructure
to do that nicely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/Makefile            | 3 ---
 arch/arm/kernel/head-inflate-data.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index b59ac4bf82b8..2e8d40d442a2 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -88,9 +88,6 @@ head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
-# This is executed very early using a temporary stack when no memory allocator
-# nor global data is available. Everything has to be allocated on the stack.
-CFLAGS_head-inflate-data.o := $(call cc-option,-Wframe-larger-than=10240)
 obj-$(CONFIG_XIP_DEFLATED_DATA) += head-inflate-data.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
diff --git a/arch/arm/kernel/head-inflate-data.c b/arch/arm/kernel/head-inflate-data.c
index 6dd0ce5e6058..b208c4541bd1 100644
--- a/arch/arm/kernel/head-inflate-data.c
+++ b/arch/arm/kernel/head-inflate-data.c
@@ -35,10 +35,11 @@ extern char _sdata[];
  * stack then there is no need to clean up before returning.
  */
 
+static __initdata struct inflate_state state;
+
 int __init __inflate_kernel_data(void)
 {
 	struct z_stream_s stream, *strm = &stream;
-	struct inflate_state state;
 	char *in = __data_loc;
 	int rc;
 
-- 
2.9.0
