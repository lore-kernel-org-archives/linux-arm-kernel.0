From: rabin@rab.in (Rabin Vincent)
Date: Wed, 11 May 2011 22:53:51 +0530
Subject: [PATCH] ftrace: recordmcount: avoid STT_FUNC symbols as base on ARM
Message-ID: <1305134631-31617-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While find_secsym_ndx often finds the unamed local STT_SECTION, if a
section has only one function in it, the ARM toolchain generates the
STT_FUNC symbol before the STT_SECTION, and recordmcount finds this
instead.

This is problematic on ARM because in ARM ELFs, "if a [STT_FUNC] symbol
addresses a Thumb instruction, its value is the address of the
instruction with bit zero set (in a relocatable object, the section
offset with bit zero set)".  This leads to incorrect mcount addresses
being recorded.

Fix this by not using STT_FUNC symbols as the base on ARM.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 scripts/recordmcount.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index baf187b..0e2944a 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -39,6 +39,7 @@
 #undef ELF_R_INFO
 #undef Elf_r_info
 #undef ELF_ST_BIND
+#undef ELF_ST_TYPE
 #undef fn_ELF_R_SYM
 #undef fn_ELF_R_INFO
 #undef uint_t
@@ -68,6 +69,7 @@
 # define ELF_R_INFO		ELF64_R_INFO
 # define Elf_r_info		Elf64_r_info
 # define ELF_ST_BIND		ELF64_ST_BIND
+# define ELF_ST_TYPE		ELF64_ST_TYPE
 # define fn_ELF_R_SYM		fn_ELF64_R_SYM
 # define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
@@ -96,6 +98,7 @@
 # define ELF_R_INFO		ELF32_R_INFO
 # define Elf_r_info		Elf32_r_info
 # define ELF_ST_BIND		ELF32_ST_BIND
+# define ELF_ST_TYPE		ELF32_ST_TYPE
 # define fn_ELF_R_SYM		fn_ELF32_R_SYM
 # define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
@@ -333,6 +336,11 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 		if (txtndx == w2(symp->st_shndx)
 			/* avoid STB_WEAK */
 		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
+			/* function symbols on ARM have quirks, avoid them */
+			if (w2(ehdr->e_machine) == EM_ARM
+			    && ELF_ST_TYPE(symp->st_info) == STT_FUNC)
+				continue;
+
 			*recvalp = _w(symp->st_value);
 			return symp - sym0;
 		}
-- 
1.7.4.1
