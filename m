From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 22 Jan 2012 08:45:44 -0700
Subject: [PATCH 3/3] ARM: OMAP: I2C: fix compilation when !CONFIG_OF
In-Reply-To: <20120122110232.6508.68451.stgit@dusk>
References: <20120122105942.6508.82335.stgit@dusk>
 <20120122110232.6508.68451.stgit@dusk>
Message-ID: <20120122154544.GW4223@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 04:02:33AM -0700, Paul Walmsley wrote:
> Commit 6145197be6cc0583fa1a2f4ec1079d366137061e ("i2c: OMAP: Add DT
> support for i2c controller") breaks compilation when CONFIG_OF is not
> defined:
> 
>   CC      drivers/i2c/busses/i2c-omap.o
> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
> drivers/i2c/busses/i2c-omap.c:1021:26: error: 'omap_i2c_of_match' undeclared (first use in this function)
> drivers/i2c/busses/i2c-omap.c:1021:26: note: each undeclared identifier is reported only once for each function it appears in
> 
> Fix this by avoiding of_*() functions when !CONFIG_OF.

To avoid #ifdef blocks, how about one of these fixes instead?
of_match_device resolves to a static inline NULL when CONFIG_OF is not
selected.

g.

---
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f713eac..c22e51f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -979,6 +979,8 @@ static const struct of_device_id omap_i2c_of_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
+#else
+#define omap_i2c_of_match NULL
 #endif
 
 static int __devinit


Or alternately:
---

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f713eac..801df60 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1018,7 +1018,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	match = of_match_device(omap_i2c_of_match, &pdev->dev);
+	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
 	if (match) {
 		u32 freq = 100000; /* default to 100000 Hz */
 
