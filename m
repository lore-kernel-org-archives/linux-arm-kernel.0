From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 21:57:43 +0100
Subject: [PATCH, RESEND] ssb: host_soc depends on sprom
Message-ID: <1456433869-3919332-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers that use the SSB sprom functionality typically 'select SSB_SPROM'
from Kconfig, but CONFIG_SSB_HOST_SOC misses this, which results in
a build failure unless at least one of the other drivers that selects
it is enabled:

drivers/built-in.o: In function `ssb_host_soc_get_invariants':
(.text+0x459494): undefined reference to `ssb_fill_sprom_with_fallback'

This adds the same select statement that is used elsewhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 541c9a84cd85 ("ssb: pick SoC invariants code from MIPS BCM47xx arch")
---
 drivers/ssb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

I just noticed this hasn't shown up in linux-next yet, so I'm resending
it to ensure it's still on someone's radar. Please ignore the resend
if it's already in a tree that is not part of linux-next but will
be merged eventually.

See https://patchwork.linux-mips.org/patch/12091/ for the original
submission.

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 0c675861623f..d8e4219c2324 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -83,6 +83,7 @@ config SSB_SDIOHOST
 config SSB_HOST_SOC
 	bool "Support for SSB bus on SoC"
 	depends on SSB && BCM47XX_NVRAM
+	select SSB_SPROM
 	help
 	  Host interface for a SSB directly mapped into memory. This is
 	  for some Broadcom SoCs from the BCM47xx and BCM53xx lines.
-- 
2.7.0
