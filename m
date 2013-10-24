From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Oct 2013 16:08:06 +0900
Subject: [PATCH v2 4/6] ftrace: Add arm64 support to recordmcount
In-Reply-To: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1382598488-13511-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recordmcount utility scans every object, finds out all the locations
of calling _mcount() and puts them into __mcount_loc section.
linker compiles all the information in between __start_mcount_loc
and __stop_mcount_loc for later use by ftrace.

There are two types of implementation, C or Perl.
In arm64, only C version is used since HAVE_C_RECORDMCOUNT is defined.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig      |    2 ++
 scripts/recordmcount.c  |    4 ++++
 scripts/recordmcount.pl |    5 +++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c150430..4f4a0dc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,11 +19,13 @@ config ARM64
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 9c22317..b92d9f7 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -347,6 +347,10 @@ do_file(char const *const fname)
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
 			 break;
+	case EM_AARCH64:
+			 reltype = R_AARCH64_ABS64;
+			 altmcount = "_mcount";
+			 break;
 	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
 	case EM_METAG:	 reltype = R_METAG_ADDR32;
 			 altmcount = "_mcount_wrapper";
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index a674fd5..ae8b0fe 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -279,6 +279,11 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_ARM_(CALL|PC24|THM_CALL)" .
 			"\\s+(__gnu_mcount_nc|mcount)\$";
 
+} elsif ($arch eq "arm64") {
+    $alignment = 3;
+    $section_type = '%progbits';
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_AARCH64_CALL26\\s+_mcount\$";
+    $type = ".quad";
 } elsif ($arch eq "ia64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
     $type = "data8";
-- 
1.7.9.5
