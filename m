From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 23 Jul 2015 00:10:37 +0200
Subject: [PATCH] memory: pl172: fix modular build
In-Reply-To: <20150722184345.GB11162@sirena.org.uk>
References: <20150722184345.GB11162@sirena.org.uk>
Message-ID: <1437603037-18395-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building pl172 as a module fails with:
> ERROR: "of_default_bus_match_table" [drivers/memory/pl172.ko] undefined!

Because the symbol of_default_bus_match_table isn't exported by the OF
core code so can't be referenced from modules. Fix this by removing
the usage of of_default_bus_match_table for now. The side effect of
this is that child nodes can't use "simple-bus" or "simple-mfd".

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

This should fix the allmod build failure introduces by the
pl172 driver that Mark encountered. After this fix the driver
should builds just fine as a module and there is no behavior
change when boot my devkit either since none of children under
pl172 uses "simple-bus/mfd" right now.

 drivers/memory/pl172.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
index 3a8e57ee96f0..b2ef6072fbf4 100644
--- a/drivers/memory/pl172.c
+++ b/drivers/memory/pl172.c
@@ -255,8 +255,7 @@ static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 		if (ret)
 			continue;
 
-		of_platform_populate(child_np, of_default_bus_match_table,
-				     NULL, dev);
+		of_platform_populate(child_np, NULL, NULL, dev);
 	}
 
 	return 0;
-- 
1.8.0
