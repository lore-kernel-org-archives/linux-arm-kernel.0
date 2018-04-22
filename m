From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Sun, 22 Apr 2018 11:14:08 +0200
Subject: [PATCH 0/6] tree-wide: simplify getting .drvdata
Message-ID: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got tired of fixing this in Renesas drivers manually, so I took the big
hammer. Remove this cumbersome code pattern which got copy-pasted too much
already:

-	struct platform_device *pdev = to_platform_device(dev);
-	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);

I send this out as one patch per directory per subsystem. I think they should
be applied individually. If you prefer a broken out series per subsystem, I can
provide this as well. Just mail me.

A branch (tested by buildbot; only with all commits squashed into one commit
before) can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata

Open for other comments, suggestions, too, of course.

Here is the cocci-script I created:

@@
struct device* d;
identifier pdev;
expression *ptr;
@@
(
-	struct platform_device *pdev = to_platform_device(d);
|
-	struct platform_device *pdev;
	...
-	pdev = to_platform_device(d);
)
	<... when != pdev
-	&pdev->dev
+	d
	...>

	ptr =
-	platform_get_drvdata(pdev)
+	dev_get_drvdata(d)

	<... when != pdev
-	&pdev->dev
+	d
	...>

Kind regards,

   Wolfram


Wolfram Sang (6):
  dmaengine: at_hdmac: simplify getting .drvdata
  dmaengine: at_xdmac: simplify getting .drvdata
  dmaengine: fsldma: simplify getting .drvdata
  dmaengine: idma64: simplify getting .drvdata
  dmaengine: ste_dma40: simplify getting .drvdata
  dmaengine: txx9dmac: simplify getting .drvdata

 drivers/dma/at_hdmac.c  |  9 +++------
 drivers/dma/at_xdmac.c  |  9 +++------
 drivers/dma/fsldma.c    |  6 ++----
 drivers/dma/idma64.c    |  6 ++----
 drivers/dma/ste_dma40.c | 12 ++++--------
 drivers/dma/txx9dmac.c  |  8 +++-----
 6 files changed, 17 insertions(+), 33 deletions(-)

-- 
2.11.0
