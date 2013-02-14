From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:26 +0100
Subject: [PATCH 10/11] ARM: s3c: i2c: add platform_device forward declaration
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
Message-ID: <1360849767-1463135-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent cleanup to the mach-osiris.c file is causing build errors
because the i2c-s3c2410.h header file is included before we see
the definition for platform_device. The fix is to make the header file
more robust against inclusion from other places. While this should
normally go through the i2c tree, the bug only exists in arm-soc
at the moment, so it's easier to fix it there before it goes upstream.

Without this patch, building s3c2410_defconfig results in:

arch/arm/mach-s3c24xx/mach-osiris.c:34:0:
include/linux/platform_data/i2c-s3c2410.h:37:26: warning: 'struct platform_device' declared inside parameter list [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-i2c at vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 include/linux/platform_data/i2c-s3c2410.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/i2c-s3c2410.h b/include/linux/platform_data/i2c-s3c2410.h
index 51d52e7..2a50048 100644
--- a/include/linux/platform_data/i2c-s3c2410.h
+++ b/include/linux/platform_data/i2c-s3c2410.h
@@ -15,6 +15,8 @@
 
 #define S3C_IICFLG_FILTER	(1<<0)	/* enable s3c2440 filter */
 
+struct platform_device;
+
 /**
  *	struct s3c2410_platform_i2c - Platform data for s3c I2C.
  *	@bus_num: The bus number to use (if possible).
-- 
1.8.1.2
