From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 19:59:42 +0100
Subject: [PATCH 01/20] ARM: MX3: make CPU revision number detection work on
	all boards
In-Reply-To: <20091216185046.GA16984@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
Message-ID: <1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfgang Denk <wd@denx.de>

Commit 52939c03 (ARM: MX3: fix CPU revision number detection) started
using the CPU's SREV register for revision number detection. This
makes it mandatory to have a valid SPBA0 mapping. Add this to the
global map_io code instead of adding multiple copies for each board.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>

Tested on Qong (EVB-Lite)
Tested-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mm.c       |    5 +++++
 arch/arm/mach-mx3/mx31ads.c  |    5 -----
 arch/arm/mach-mx3/mx31lite.c |    5 -----
 arch/arm/mach-mx3/mx31pdk.c  |    5 -----
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index bedf5b8..6858a4f 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -65,6 +65,11 @@ static struct map_desc mxc_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(AIPS2_BASE_ADDR),
 		.length		= AIPS2_SIZE,
 		.type		= MT_DEVICE_NONSHARED
+	}, {
+		.virtual = SPBA0_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(SPBA0_BASE_ADDR),
+		.length = SPBA0_SIZE,
+		.type = MT_DEVICE_NONSHARED
 	},
 };
 
diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
index 0497c15..3e7bafa 100644
--- a/arch/arm/mach-mx3/mx31ads.c
+++ b/arch/arm/mach-mx3/mx31ads.c
@@ -494,11 +494,6 @@ static void mxc_init_i2c(void)
  */
 static struct map_desc mx31ads_io_desc[] __initdata = {
 	{
-		.virtual	= SPBA0_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(SPBA0_BASE_ADDR),
-		.length		= SPBA0_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	}, {
 		.virtual	= CS4_BASE_ADDR_VIRT,
 		.pfn		= __phys_to_pfn(CS4_BASE_ADDR),
 		.length		= CS4_SIZE / 2,
diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index def6b67..4697164 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -212,11 +212,6 @@ static struct platform_device physmap_flash_device = {
  */
 static struct map_desc mx31lite_io_desc[] __initdata = {
 	{
-		.virtual = SPBA0_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(SPBA0_BASE_ADDR),
-		.length = SPBA0_SIZE,
-		.type = MT_DEVICE_NONSHARED
-	}, {
 		.virtual = CS4_BASE_ADDR_VIRT,
 		.pfn = __phys_to_pfn(CS4_BASE_ADDR),
 		.length = CS4_SIZE,
diff --git a/arch/arm/mach-mx3/mx31pdk.c b/arch/arm/mach-mx3/mx31pdk.c
index 0f7a2f0..18715f1 100644
--- a/arch/arm/mach-mx3/mx31pdk.c
+++ b/arch/arm/mach-mx3/mx31pdk.c
@@ -211,11 +211,6 @@ static int __init mx31pdk_init_expio(void)
  */
 static struct map_desc mx31pdk_io_desc[] __initdata = {
 	{
-		.virtual = SPBA0_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(SPBA0_BASE_ADDR),
-		.length = SPBA0_SIZE,
-		.type = MT_DEVICE_NONSHARED,
-	}, {
 		.virtual = CS5_BASE_ADDR_VIRT,
 		.pfn = __phys_to_pfn(CS5_BASE_ADDR),
 		.length = CS5_SIZE,
-- 
1.6.5.2
