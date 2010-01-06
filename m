From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:10 -0800
Subject: [PATCH 28/35] davinci: Keep count of channel controllers on a platform
In-Reply-To: <1262802737-6601-28-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-27-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-28-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-29-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Some architectures have only one channel controller, but the
edma_alloc_channel api loops twice to findout the free channel
available in EDMA_CHANNEL_ANY case. A new variable has been
introduced to keep count of number of channel controllers being
used on a particular architecture.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 5a71f4d..97a49f9 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -243,6 +243,7 @@ struct edma {
 };
 
 static struct edma *edma_info[EDMA_MAX_CC];
+static int arch_num_cc;
 
 /* dummy param set used to (re)initialize parameter RAM slots */
 static const struct edmacc_param dummy_paramset = {
@@ -602,7 +603,7 @@ int edma_alloc_channel(int channel,
 	}
 
 	if (channel < 0) {
-		for (i = 0; i < EDMA_MAX_CC; i++) {
+		for (i = 0; i < arch_num_cc; i++) {
 			channel = 0;
 			for (;;) {
 				channel = find_next_bit(edma_info[i]->
@@ -1467,6 +1468,7 @@ static int __init edma_probe(struct platform_device *pdev)
 			edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
 			edma_write_array(j, EDMA_QRAE, i, 0x0);
 		}
+		arch_num_cc++;
 	}
 
 	if (tc_errs_handled) {
-- 
1.6.6.rc2.1.g42108
