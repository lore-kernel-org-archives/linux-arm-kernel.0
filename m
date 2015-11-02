From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:31 +0300
Subject: [PATCH v6 02/17] arm64: ensure the kernel is compiled for LP64
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-3-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

The kernel needs to be compiled as a LP64 binary for ARM64, even when
using a compiler that defaults to code-generation for the ILP32 ABI.
Consequently, we need to explicitly pass '-mabi=lp64' (supported on
gcc-4.9 and newer).

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d10b5d4..432b69a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,14 +29,19 @@ endif
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
 KBUILD_AFLAGS	+= $(lseinstr)
 
+KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
+KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
 LD		+= -EB
+LDFLAGS		+= -maarch64linuxb
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+LDFLAGS		+= -maarch64linux
 endif
 
 CHECKFLAGS	+= -D__aarch64__
-- 
2.1.4
