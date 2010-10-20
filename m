From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 17:44:30 +0200
Subject: [PATCH v4] imx-esdhc: update devices registration
In-Reply-To: <4CBF0553.30000@eukrea.com>
References: <20101012153155.GE4470@pengutronix.de>
	<1286904825-6432-1-git-send-email-eric@eukrea.com>
	<20101020145532.GD19834@pengutronix.de> <4CBF0553.30000@eukrea.com>
Message-ID: <20101020154430.GF19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 05:05:55PM +0200, Eric B?nard wrote:
> Hi Uwe,
>
> Le 20/10/2010 16:55, Uwe Kleine-K?nig a ?crit :
>> On Tue, Oct 12, 2010 at 07:33:45PM +0200, Eric B?nard wrote:
>>> Tested on i.MX25 and i.MX35 and i.MX51
>>>
>>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>> This patch (or more exact: the version of this patch that Sascha picked
>> up) breaks compiling mx3_defconfig.
>>
> I may have made a mistake somewhere using git when providing the branch 
> for Sascha to merge it because I upgraded this patch when I tested 
> mx3_defconfig to have it compile !
>
>> The better fix would be to delete mxcsdhc_device[01] from
>> arch/arm/mach-mx3/devices.c and convert all users to the new function.
>> Volunteers?  Eric?
>>
> I will see what I can do next week.
Hmm, next week might be late for Russell's first pull-request to Linus,
so below is a fix.

As the mmc unit on mx31 is different from the one on mx35, I didn't fold
it into arch/arm/plat-mxc/devices/platform-esdhc.c but simply fixed the
definition in arch/arm/mach-mx3/devices.c.

----------------------------->8-------------------------
ARM: mx3: fix build failure concerning MXC_INT_MMC_SDHC2

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Commit c074512 (imx-esdhc: update devices registration) renamed
MX35_INT_MMC_SDHC2 to MX35_INT_ESDHC2 which broke expansion of the
MXC_INT_MMC_SDHC2 macro.
As  (the only user of MXC_INT_MMC_SDHC2) is only used on
mx31 use the MX31 prefixed symbol to define its resources.  Moreover to
reduce further confusion mxcsdhc_device0 is fixed accordingly and the MXC
prefixed symbols are removed.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c           |   16 ++++++++--------
 arch/arm/plat-mxc/include/mach/mx31.h |    1 -
 arch/arm/plat-mxc/include/mach/mx35.h |    2 --
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index f4dff11..d4da949 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -72,24 +72,24 @@ struct platform_device mxc_w1_master_device = {
 #ifdef CONFIG_ARCH_MX31
 static struct resource mxcsdhc0_resources[] = {
 	{
-		.start = MMC_SDHC1_BASE_ADDR,
-		.end = MMC_SDHC1_BASE_ADDR + SZ_16K - 1,
+		.start = MX31_MMC_SDHC1_BASE_ADDR,
+		.end = MX31_MMC_SDHC1_BASE_ADDR + SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_MMC_SDHC1,
-		.end = MXC_INT_MMC_SDHC1,
+		.start = MX31_INT_MMC_SDHC1,
+		.end = MX31_INT_MMC_SDHC1,
 		.flags = IORESOURCE_IRQ,
 	},
 };
 
 static struct resource mxcsdhc1_resources[] = {
 	{
-		.start = MMC_SDHC2_BASE_ADDR,
-		.end = MMC_SDHC2_BASE_ADDR + SZ_16K - 1,
+		.start = MX31_MMC_SDHC2_BASE_ADDR,
+		.end = MX31_MMC_SDHC2_BASE_ADDR + SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_MMC_SDHC2,
-		.end = MXC_INT_MMC_SDHC2,
+		.start = MX31_INT_MMC_SDHC2,
+		.end = MX31_INT_MMC_SDHC2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 03e2afa..61cfe82 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -240,7 +240,6 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MPEG4_ENC_BASE_ADDR MX31_MPEG4_ENC_BASE_ADDR
 #define MXC_INT_MPEG4_ENCODER MX31_INT_MPEG4_ENCODER
 #define MXC_INT_FIRI MX31_INT_FIRI
-#define MXC_INT_MMC_SDHC1 MX31_INT_MMC_SDHC1
 #define MXC_INT_MBX MX31_INT_MBX
 #define MXC_INT_CSPI3 MX31_INT_CSPI3
 #define MXC_INT_SIM2 MX31_INT_SIM2
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index ff905cb..6267cff 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -197,8 +197,6 @@
 /* these should go away */
 #define MXC_FEC_BASE_ADDR MX35_FEC_BASE_ADDR
 #define MXC_INT_OWIRE MX35_INT_OWIRE
-#define MXC_INT_MMC_SDHC2 MX35_INT_MMC_SDHC2
-#define MXC_INT_MMC_SDHC3 MX35_INT_MMC_SDHC3
 #define MXC_INT_GPU2D MX35_INT_GPU2D
 #define MXC_INT_ASRC MX35_INT_ASRC
 #define MXC_INT_USBHS MX35_INT_USBHS
-- 
1.7.2.3

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
