From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Sun, 21 Oct 2018 21:59:57 +0200
Subject: [PATCH 0/1] bus: simplify getting .driver_data
Message-ID: <20181021195958.1412-1-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got tired of fixing this in Renesas drivers manually, so I took the big
hammer. Remove this cumbersome code pattern which got copy-pasted too much
already:

-	struct platform_device *pdev = to_platform_device(dev);
-	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);

A branch, tested by buildbot, can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata

I have been asked if it couldn't be done for dev_set_drvdata as well. I checked
it and did not find one occasion where it could be simplified like this. Not
much of a surprise because driver_data is usually set in probe() functions
which access struct platform_device in many other ways.

I am open for other comments, suggestions, too, of course.

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


Wolfram Sang (1):
  bus: brcmstb_gisb: simplify getting .driver_data

 drivers/bus/brcmstb_gisb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.19.0
