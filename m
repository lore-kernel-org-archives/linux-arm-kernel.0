From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 13 Jul 2014 12:00:43 +0100
Subject: [PATCH] ARM: avoid ARM binutils leaking ELF local symbols
Message-ID: <E1X6HWN-0006io-Od@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbols starting with .L are ELF local symbols and should not appear
in ELF symbol tables.  However, unfortunately ARM binutils leaks the
.LANCHOR symbols into the symbol table, which leads kallsyms to report
these symbols rather than the real name.  It is not very useful when
%pf reports symbols against these leaked .LANCHOR symbols.

Arrange for kallsyms to ignore these symbols using the same mechanism
that is used for the ARM mapping symbols.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 81e727cf6df9..cecd78d06025 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3385,6 +3385,8 @@ static inline int within(unsigned long addr, void *start, unsigned long size)
  */
 static inline int is_arm_mapping_symbol(const char *str)
 {
+	if (str[0] == '.' && str[1] == 'L')
+		return true;
 	return str[0] == '$' && strchr("atd", str[1])
 	       && (str[2] == '\0' || str[2] == '.');
 }
-- 
1.8.3.1
