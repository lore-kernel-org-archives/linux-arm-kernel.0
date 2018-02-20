From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 22:59:50 +0100
Subject: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
Message-ID: <20180220215954.4092811-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need some way to pass -mbig-endian to the linker during the
LTO link stage, otherwise we get a waning like

arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian

for each file we link in.

There is probably a better method of passing that flag, I'm just
adding it to a different hack that I added earlier for x86 LTO
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 33b7eb4502aa..f39c2e2d55c0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -49,11 +49,13 @@ endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
+KBUILD_BIARCHFLAGS += -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
 LD		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
+KBUILD_BIARCHFLAGS += -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
 LD		+= -EL
-- 
2.9.0
