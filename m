From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:53 -0700
Subject: [PATCH 08/15] arm64: don't pass -maarch64linux to GNU gold
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-10-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change fixes the following error message when linking with GNU
gold:

  ld.gold: error: unrecognized emulation aarch64linux

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index eb6f3c9ec6cb..c16bd1ab37f8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -64,14 +64,18 @@ KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 LD		+= -EB
+ifneq ($(ld-name),gold)
 LDFLAGS		+= -maarch64linuxb
+endif
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 LD		+= -EL
+ifneq ($(ld-name),gold)
 LDFLAGS		+= -maarch64linux
+endif
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.15.0.403.gc27cc4dac6-goog
