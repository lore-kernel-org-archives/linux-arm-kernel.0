From: labbott@redhat.com (Laura Abbott)
Date: Mon,  9 Jul 2018 17:51:27 -0700
Subject: [PATCHv2] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
Message-ID: <20180710005127.22883-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode
variants") unfortunately breaks with some toolchains:

  CHK     include/generated/compile.h
  LD [M]  arch/arm64/crypto/sha512-ce.o
aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
make: *** [Makefile:1029: arch/arm64/crypto] Error 2

If the distribution doesn't package the associated linker strips from
binutils, this will fail. Both Fedora and Debian currently fall into
this category so just revert it.

Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Tweaked the commit text to be a bit clearer about what the
underlying problem is.
---
 arch/arm64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7976d2d242fa..f476d52ad8d6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-LDFLAGS		+= -EB -maarch64elfb
+LDFLAGS		+= -EB -maarch64linuxb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64elf
+LDFLAGS		+= -EL -maarch64linux
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.17.1
