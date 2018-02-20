From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 22:59:51 +0100
Subject: [PATCH 4/7] ARM: io-acorn: fix LTO linking without CONFIG_PRINTK
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
Message-ID: <20180220215954.4092811-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_LTO is enabled, we get a link error for this file
that contains a reference to printk():

arch/arm/lib/io-acorn.o: In function `outsl':
(.text+0x38): undefined reference to `printk'

Normally the file is simply dropped, but that doesn't happen
with LTO. Making the reference conditional helps, but perhaps
a better fix would be to make sure the LTO linker drops the
entire file in the same way that we normally do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/lib/io-acorn.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/lib/io-acorn.S b/arch/arm/lib/io-acorn.S
index 69719bad674d..3522a899460b 100644
--- a/arch/arm/lib/io-acorn.S
+++ b/arch/arm/lib/io-acorn.S
@@ -27,6 +27,10 @@
  */
 ENTRY(insl)
 ENTRY(outsl)
+#ifdef CONFIG_PRINTK
 		adr	r0, .Liosl_warning
 		mov	r1, lr
 		b	printk
+#else
+		ret	lr
+#endif
-- 
2.9.0
