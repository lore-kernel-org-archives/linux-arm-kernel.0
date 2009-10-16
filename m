From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:29 -0700
Subject: [PATCH 25/46] DaVinci: EDMA: Fix Bug while obtaining contiguous params
In-Reply-To: <1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Paulraj <s-paulraj@ti.com>

The reserve_contiguous_params function is used to reserve
a set of contiguous PARAMs. If we do not find a complete
set of contiguous PARAMs, the functions still has to free
every PARAM that it found to be free in the process of finding a
complete set and thus marked as "in use".
This patch mainly deals with correctly handling the
freeing of PARAMs.

Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 8eda4c3..b097592 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -515,17 +515,30 @@ static int reserve_contiguous_params(int ctlr, unsigned int id,
 {
 	int i, j;
 	unsigned int count = num_params;
+	int stop_param = start_param;
+	DECLARE_BITMAP(tmp_inuse, EDMA_MAX_PARAMENTRY);
 
 	for (i = start_param; i < edma_info[ctlr]->num_slots; ++i) {
 		j = EDMA_CHAN_SLOT(i);
-		if (!test_and_set_bit(j, edma_info[ctlr]->edma_inuse))
+		if (!test_and_set_bit(j, edma_info[ctlr]->edma_inuse)) {
+			/* Record our current beginning slot */
+			if (count == num_params)
+				stop_param = i;
+
 			count--;
+			set_bit(j, tmp_inuse);
+
 			if (count == 0)
 				break;
-		else if (id == EDMA_CONT_PARAMS_FIXED_EXACT)
-			break;
-		else
-			count = num_params;
+		} else {
+			clear_bit(j, tmp_inuse);
+
+			if (id == EDMA_CONT_PARAMS_FIXED_EXACT) {
+				stop_param = i;
+				break;
+			} else
+				count = num_params;
+		}
 	}
 
 	/*
@@ -534,12 +547,15 @@ static int reserve_contiguous_params(int ctlr, unsigned int id,
 	 * of contiguous parameter RAMs but do not find the exact number
 	 * requested as we may reach the total number of parameter RAMs
 	 */
-	if (count) {
-		for (j = i - num_params + count + 1; j <= i ; ++j)
+	if (i == edma_info[ctlr]->num_slots)
+		stop_param = i;
+
+	for (j = start_param; j < stop_param; j++)
+		if (test_bit(j, tmp_inuse))
 			clear_bit(j, edma_info[ctlr]->edma_inuse);
 
+	if (count)
 		return -EBUSY;
-	}
 
 	for (j = i - num_params + 1; j <= i; ++j)
 		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(j),
-- 
1.6.4.3
