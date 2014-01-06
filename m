From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  6 Jan 2014 09:22:12 +0100
Subject: [PATCH 4/8] x86: align with generic cpu modalias
In-Reply-To: <1388996536-27014-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1388996536-27014-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1388996536-27014-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Align with the new generic 'cpu:type:...:features:...' modalias
by moving the 'x86' prefix and the vendor/family/model IDs into
the 'type' field.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/kernel/cpu/match.c |  3 +--
 scripts/mod/file2alias.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index ab6082a9020e..82e92b2185f6 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -56,8 +56,7 @@ ssize_t arch_print_cpu_modalias(struct device *dev,
 	int i, n;
 	char *buf = bufptr;
 
-	n = snprintf(buf, size, "x86cpu:vendor:%04X:family:%04X:"
-		     "model:%04X:feature:",
+	n = snprintf(buf, size, "cpu:type:x86,ven%04Xfam%04Xmod%04X:feature:",
 		boot_cpu_data.x86_vendor,
 		boot_cpu_data.x86,
 		boot_cpu_data.x86_model);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 8a69005228d8..5fdad833f951 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1110,7 +1110,7 @@ static int do_amba_entry(const char *filename,
 }
 ADD_TO_DEVTABLE("amba", amba_id, do_amba_entry);
 
-/* LOOKS like x86cpu:vendor:VVVV:family:FFFF:model:MMMM:feature:*,FEAT,*
+/* LOOKS like cpu:type:x86,venVVVVfamFFFFmodMMMM:feature:*,FEAT,*
  * All fields are numbers. It would be nicer to use strings for vendor
  * and feature, but getting those out of the build system here is too
  * complicated.
@@ -1124,10 +1124,10 @@ static int do_x86cpu_entry(const char *filename, void *symval,
 	DEF_FIELD(symval, x86_cpu_id, model);
 	DEF_FIELD(symval, x86_cpu_id, vendor);
 
-	strcpy(alias, "x86cpu:");
-	ADD(alias, "vendor:",  vendor != X86_VENDOR_ANY, vendor);
-	ADD(alias, ":family:", family != X86_FAMILY_ANY, family);
-	ADD(alias, ":model:",  model  != X86_MODEL_ANY,  model);
+	strcpy(alias, "cpu:type:x86,");
+	ADD(alias, "ven", vendor != X86_VENDOR_ANY, vendor);
+	ADD(alias, "fam", family != X86_FAMILY_ANY, family);
+	ADD(alias, "mod", model  != X86_MODEL_ANY,  model);
 	strcat(alias, ":feature:*");
 	if (feature != X86_FEATURE_ANY)
 		sprintf(alias + strlen(alias), "%04X*", feature);
-- 
1.8.3.2
