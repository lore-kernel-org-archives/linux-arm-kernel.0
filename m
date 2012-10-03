From: pratyush.anand@st.com (Pratyush Anand)
Date: Wed, 3 Oct 2012 09:13:39 +0530
Subject: [PATCH] ARM: MMUless Core: Fix insmod error - module relocation out
 of range
Message-ID: <4995c6bc655337598b88bef025cd48b320c2ada0.1349235619.git.pratyush.anand@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neha MAKHIJA <neha.makhija-ext@st.com>

ARM supports 32Mb jump. Hence branch instruction has a limited range.

For MMU systems, the module area is located just before the kernel memory
because this allows function calls to be linked directly without any indirect
branches.

In case of MMU-less system, Module area is given whole of the DDR address
space.  Since, module_alloc() calls vmalloc(), the module area goes outside the
allowed jump range. Due to this insmod will not be able to load the modules
giving out of range relocation errors.

Solution - Add the mlong-calls flags while compiling the modules. This tells
the compiler to perform function calls by first loading the address of the
function and then performing a subroutine function call on this register.

Signed-off-by: Neha Makhija <neha.makhija-ext@st.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 88eec8f..78b5c12 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -112,6 +112,10 @@ CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 endif
 
+ifeq ($(CONFIG_MMU),)
+CFLAGS_MODULE  +=-mlong-calls
+endif
+
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_THUMB2) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_THUMB2) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
-- 
1.7.5.4
