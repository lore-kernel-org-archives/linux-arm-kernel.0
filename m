From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:11 -0800
Subject: [PATCH 29/35] davinci: Fix edma_alloc_channel api for
	EDMA_CHANNEL_ANY case
In-Reply-To: <1262802737-6601-29-git-send-email-khilman@deeprootsystems.com>
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
	<1262802737-6601-29-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-30-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Though edma_alloc_channel api was looping through the available
channel controllers in EDMA_CHANNEL_ANY case, it was never
returning the channel for 2nd channel controller, if 1st
channel controller had no free channels. This issue has
been fixed with this patch.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 97a49f9..89a3dcc 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -595,7 +595,7 @@ int edma_alloc_channel(int channel,
 		void *data,
 		enum dma_event_q eventq_no)
 {
-	unsigned i, done, ctlr = 0;
+	unsigned i, done = 0, ctlr = 0;
 
 	if (channel >= 0) {
 		ctlr = EDMA_CTLR(channel);
@@ -611,7 +611,7 @@ int edma_alloc_channel(int channel,
 						edma_info[i]->num_channels,
 						channel);
 				if (channel == edma_info[i]->num_channels)
-					return -ENOMEM;
+					break;
 				if (!test_and_set_bit(channel,
 						edma_info[i]->edma_inuse)) {
 					done = 1;
@@ -623,6 +623,8 @@ int edma_alloc_channel(int channel,
 			if (done)
 				break;
 		}
+		if (!done)
+			return -ENOMEM;
 	} else if (channel >= edma_info[ctlr]->num_channels) {
 		return -EINVAL;
 	} else if (test_and_set_bit(channel, edma_info[ctlr]->edma_inuse)) {
-- 
1.6.6.rc2.1.g42108
