From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:34:20 +0200
Subject: [PATCH 2/3] ARM: assabet: fix bogus warning in get_assabet_scr (again)
In-Reply-To: <1349796861-31164-1-git-send-email-arnd@arndb.de>
References: <1349796861-31164-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796861-31164-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell fixed this bogus warning before in 2f3eca8b4f "Shut up gcc
warning in assabet.c", but apparently gcc has become smarter (or dumber)
since 2005, and the same warning came up again.

This uses the uninitialized_var() macro to convince gcc that the
variable is actually being initialized. 100 times in fact.

Without this patch, building assabet_defconfig results in:

arch/arm/mach-sa1100/assabet.c: In function 'fixup_assabet':
arch/arm/mach-sa1100/assabet.c:397:6: warning: 'scr' may be used uninitialized in this function [-Wuninitialized]
arch/arm/mach-sa1100/assabet.c:389:16: note: 'scr' was declared here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index e1ccda6..6a7ad3c 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -388,7 +388,7 @@ static void __init map_sa1100_gpio_regs( void )
  */
 static void __init get_assabet_scr(void)
 {
-	unsigned long scr, i;
+	unsigned long uninitialized_var(scr), i;
 
 	GPDR |= 0x3fc;			/* Configure GPIO 9:2 as outputs */
 	GPSR = 0x3fc;			/* Write 0xFF to GPIO 9:2 */
-- 
1.7.10
