From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:40 +0100
Subject: [PATCH 3/9] ARM: s3c64xx: fix __initdata section mismatch
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <1423769746-582629-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smdk6410_b_pwr_5v_data is marked as __initdata, but referenced
from a structure that is not:

WARNING: arch/arm/mach-s3c64xx/built-in.o(.data+0x4c5c): Section mismatch in reference from the variable smdk6410_b_pwr_5v_data to the (unknown reference) .init.data:(unknown)

This removes the annotation to avoid an invalid pointer access
when the regulator driver accesses this variable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 661eb662d051..b7447a92276e 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -209,7 +209,7 @@ static struct platform_device smdk6410_smsc911x = {
 };
 
 #ifdef CONFIG_REGULATOR
-static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] __initdata = {
+static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] = {
 	REGULATOR_SUPPLY("PVDD", "0-001b"),
 	REGULATOR_SUPPLY("AVDD", "0-001b"),
 };
-- 
2.1.0.rc2
