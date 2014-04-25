From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:34:46 +0100
Subject: [PATCH 045/222] ARM: l2c: highbank: remove explicit SMI call in L2
 cache initialisation
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeP0-0007GA-Ry@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that highbank uses the write_sec method, we don't need to enable
the L2 cache in SoC specific code; this can be done via the normal
mechanisms in the L2C code.

Checking with Rob Herring:
> > Can we kill the "highbank_smc1(0x102, 0x1);" here?	That means
> > l2x0_of_init() will see the L2 cache disabled, and will try to enable
> > it via the write_sec hook, so it should do the right thing.
>
> Yes, that should work. You should be able to just call l2x0_of_init
> unconditionally. The condition was really to just avoid the smc on
> Midway which does get handled on h/w, but not if running virtualized.

So also drop the DT check too.  I'm leaving the config check in place
so that if L2 is disabled, the write_sec hook can be optimised away.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-highbank/highbank.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 4712aed3d9f6..245e588859ec 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -68,9 +68,7 @@ static void __init highbank_init_irq(void)
 		highbank_scu_map_io();
 
 	/* Enable PL310 L2 Cache controller */
-	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
-	    of_find_compatible_node(NULL, NULL, "arm,pl310-cache")) {
-		highbank_smc1(0x102, 0x1);
+	if (IS_ENABLED(CONFIG_CACHE_L2X0)) {
 		outer_cache.write_sec = highbank_l2c310_write_sec;
 		l2x0_of_init(0, ~0);
 	}
-- 
1.8.3.1
