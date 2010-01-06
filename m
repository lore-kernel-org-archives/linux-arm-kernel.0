From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:17 -0800
Subject: [PATCH 35/35] davinci: dm646x: Specify reserved EDMA channel/slots
	for DM646x
In-Reply-To: <1262802737-6601-35-git-send-email-khilman@deeprootsystems.com>
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
	<1262802737-6601-30-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-31-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-32-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-33-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-34-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-35-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-36-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Pass reserved EDMA channel/slots as platform data for dm646x.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm646x.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index de306ca..99224ec 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -511,6 +511,32 @@ static u8 dm646x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
+/*
+ * The following EDMA channels/slots are not being used by drivers (for
+ * example: Timer, GPIO, UART events etc) on dm646x, hence they are being
+ * reserved for codecs on the DSP side.
+ */
+static const s16 dm646x_dma_rsv_chans[][2] = {
+	/* (offset, number) */
+	{ 0,  4},
+	{13,  3},
+	{24,  4},
+	{30,  2},
+	{54,  3},
+	{-1, -1}
+};
+
+static const s16 dm646x_dma_rsv_slots[][2] = {
+	/* (offset, number) */
+	{ 0,  4},
+	{13,  3},
+	{24,  4},
+	{30,  2},
+	{54,  3},
+	{128, 384},
+	{-1, -1}
+};
+
 /* Four Transfer Controllers on DM646x */
 static const s8
 dm646x_queue_tc_mapping[][2] = {
@@ -539,6 +565,8 @@ static struct edma_soc_info dm646x_edma_info[] = {
 		.n_slot			= 512,
 		.n_tc			= 4,
 		.n_cc			= 1,
+		.rsv_chans		= dm646x_dma_rsv_chans,
+		.rsv_slots		= dm646x_dma_rsv_slots,
 		.queue_tc_mapping	= dm646x_queue_tc_mapping,
 		.queue_priority_mapping	= dm646x_queue_priority_mapping,
 	},
-- 
1.6.6.rc2.1.g42108
