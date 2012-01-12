From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 12 Jan 2012 10:55:12 +0100
Subject: [PATCH 10/15] arch/arm/mach-imx/mach-mx53_ard.c: add missing iounmap
Message-ID: <1326362117-29371-10-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Add missing iounmap in error handling code, in a case where the function
already preforms iounmap on some other execution path.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
statement S,S1;
int ret;
@@
e = \(ioremap\|ioremap_nocache\)(...)
... when != iounmap(e)
if (<+...e...+>) S
... when any
    when != iounmap(e)
*if (...)
   { ... when != iounmap(e)
     return ...; }
... when any
iounmap(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/mach-imx/mach-mx53_ard.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx53_ard.c b/arch/arm/mach-imx/mach-mx53_ard.c
index 08dfb76..753f4fc 100644
--- a/arch/arm/mach-imx/mach-mx53_ard.c
+++ b/arch/arm/mach-imx/mach-mx53_ard.c
@@ -188,8 +188,10 @@ static int weim_cs_config(void)
 		return -ENOMEM;
 
 	iomuxc_base = ioremap(MX53_IOMUXC_BASE_ADDR, SZ_4K);
-	if (!iomuxc_base)
+	if (!iomuxc_base) {
+		iounmap(weim_base);
 		return -ENOMEM;
+	}
 
 	/* CS1 timings for LAN9220 */
 	writel(0x20001, (weim_base + 0x18));
