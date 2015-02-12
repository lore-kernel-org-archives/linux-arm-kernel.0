From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:41 +0100
Subject: [PATCH 4/9] ARM: s3c24xx: use SAMSUNG_WAKEMASK for s3c2416
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <1423769746-582629-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both s3c2412 and s3c2416 use the s3c2412_pm_prepare code, which
depends on the common wakemask code, but only s3c2412 currently
selects the code, leading to a build error for an s3c2416-only
kernel.

arch/arm/mach-s3c24xx/built-in.o: In function `s3c2412_pm_prepare':
:(.text+0x240): undefined reference to `samsung_sync_wakemask'
arch/arm/mach-s3c24xx/built-in.o:(.data+0xeb0): undefined reference to `s3c2412_subsys'

This adds the missing select.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 79c49ff77f6e..389173690716 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -362,6 +362,7 @@ if CPU_S3C2416
 config S3C2416_PM
 	bool
 	select S3C2412_PM_SLEEP
+	select SAMSUNG_WAKEMASK
 	help
 	  Internal config node to apply S3C2416 power management
 
-- 
2.1.0.rc2
