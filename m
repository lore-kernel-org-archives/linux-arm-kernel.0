From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 16:55:32 +0200
Subject: [PATCH v4] imx-esdhc: update devices registration
In-Reply-To: <1286904825-6432-1-git-send-email-eric@eukrea.com>
References: <20101012153155.GE4470@pengutronix.de>
	<1286904825-6432-1-git-send-email-eric@eukrea.com>
Message-ID: <20101020145532.GD19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Tue, Oct 12, 2010 at 07:33:45PM +0200, Eric B?nard wrote:
> Tested on i.MX25 and i.MX35 and i.MX51
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
This patch (or more exact: the version of this patch that Sascha picked
up) breaks compiling mx3_defconfig.

The minimal fix is

diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index ff905cb..9d46b7e 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -197,8 +197,8 @@
 /* these should go away */
 #define MXC_FEC_BASE_ADDR MX35_FEC_BASE_ADDR
 #define MXC_INT_OWIRE MX35_INT_OWIRE
-#define MXC_INT_MMC_SDHC2 MX35_INT_MMC_SDHC2
+#define MXC_INT_MMC_SDHC2 MX35_INT_ESDHC2
 #define MXC_INT_MMC_SDHC3 MX35_INT_MMC_SDHC3
 #define MXC_INT_GPU2D MX35_INT_GPU2D
 #define MXC_INT_ASRC MX35_INT_ASRC
 #define MXC_INT_USBHS MX35_INT_USBHS

But somehow this is still broken because arch/arm/mach-mx3/devices.c
uses MXC_INT_MMC_SDHC1 and MXC_INT_MMC_SDHC2.  The former is defined as

	#define MXC_INT_MMC_SDHC1 MX31_INT_MMC_SDHC1
	#define MX31_INT_MMC_SDHC1      9

the latter as

	#define MXC_INT_MMC_SDHC2 MX35_INT_ESDHC2
	#define MX35_INT_ESDHC2         8

.  Moreover we have:

	#define MXC_INT_MMC_SDHC3 MX35_INT_ESDHC3
	#define MX35_INT_ESDHC3         9

and note that arch/arm/mach-mx3/devices.c only defines mxcsdhc_device0
and mxcsdhc_device1 in an #ifdef CONFIG_ARCH_MX31 block.  (So I guess
that in an mx31 kernel the error is not, that MX35_INT_MMC_SDHC2 isn't
defined but MXC_INT_MMC_SDHC2.)

Ugly.

The better fix would be to delete mxcsdhc_device[01] from
arch/arm/mach-mx3/devices.c and convert all users to the new function.
Volunteers?  Eric?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
