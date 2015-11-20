From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 22:59:14 +0100
Subject: [PATCH] staging: ste_rmi4: avoid unused function warnings
Message-ID: <4938658.kvPtQAFlP6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rmi4 touchscreen driver encloses the power-management
functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
functions are only really used when CONFIG_PM_SLEEP is also
set, as a frequent gcc warning shows:

ste_rmi4/synaptics_i2c_rmi4.c:1050:12: warning: 'synaptics_rmi4_suspend' defined but not used
ste_rmi4/synaptics_i2c_rmi4.c:1084:12: warning: 'synaptics_rmi4_resume' defined but not used

This changes the driver to remove the #ifdef and instead mark
the functions as __maybe_unused, which is a nicer anyway, as it
provides build testing for all the code in all configurations
and is harder to get wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
index 824d460911ec..58ccafb97344 100644
--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -1039,7 +1039,6 @@ static int synaptics_rmi4_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 /**
  * synaptics_rmi4_suspend() - suspend the touch screen controller
  * @dev: pointer to device structure
@@ -1047,7 +1046,7 @@ static int synaptics_rmi4_remove(struct i2c_client *client)
  * This function is used to suspend the
  * touch panel controller and returns integer
  */
-static int synaptics_rmi4_suspend(struct device *dev)
+static int __maybe_unused synaptics_rmi4_suspend(struct device *dev)
 {
 	/* Touch sleep mode */
 	int retval;
@@ -1081,7 +1080,7 @@ static int synaptics_rmi4_suspend(struct device *dev)
  * This function is used to resume the touch panel
  * controller and returns integer.
  */
-static int synaptics_rmi4_resume(struct device *dev)
+static int __maybe_unused synaptics_rmi4_resume(struct device *dev)
 {
 	int retval;
 	unsigned char intr_status;
@@ -1112,8 +1111,6 @@ static int synaptics_rmi4_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-
 static SIMPLE_DEV_PM_OPS(synaptics_rmi4_dev_pm_ops, synaptics_rmi4_suspend,
 			 synaptics_rmi4_resume);
 
