From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:12 +0900
Subject: [PATCH 1/6] ARM: decompressor: drop unneeded assignments to "targets"
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456126277-14633-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "targets" exists to specify which files need the corresponding
".*_cmd" files to be included during the build.  In other words, it
is used for files that need to detect the change of the command line
by if_changed, if_changed_dep, and if_changed_rule.  While, these
files are just copied by "$(call cmd,shipped)".  Adding them to the
"targets" is meaningless because $(call cmd,...) never creates
".*_cmd" files.  Such files as ".lib1funcs.S.cmd", ".ashldi3.S.cmd"
do not exist in the first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 7a6a58e..7090ad3 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -91,8 +91,8 @@ endif
 
 targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
-		 lib1funcs.o lib1funcs.S ashldi3.o ashldi3.S bswapsdi2.o \
-		 bswapsdi2.S font.o font.c head.o misc.o $(OBJS)
+		 lib1funcs.o ashldi3.o bswapsdi2.o \
+		 font.o head.o misc.o $(OBJS)
 
 # Make sure files are removed during clean
 extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
-- 
1.9.1
