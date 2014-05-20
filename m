From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 17:35:04 +0200
Subject: [PATCH RFCv2 4/5] ARM: mvebu: enable coherency only when possible on
 Armada XP
In-Reply-To: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400600105-3013-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada XP, the hardware I/O coherency can only be enabled if the
SMP capabilities are enabled (shareable pages, SMP bit, etc.). This
commit ensures that we don't enable hardware I/O coherency if such
requirements are not met.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index d5a975b..2a204d0 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -322,9 +322,16 @@ static int coherency_type(void)
 	if (np) {
 		int type = (int) match->data;
 
-		/* Armada 370/XP coherency works in both UP and SMP */
-		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
-			return type;
+		/*
+		 * Armada 370 coherency has not special requirements,
+		 * Armada XP coherency requires SMP capabilities.
+		 */
+		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP) {
+			if (of_machine_is_compatible("marvell,armadaxp") && is_smp())
+				return type;
+			else if (of_machine_is_compatible("marvell,armada370"))
+				return type;
+		}
 
 		/* Armada 375 coherency works only on SMP */
 		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 && is_smp())
-- 
1.9.3
