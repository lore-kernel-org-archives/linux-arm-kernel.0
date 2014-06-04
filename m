From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 11:06:40 +0200
Subject: [PATCH] ARM: orion5x: fix mvebu_mbus_dt_init call
Message-ID: <4280897.V3UkQjotOL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prototype for mvebu_mbus_dt_init() changed around the same time
as a new caller was added to orion5x. This adds the missing argument
to make orion5x behave correctly to avoid this build error:

mach-orion5x/board-dt.c: In function 'orion5x_dt_init':
mach-orion5x/board-dt.c:48:2: error: too few arguments to function 'mvebu_mbus_dt_init'
  BUG_ON(mvebu_mbus_dt_init());
  ^
In file included from mach-orion5x/board-dt.c:18:0:
include/linux/mbus.h:76:5: note: declared here
 int mvebu_mbus_dt_init(bool is_coherent);
     ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Thomas, I assume you were aware of this problem since you
wrote the two patches that clashed, but for some reason we
screwed it up when merging them into arm-soc. Should we apply
this directly as a bug fix to arm-soc or did you already have
another solution planned?

diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 35d418f..79f033b 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -45,7 +45,7 @@ static void __init orion5x_dt_init(void)
 	orion5x_id(&dev, &rev, &dev_name);
 	printk(KERN_INFO "Orion ID: %s. TCLK=%d.\n", dev_name, orion5x_tclk);
 
-	BUG_ON(mvebu_mbus_dt_init());
+	BUG_ON(mvebu_mbus_dt_init(false));
 
 	/*
 	 * Setup Orion address map
