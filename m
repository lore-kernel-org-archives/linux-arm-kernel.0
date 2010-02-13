From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:18:35 +0530
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <1266090518-31120-1-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
Message-ID: <1266090518-31120-8-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, we have two ABIs, and the ABI used is controlled via a config
option.  Object files built with one ABI can't be merged with object
files built with the other ABI.  So, record_mcount.pl needs to use the
same compiler flags as the kernel when generating the object file with
the mcount locations.  Ensure this by passing CFLAGS to the script.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 scripts/Makefile.build |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0b94d2f..2535c11 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -209,7 +209,8 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
 cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
-	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
+	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
+	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 endif
 
-- 
1.6.6
