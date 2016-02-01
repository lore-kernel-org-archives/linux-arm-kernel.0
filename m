From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 14:09:35 +0100
Subject: [PATCH v5sub2 5/8] scripts/sortextable: add support for ET_DYN
 binaries
In-Reply-To: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454332178-4414-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to scripts/sortextable for handling relocatable (PIE)
executables, whose ELF type is ET_DYN, not ET_EXEC. Other than adding
support for the new type, no changes are needed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/sortextable.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index af247c70fb66..19d83647846c 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -266,9 +266,9 @@ do_file(char const *const fname)
 		break;
 	}  /* end switch */
 	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0
-	||  r2(&ehdr->e_type) != ET_EXEC
+	||  (r2(&ehdr->e_type) != ET_EXEC && r2(&ehdr->e_type) != ET_DYN)
 	||  ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
-		fprintf(stderr, "unrecognized ET_EXEC file %s\n", fname);
+		fprintf(stderr, "unrecognized ET_EXEC/ET_DYN file %s\n", fname);
 		fail_file();
 	}
 
@@ -304,7 +304,7 @@ do_file(char const *const fname)
 		if (r2(&ehdr->e_ehsize) != sizeof(Elf32_Ehdr)
 		||  r2(&ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
-				"unrecognized ET_EXEC file: %s\n", fname);
+				"unrecognized ET_EXEC/ET_DYN file: %s\n", fname);
 			fail_file();
 		}
 		do32(ehdr, fname, custom_sort);
@@ -314,7 +314,7 @@ do_file(char const *const fname)
 		if (r2(&ghdr->e_ehsize) != sizeof(Elf64_Ehdr)
 		||  r2(&ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
-				"unrecognized ET_EXEC file: %s\n", fname);
+				"unrecognized ET_EXEC/ET_DYN file: %s\n", fname);
 			fail_file();
 		}
 		do64(ghdr, fname, custom_sort);
-- 
2.5.0
