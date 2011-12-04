From: hs@denx.de (Heiko Schocher)
Date: Sun,  4 Dec 2011 10:33:30 +0100
Subject: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
Message-ID: <1322991210-20486-1-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC driver allocates channels with EVENTQ_DEFAULT they
get put into EVENTQ_1 which the second EDMA controller does
not have and hence transfers stall. This is tried to fix
in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
from Ido Yariv, but missed a fix for the second MMC
controller on da850.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: juha.kuikka at gmail.com
Reported-by: juha.kuikka at gmail.com
Cc: linux-mmc at vger.kernel.org
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
Cc: Ido Yariv <ido@wizery.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-davinci/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index da90103..e10a251 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1513,7 +1513,7 @@ static int __init edma_probe(struct platform_device *pdev)
 		 * started by the codec engine will not cause audio defects.
 		 */
 		for (i = 0; i < edma_cc[j]->num_channels; i++)
-			map_dmach_queue(j, i, EVENTQ_1);
+			map_dmach_queue(j, i, info[j]->default_queue);
 
 		queue_tc_mapping = info[j]->queue_tc_mapping;
 		queue_priority_mapping = info[j]->queue_priority_mapping;
-- 
1.7.6.4
