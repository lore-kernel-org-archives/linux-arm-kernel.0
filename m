From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu,  2 Sep 2010 17:39:07 +0300
Subject: [PATCH v2] ep93xx: move clock initialization earlier
Message-ID: <1283438347-22257-1-git-send-email-mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7cfe24947 ("ARM: AMBA: Add pclk support to AMBA bus infrastructure")
changed AMBA bus to handle the PCLK automatically. However, in EP93xx clock
initialization is arch_initcall which is done later than AMBA device
identification. This causes amba_get_enable_pclk() to fail resulting device
where UARTs are not functional.

So change ep93xx_clock_init() to be postcore_initcall.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
Changes to v1:
	* use postcore_initcall instead of calling from ep93xx_map_io().

 arch/arm/mach-ep93xx/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 8bf3cec..4566bd1 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -560,4 +560,4 @@ static int __init ep93xx_clock_init(void)
 	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
 	return 0;
 }
-arch_initcall(ep93xx_clock_init);
+postcore_initcall(ep93xx_clock_init);
-- 
1.5.6.5
