From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:22:21 +0100
Subject: [PATCH kexec-tools 15/32] arm: fix get_kernel_stext_sym() to close
 its file
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXTB-0004iP-5Y@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix get_kernel_stext_sym() so that it closes its file once it's
finsihed with it - there's no need to leak file descriptors.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index b523e5f..a390187 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -71,25 +71,34 @@ static unsigned long long get_kernel_stext_sym(void)
 	char sym[128];
 	char line[128];
 	FILE *fp;
-	unsigned long long vaddr;
+	unsigned long long vaddr = 0;
 	char type;
 
-	fp = fopen(kallsyms, "r");	if (!fp) {
+	fp = fopen(kallsyms, "r");
+	if (!fp) {
 		fprintf(stderr, "Cannot open %s\n", kallsyms);
 		return 0;
 	}
 
 	while(fgets(line, sizeof(line), fp) != NULL) {
-		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
+		unsigned long long addr;
+
+		if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
 			continue;
+
 		if (strcmp(sym, stext) == 0) {
-			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
-			return vaddr;
+			dbgprintf("kernel symbol %s vaddr = %#llx\n", stext, addr);
+			vaddr = addr;
+			break;
 		}
 	}
 
-	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
-	return 0;
+	fclose(fp);
+
+	if (vaddr == 0)
+		fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
+
+	return vaddr;
 }
 
 static int get_kernel_page_offset(struct kexec_info *info,
-- 
1.9.1
