From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:17:52 +0200
Subject: [PATCH 3/10] IXP4xx: HW pseudo-random generator is available on
 IXP45x/46x only.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3lig430un.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -127,12 +127,12 @@ config HW_RANDOM_VIA
 	  If unsure, say Y.
 
 config HW_RANDOM_IXP4XX
-	tristate "Intel IXP4xx NPU HW Random Number Generator support"
+	tristate "Intel IXP4xx NPU HW Pseudo-Random Number Generator support"
 	depends on HW_RANDOM && ARCH_IXP4XX
 	default HW_RANDOM
 	---help---
-	  This driver provides kernel-side support for the Random
-	  Number Generator hardware found on the Intel IXP4xx NPU.
+	  This driver provides kernel-side support for the Pseudo-Random
+	  Number Generator hardware found on the Intel IXP45x/46x NPU.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ixp4xx-rng.
--- a/drivers/char/hw_random/ixp4xx-rng.c
+++ b/drivers/char/hw_random/ixp4xx-rng.c
@@ -45,6 +45,9 @@ static int __init ixp4xx_rng_init(void)
 	void __iomem * rng_base;
 	int err;
 
+	if (!cpu_is_ixp46x()) /* includes IXP455 */
+		return -ENOSYS;
+
 	rng_base = ioremap(0x70002100, 4);
 	if (!rng_base)
 		return -ENOMEM;
@@ -68,5 +71,5 @@ module_init(ixp4xx_rng_init);
 module_exit(ixp4xx_rng_exit);
 
 MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
-MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver for IXP4xx");
+MODULE_DESCRIPTION("H/W Pseudo-Random Number Generator (RNG) driver for IXP45x/46x");
 MODULE_LICENSE("GPL");

-- 
Krzysztof Halasa
