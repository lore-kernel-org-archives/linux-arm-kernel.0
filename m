From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Wed, 14 Nov 2018 13:59:40 +0100
Subject: [PATCH 14/16] staging: vchiq_arm: rework probe and init functions
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
Message-ID: <20181114125942.25163-15-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moves the allocation of a chardev region and class creation to the init
function of the driver since those functions are meant to be run on a
per driver basis, as opposed to the code run in the probe function which
is run in a per device basis.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 71 ++++++++++++-------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 383013a92939..a7dcced79980 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -166,7 +166,6 @@ static struct cdev    vchiq_cdev;
 static dev_t          vchiq_devid;
 static VCHIQ_STATE_T g_state;
 static struct class  *vchiq_class;
-static struct device *vchiq_dev;
 static DEFINE_SPINLOCK(msg_queue_spinlock);
 static struct platform_device *bcm2835_camera;
 
@@ -3552,34 +3551,19 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (err != 0)
 		goto failed_platform_init;
 
-	err = alloc_chrdev_region(&vchiq_devid, VCHIQ_MINOR, 1, DEVICE_NAME);
-	if (err != 0) {
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unable to allocate device number");
-		goto failed_platform_init;
-	}
 	cdev_init(&vchiq_cdev, &vchiq_fops);
 	vchiq_cdev.owner = THIS_MODULE;
 	err = cdev_add(&vchiq_cdev, vchiq_devid, 1);
 	if (err != 0) {
 		vchiq_log_error(vchiq_arm_log_level,
 			"Unable to register device");
-		goto failed_cdev_add;
+		goto failed_platform_init;
 	}
 
-	/* create sysfs entries */
-	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
-	err = PTR_ERR(vchiq_class);
-	if (IS_ERR(vchiq_class))
-		goto failed_class_create;
-
-	vchiq_dev = device_create(vchiq_class, NULL,
-		vchiq_devid, NULL, "vchiq");
-	err = PTR_ERR(vchiq_dev);
-	if (IS_ERR(vchiq_dev))
+	if (IS_ERR(device_create(vchiq_class, &pdev->dev, vchiq_devid,
+				 NULL, "vchiq")))
 		goto failed_device_create;
 
-	/* create debugfs entries */
 	vchiq_debugfs_init();
 
 	vchiq_log_info(vchiq_arm_log_level,
@@ -3594,11 +3578,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	return 0;
 
 failed_device_create:
-	class_destroy(vchiq_class);
-failed_class_create:
 	cdev_del(&vchiq_cdev);
-failed_cdev_add:
-	unregister_chrdev_region(vchiq_devid, 1);
 failed_platform_init:
 	vchiq_log_warning(vchiq_arm_log_level, "could not load vchiq");
 	return err;
@@ -3609,9 +3589,7 @@ static int vchiq_remove(struct platform_device *pdev)
 	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	device_destroy(vchiq_class, vchiq_devid);
-	class_destroy(vchiq_class);
 	cdev_del(&vchiq_cdev);
-	unregister_chrdev_region(vchiq_devid, 1);
 
 	return 0;
 }
@@ -3624,7 +3602,48 @@ static struct platform_driver vchiq_driver = {
 	.probe = vchiq_probe,
 	.remove = vchiq_remove,
 };
-module_platform_driver(vchiq_driver);
+
+static int __init vchiq_driver_init(void)
+{
+	int ret;
+
+	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
+	if (IS_ERR(vchiq_class)) {
+		pr_err("Failed to create vchiq class\n");
+		return PTR_ERR(vchiq_class);
+	}
+
+	ret = alloc_chrdev_region(&vchiq_devid, VCHIQ_MINOR, 1, DEVICE_NAME);
+	if (ret) {
+		pr_err("Failed to allocate vchiq's chrdev region\n");
+		goto class_destroy;
+	}
+
+	ret = platform_driver_register(&vchiq_driver);
+	if (ret) {
+		pr_err("Failed to register vchiq driver\n");
+		goto region_unregister;
+	}
+
+	return 0;
+
+region_unregister:
+	platform_driver_unregister(&vchiq_driver);
+
+class_destroy:
+	class_destroy(vchiq_class);
+
+	return ret;
+}
+module_init(vchiq_driver_init);
+
+static void __exit vchiq_driver_exit(void)
+{
+	platform_driver_unregister(&vchiq_driver);
+	unregister_chrdev_region(vchiq_devid, 1);
+	class_destroy(vchiq_class);
+}
+module_exit(vchiq_driver_exit);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Videocore VCHIQ driver");
-- 
2.19.1
