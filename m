From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:22:57 +0200
Subject: [PATCH 3/9] ARM: Fix another build warning in arch/arm/mm/alignment.c
In-Reply-To: <1349796183-30648-1-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796183-30648-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One such warning was recently fixed in a761cebf "ARM: Fix build warning
in arch/arm/mm/alignment.c" but only for the thumb2 case, this fixes
the other half.

arch/arm/mm/alignment.c: In function 'do_alignment':
arch/arm/mm/alignment.c:327:15: error: 'offset.un' may be used uninitialized in this function
arch/arm/mm/alignment.c:748:21: note: 'offset.un' was declared here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/alignment.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b9f60eb..023f4437 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -856,8 +856,10 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		if (thumb2_32b) {
 			offset.un = 0;
 			handler = do_alignment_t32_to_handler(&instr, regs, &offset);
-		} else
+		} else {
+			offset.un = 0;
 			handler = do_alignment_ldmstm;
+		}
 		break;
 
 	default:
-- 
1.7.10
