From: jamie@jamieiles.com (Jamie Iles)
Date: Tue,  7 Dec 2010 20:28:44 +0000
Subject: [PATCH] ARM: Fix warning with gcc 4.5.1 in alignment fixup
Message-ID: <1291753724-14437-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With GCC 4.5.1 we get the following warning:

	  CC      arch/arm/mm/alignment.o
	arch/arm/mm/alignment.c: In function 'do_alignment':
	arch/arm/mm/alignment.c:720:21: warning: 'offset.un' may be used
	uninitialized in this function

This warning is triggered for the LDM/STM instructions which don't have
a register offset so set the offset to 0 to keep GCC happy.

Cc: George G. Davis <gdavis@mvista.com>
Cc: Min Zhang <mzhang@mvista.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mm/alignment.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 724ba3b..298aaef 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -824,8 +824,10 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	case 0x08000000:	/* ldm or stm, or thumb-2 32bit instruction */
 		if (thumb2_32b)
 			handler = do_alignment_t32_to_handler(&instr, regs, &offset);
-		else
+		else {
 			handler = do_alignment_ldmstm;
+			offset.un = 0;
+		}
 		break;
 
 	default:
-- 
1.7.3.2
