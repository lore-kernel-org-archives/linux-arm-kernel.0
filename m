From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:39:03 -0800
Subject: [PATCH v2 5/7] arm64: fix -m for GNU gold
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-6-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GNU gold supports different emulations than bfd. Use aarch64_elf64_*_vec
instead of aarch64linux.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b35788c909f1..82a0df6e865e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -64,14 +64,22 @@ KBUILD_CPPFLAGS	+= -mbig-endian
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
2.15.0.531.g2ccb3012c9-goog
