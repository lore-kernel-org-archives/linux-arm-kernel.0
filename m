From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  6 Nov 2013 17:32:47 +0100
Subject: [PATCH trivial] arm64: constify hwcap_str
Message-ID: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn hwcap_str from a 'writable array of pointers to const char[]'
to a multidimensional const char[][].

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This is something I noticed when looking at Steve Capper's hwcaps patch: really
no point in having a writable array of 8-byte pointers in .data keeping track of
these hwcap strings.
 
 arch/arm64/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 055cfb8..b6aa6b4 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -301,10 +301,10 @@ static int __init topology_init(void)
 }
 subsys_initcall(topology_init);
 
-static const char *hwcap_str[] = {
+static const char hwcap_str[][8] = {
 	"fp",
 	"asimd",
-	NULL
+	""
 };
 
 static int c_show(struct seq_file *m, void *v)
@@ -328,7 +328,7 @@ static int c_show(struct seq_file *m, void *v)
 	/* dump out the processor features */
 	seq_puts(m, "Features\t: ");
 
-	for (i = 0; hwcap_str[i]; i++)
+	for (i = 0; hwcap_str[i][0]; i++)
 		if (elf_hwcap & (1 << i))
 			seq_printf(m, "%s ", hwcap_str[i]);
 
-- 
1.8.3.2
