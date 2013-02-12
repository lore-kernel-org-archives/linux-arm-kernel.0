From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 12 Feb 2013 12:18:20 -0300
Subject: [PATCH v2 3/8] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
In-Reply-To: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360682305-20935-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently gpmc_cs_reserved() return value is somewhat inconsistent,
returning a negative value on an error condition, a positive value
if the chip select is reserved and zero if it's available.

Fix this by returning a boolean value as the function name suggests:
  * true if the chip select is reserved,
  * false if it's available

Suggested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changelog from v1:
 * As suggested by Felipe Balbi, fix return code to a boolean

 arch/arm/mach-omap2/gpmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd3bc93..fa4764f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -452,10 +452,10 @@ static int gpmc_cs_set_reserved(int cs, int reserved)
 	return 0;
 }
 
-static int gpmc_cs_reserved(int cs)
+static bool gpmc_cs_reserved(int cs)
 {
 	if (cs > GPMC_CS_NUM)
-		return -ENODEV;
+		return true;
 
 	return gpmc_cs_map & (1 << cs);
 }
-- 
1.7.8.6
