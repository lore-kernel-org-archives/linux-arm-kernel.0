From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:41 +0900
Subject: [RFC 15/15] mfd: syscon: Fix build of missing ioremap on UM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-16-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit c89c0114955a ("mfd: syscon: Set regmap max_register in
of_syscon_register") the syscon uses ioremap so it fails on COMPILE_TEST
without HAS_IOMEM:

drivers/mfd/syscon.c: In function ?of_syscon_register?:
drivers/mfd/syscon.c:67:9: error: implicit declaration of function ?ioremap? [-Werror=implicit-function-declaration]
  base = ioremap(res.start, resource_size(&res));
         ^
drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  base = ioremap(res.start, resource_size(&res));
       ^
drivers/mfd/syscon.c:109:2: error: implicit declaration of function ?iounmap? [-Werror=implicit-function-declaration]
  iounmap(base);

When selecting MFD_SYSCON, depend on HAS_IOMEM to avoid unmet direct
dependencies.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: c89c0114955a ("mfd: syscon: Set regmap max_register in of_syscon_register")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aa21dc55eb15..2e5b1e525a1d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1034,6 +1034,7 @@ config MFD_SUN6I_PRCM
 
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Select this option to enable accessing system control registers
-- 
2.5.0
