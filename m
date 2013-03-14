From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 22:56:38 +0100
Subject: [PATCH 1/3] mfd: remove __exit_p annotation for twl4030_madc_remove
Message-ID: <1363298204-8014-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4740f73fe5 "mfd: remove use of __devexit" removed the __devexit annotation
on the twl4030_madc_remove function, but left an __exit_p() present on the
pointer to this function. Using __exit_p was as wrong with the devexit in
place as it is now, but now we get a gcc warning about an unused function.

In order for the twl4030_madc_remove to work correctly in built-in code, we
have to remove the __exit_p.

Cc: Bill Pemberton <wfp5p@virginia.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Please apply to MFD tree for 3.9

 drivers/mfd/twl4030-madc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 88ff9dc..942b666 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -800,7 +800,7 @@ static int twl4030_madc_remove(struct platform_device *pdev)
 
 static struct platform_driver twl4030_madc_driver = {
 	.probe = twl4030_madc_probe,
-	.remove = __exit_p(twl4030_madc_remove),
+	.remove = twl4030_madc_remove,
 	.driver = {
 		   .name = "twl4030_madc",
 		   .owner = THIS_MODULE,
-- 
1.8.1.2
