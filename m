From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:49 +0200
Subject: [PATCH v2 07/11] ARM: hide mach-*/ include for ARM_SINGLE_ARMV7M
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-8-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine specific header files are exported for traditional
platforms, but not for the ones that use ARCH_MULTIPLATFORM, as
they could conflict with one another.

In case of ARM_SINGLE_ARMV7M, we end up also exporting them,
but that appears to be a mistake, and we should treat it the
same way as ARCH_MULTIPLATFORM here.

'make W=1' warns about this because it passes -Wmissing-includes
to gcc and the directories are not actually present.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 510620186ee8..3982c7e2fe55 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -266,12 +266,14 @@ machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(sort $(plat-y)))
 
 ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
+ifneq ($(CONFIG_ARM_SINGLE_ARMV7M),y)
 ifeq ($(KBUILD_SRC),)
 KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
 else
 KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
 endif
 endif
+endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-- 
2.9.0
