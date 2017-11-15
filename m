From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:15 -0800
Subject: [PATCH v2 05/18] arm64: fix -m for GNU gold
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-6-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GNU gold supports different emulations than bfd. Use aarch64_elf64_*_vec
instead of aarch64linux.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ecd5ed11c764..6059c8169513 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -70,14 +70,22 @@ KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 LD		+= -EB
+ifeq ($(ld-name),gold)
+LDFLAGS		+= -maarch64_elf64_be_vec
+else
 LDFLAGS		+= -maarch64linuxb
+endif
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 LD		+= -EL
+ifeq ($(ld-name),gold)
+LDFLAGS		+= -maarch64_elf64_le_vec
+else
 LDFLAGS		+= -maarch64linux
+endif
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.15.0.448.gf294e3d99a-goog
