From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Feb 2016 20:50:54 +0100
Subject: [PATCH] kallsyms: ignore ARM mode switching veneers
Message-ID: <1456516254-15615-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, the linker may emit veneers to deal with relative branch
instructions that appear too far away from their targets. Since the second
kallsyms pass results in an increase of the kernel size, it may result in
additional veneers to be emitted, potentially affecting the output of
kallsyms itself if these symbols are visible to it, and for that reason,
symbols whose names end in '_veneer' are ignored explicitly.

However, when building Thumb2 kernels, such veneers are named differently
if they also incur a mode switch, and since they are not filtered by
kallsyms, they may cause the build to fail. So filter symbols whose names
end in '_from_arm' or '_from_thumb' as well.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8fa81e84e295..e2379de76563 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -215,6 +215,8 @@ static int symbol_valid(struct sym_entry *s)
 
 	static char *special_suffixes[] = {
 		"_veneer",		/* arm */
+		"_from_arm",		/* arm */
+		"_from_thumb",		/* arm */
 		NULL };
 
 	int i;
-- 
2.5.0
