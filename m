From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:26 -0700
Subject: [PATCH 22/46] DaVinci: EDMA: Fix Bug in edma_alloc_cont_slots API
In-Reply-To: <1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
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
Message-ID: <1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Paulraj <s-paulraj@ti.com>

The edma_alloc_cont_slots API is used for obtaining a set of
contiguous slots. When we use the "_ANY" option with this
API, by definition of this option it is suppossed to start
looking for a set of contiguous slots starting from slot 64 for
DaVinci SOC's and 32 for DA8xx SOC's. This has been explained in
the API description in the driver itself. So when we use the
"_ANY" option with this API, the slot number passed as
an argument should be a "don't care".
This patch takes care of this condition mentioned above.
When checking to see if the starting slot is a valid number,
it checks to make sure that the "_ANY" option is not used.

Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 89ce3e1..8eda4c3 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -771,8 +771,9 @@ int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
 	 * the number of channels and lesser than the total number
 	 * of slots
 	 */
-	if (slot < edma_info[ctlr]->num_channels ||
-		slot >= edma_info[ctlr]->num_slots)
+	if ((id != EDMA_CONT_PARAMS_ANY) &&
+		(slot < edma_info[ctlr]->num_channels ||
+		slot >= edma_info[ctlr]->num_slots))
 		return -EINVAL;
 
 	/*
-- 
1.6.4.3
