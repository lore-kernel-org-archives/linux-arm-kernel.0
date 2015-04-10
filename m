From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 00:14:21 +0200
Subject: [PATCH] usb: gadget: remove incorrect __init/__exit annotations
Message-ID: <2143783.rOzqCdMWuk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change introduced a link error for the composite
printer gadget driver:

`printer_unbind' referenced in section `.ref.data' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o

Evidently the unbind function should not be marked __exit here,
because it is called through a callback pointer that is not necessarily
discarded, __composite_unbind() is indeed called from the error path of
composite_bind(), which can never work for a built-in driver.

Looking at the surrounding code, I found the same problem in all other
composite gadget drivers in both the bind and unbind functions, as
well as the udc platform driver 'remove' functions. Those will break
if anyone uses the 'unbind' sysfs attribute to detach a device from a
built-in driver.

This patch removes the incorrect annotations from all the gadget
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

I find it hard to believe that a bug like this has gone unnoticed for
over 10 years (I did not check the pre-git history), but I also can't
see any flaw in my logic here.

I did not actually run into this bug in a real system and only found
it by inspection, so please let me know if I was just wrong here and
the code actually works ok.

 drivers/usb/gadget/legacy/acm_ms.c         | 10 +++++-----
 drivers/usb/gadget/legacy/audio.c          | 10 +++++-----
 drivers/usb/gadget/legacy/cdc2.c           | 10 +++++-----
 drivers/usb/gadget/legacy/dbgp.c           |  4 ++--
 drivers/usb/gadget/legacy/ether.c          | 12 ++++++------
 drivers/usb/gadget/legacy/g_ffs.c          |  2 +-
 drivers/usb/gadget/legacy/gmidi.c          | 10 +++++-----
 drivers/usb/gadget/legacy/hid.c            | 12 ++++++------
 drivers/usb/gadget/legacy/mass_storage.c   |  6 +++---
 drivers/usb/gadget/legacy/multi.c          | 10 +++++-----
 drivers/usb/gadget/legacy/ncm.c            | 10 +++++-----
 drivers/usb/gadget/legacy/nokia.c          | 10 +++++-----
 drivers/usb/gadget/legacy/printer.c        |  8 ++++----
 drivers/usb/gadget/legacy/serial.c         |  4 ++--
 drivers/usb/gadget/legacy/tcm_usb_gadget.c |  2 +-
 drivers/usb/gadget/legacy/webcam.c         |  8 ++++----
 drivers/usb/gadget/legacy/zero.c           |  4 ++--
 drivers/usb/gadget/udc/at91_udc.c          |  4 ++--
 drivers/usb/gadget/udc/atmel_usba_udc.c    |  4 ++--
 drivers/usb/gadget/udc/fsl_udc_core.c      |  4 ++--
 drivers/usb/gadget/udc/fusb300_udc.c       |  4 ++--
 drivers/usb/gadget/udc/m66592-udc.c        |  4 ++--
 drivers/usb/gadget/udc/r8a66597-udc.c      |  4 ++--
 23 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/usb/gadget/legacy/acm_ms.c b/drivers/usb/gadget/legacy/acm_ms.c
index c30b7b572465..1194b09ae746 100644
--- a/drivers/usb/gadget/legacy/acm_ms.c
+++ b/drivers/usb/gadget/legacy/acm_ms.c
@@ -121,7 +121,7 @@ static struct usb_function *f_msg;
 /*
  * We _always_ have both ACM and mass storage functions.
  */
-static int __init acm_ms_do_config(struct usb_configuration *c)
+static int acm_ms_do_config(struct usb_configuration *c)
 {
 	struct fsg_opts *opts;
 	int	status;
@@ -174,7 +174,7 @@ static struct usb_configuration acm_ms_config_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init acm_ms_bind(struct usb_composite_dev *cdev)
+static int acm_ms_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
 	struct fsg_opts		*opts;
@@ -249,7 +249,7 @@ fail_get_msg:
 	return status;
 }
 
-static int __exit acm_ms_unbind(struct usb_composite_dev *cdev)
+static int acm_ms_unbind(struct usb_composite_dev *cdev)
 {
 	usb_put_function(f_msg);
 	usb_put_function_instance(fi_msg);
@@ -258,13 +258,13 @@ static int __exit acm_ms_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver acm_ms_driver = {
+static struct usb_composite_driver acm_ms_driver = {
 	.name		= "g_acm_ms",
 	.dev		= &device_desc,
 	.max_speed	= USB_SPEED_SUPER,
 	.strings	= dev_strings,
 	.bind		= acm_ms_bind,
-	.unbind		= __exit_p(acm_ms_unbind),
+	.unbind		= acm_ms_unbind,
 };
 
 module_usb_composite_driver(acm_ms_driver);
diff --git a/drivers/usb/gadget/legacy/audio.c b/drivers/usb/gadget/legacy/audio.c
index f46a3956e43d..f289caf18a45 100644
--- a/drivers/usb/gadget/legacy/audio.c
+++ b/drivers/usb/gadget/legacy/audio.c
@@ -167,7 +167,7 @@ static const struct usb_descriptor_header *otg_desc[] = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init audio_do_config(struct usb_configuration *c)
+static int audio_do_config(struct usb_configuration *c)
 {
 	int status;
 
@@ -216,7 +216,7 @@ static struct usb_configuration audio_config_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init audio_bind(struct usb_composite_dev *cdev)
+static int audio_bind(struct usb_composite_dev *cdev)
 {
 #ifndef CONFIG_GADGET_UAC1
 	struct f_uac2_opts	*uac2_opts;
@@ -276,7 +276,7 @@ fail:
 	return status;
 }
 
-static int __exit audio_unbind(struct usb_composite_dev *cdev)
+static int audio_unbind(struct usb_composite_dev *cdev)
 {
 #ifdef CONFIG_GADGET_UAC1
 	if (!IS_ERR_OR_NULL(f_uac1))
@@ -292,13 +292,13 @@ static int __exit audio_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver audio_driver = {
+static struct usb_composite_driver audio_driver = {
 	.name		= "g_audio",
 	.dev		= &device_desc,
 	.strings	= audio_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= audio_bind,
-	.unbind		= __exit_p(audio_unbind),
+	.unbind		= audio_unbind,
 };
 
 module_usb_composite_driver(audio_driver);
diff --git a/drivers/usb/gadget/legacy/cdc2.c b/drivers/usb/gadget/legacy/cdc2.c
index 2e85d9473478..afd3e37921a7 100644
--- a/drivers/usb/gadget/legacy/cdc2.c
+++ b/drivers/usb/gadget/legacy/cdc2.c
@@ -104,7 +104,7 @@ static struct usb_function_instance *fi_ecm;
 /*
  * We _always_ have both CDC ECM and CDC ACM functions.
  */
-static int __init cdc_do_config(struct usb_configuration *c)
+static int cdc_do_config(struct usb_configuration *c)
 {
 	int	status;
 
@@ -153,7 +153,7 @@ static struct usb_configuration cdc_config_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init cdc_bind(struct usb_composite_dev *cdev)
+static int cdc_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
 	struct f_ecm_opts	*ecm_opts;
@@ -211,7 +211,7 @@ fail:
 	return status;
 }
 
-static int __exit cdc_unbind(struct usb_composite_dev *cdev)
+static int cdc_unbind(struct usb_composite_dev *cdev)
 {
 	usb_put_function(f_acm);
 	usb_put_function_instance(fi_serial);
@@ -222,13 +222,13 @@ static int __exit cdc_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver cdc_driver = {
+static struct usb_composite_driver cdc_driver = {
 	.name		= "g_cdc",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= cdc_bind,
-	.unbind		= __exit_p(cdc_unbind),
+	.unbind		= cdc_unbind,
 };
 
 module_usb_composite_driver(cdc_driver);
diff --git a/drivers/usb/gadget/legacy/dbgp.c b/drivers/usb/gadget/legacy/dbgp.c
index 633683a72a11..204b10b1a7e7 100644
--- a/drivers/usb/gadget/legacy/dbgp.c
+++ b/drivers/usb/gadget/legacy/dbgp.c
@@ -284,7 +284,7 @@ fail_1:
 	return -ENODEV;
 }
 
-static int __init dbgp_bind(struct usb_gadget *gadget,
+static int dbgp_bind(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
 {
 	int err, stp;
@@ -406,7 +406,7 @@ fail:
 	return err;
 }
 
-static __refdata struct usb_gadget_driver dbgp_driver = {
+static struct usb_gadget_driver dbgp_driver = {
 	.function = "dbgp",
 	.max_speed = USB_SPEED_HIGH,
 	.bind = dbgp_bind,
diff --git a/drivers/usb/gadget/legacy/ether.c b/drivers/usb/gadget/legacy/ether.c
index c5fdc61cdc4a..a3323dca218f 100644
--- a/drivers/usb/gadget/legacy/ether.c
+++ b/drivers/usb/gadget/legacy/ether.c
@@ -222,7 +222,7 @@ static struct usb_function *f_rndis;
  * the first one present.  That's to make Microsoft's drivers happy,
  * and to follow DOCSIS 1.0 (cable modem standard).
  */
-static int __init rndis_do_config(struct usb_configuration *c)
+static int rndis_do_config(struct usb_configuration *c)
 {
 	int status;
 
@@ -264,7 +264,7 @@ MODULE_PARM_DESC(use_eem, "use CDC EEM mode");
 /*
  * We _always_ have an ECM, CDC Subset, or EEM configuration.
  */
-static int __init eth_do_config(struct usb_configuration *c)
+static int eth_do_config(struct usb_configuration *c)
 {
 	int status = 0;
 
@@ -318,7 +318,7 @@ static struct usb_configuration eth_config_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init eth_bind(struct usb_composite_dev *cdev)
+static int eth_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
 	struct f_eem_opts	*eem_opts = NULL;
@@ -447,7 +447,7 @@ fail:
 	return status;
 }
 
-static int __exit eth_unbind(struct usb_composite_dev *cdev)
+static int eth_unbind(struct usb_composite_dev *cdev)
 {
 	if (has_rndis()) {
 		usb_put_function(f_rndis);
@@ -466,13 +466,13 @@ static int __exit eth_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver eth_driver = {
+static struct usb_composite_driver eth_driver = {
 	.name		= "g_ether",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_SUPER,
 	.bind		= eth_bind,
-	.unbind		= __exit_p(eth_unbind),
+	.unbind		= eth_unbind,
 };
 
 module_usb_composite_driver(eth_driver);
diff --git a/drivers/usb/gadget/legacy/g_ffs.c b/drivers/usb/gadget/legacy/g_ffs.c
index b01b88e1b716..7b9ef7e257d2 100644
--- a/drivers/usb/gadget/legacy/g_ffs.c
+++ b/drivers/usb/gadget/legacy/g_ffs.c
@@ -163,7 +163,7 @@ static int gfs_unbind(struct usb_composite_dev *cdev);
 static int gfs_do_config(struct usb_configuration *c);
 
 
-static __refdata struct usb_composite_driver gfs_driver = {
+static struct usb_composite_driver gfs_driver = {
 	.name		= DRIVER_NAME,
 	.dev		= &gfs_dev_desc,
 	.strings	= gfs_dev_strings,
diff --git a/drivers/usb/gadget/legacy/gmidi.c b/drivers/usb/gadget/legacy/gmidi.c
index e02a095294ac..da19c486b61e 100644
--- a/drivers/usb/gadget/legacy/gmidi.c
+++ b/drivers/usb/gadget/legacy/gmidi.c
@@ -118,7 +118,7 @@ static struct usb_gadget_strings *dev_strings[] = {
 static struct usb_function_instance *fi_midi;
 static struct usb_function *f_midi;
 
-static int __exit midi_unbind(struct usb_composite_dev *dev)
+static int midi_unbind(struct usb_composite_dev *dev)
 {
 	usb_put_function(f_midi);
 	usb_put_function_instance(fi_midi);
@@ -133,7 +133,7 @@ static struct usb_configuration midi_config = {
 	.MaxPower	= CONFIG_USB_GADGET_VBUS_DRAW,
 };
 
-static int __init midi_bind_config(struct usb_configuration *c)
+static int midi_bind_config(struct usb_configuration *c)
 {
 	int status;
 
@@ -150,7 +150,7 @@ static int __init midi_bind_config(struct usb_configuration *c)
 	return 0;
 }
 
-static int __init midi_bind(struct usb_composite_dev *cdev)
+static int midi_bind(struct usb_composite_dev *cdev)
 {
 	struct f_midi_opts *midi_opts;
 	int status;
@@ -185,13 +185,13 @@ put:
 	return status;
 }
 
-static __refdata struct usb_composite_driver midi_driver = {
+static struct usb_composite_driver midi_driver = {
 	.name		= (char *) longname,
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= midi_bind,
-	.unbind		= __exit_p(midi_unbind),
+	.unbind		= midi_unbind,
 };
 
 module_usb_composite_driver(midi_driver);
diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
index 614b06d80b41..2baa572686c6 100644
--- a/drivers/usb/gadget/legacy/hid.c
+++ b/drivers/usb/gadget/legacy/hid.c
@@ -106,7 +106,7 @@ static struct usb_gadget_strings *dev_strings[] = {
 
 /****************************** Configurations ******************************/
 
-static int __init do_config(struct usb_configuration *c)
+static int do_config(struct usb_configuration *c)
 {
 	struct hidg_func_node *e, *n;
 	int status = 0;
@@ -147,7 +147,7 @@ static struct usb_configuration config_driver = {
 
 /****************************** Gadget Bind ******************************/
 
-static int __init hid_bind(struct usb_composite_dev *cdev)
+static int hid_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget *gadget = cdev->gadget;
 	struct list_head *tmp;
@@ -205,7 +205,7 @@ put:
 	return status;
 }
 
-static int __exit hid_unbind(struct usb_composite_dev *cdev)
+static int hid_unbind(struct usb_composite_dev *cdev)
 {
 	struct hidg_func_node *n;
 
@@ -216,7 +216,7 @@ static int __exit hid_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static int __init hidg_plat_driver_probe(struct platform_device *pdev)
+static int hidg_plat_driver_probe(struct platform_device *pdev)
 {
 	struct hidg_func_descriptor *func = dev_get_platdata(&pdev->dev);
 	struct hidg_func_node *entry;
@@ -252,13 +252,13 @@ static int hidg_plat_driver_remove(struct platform_device *pdev)
 /****************************** Some noise ******************************/
 
 
-static __refdata struct usb_composite_driver hidg_driver = {
+static struct usb_composite_driver hidg_driver = {
 	.name		= "g_hid",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= hid_bind,
-	.unbind		= __exit_p(hid_unbind),
+	.unbind		= hid_unbind,
 };
 
 static struct platform_driver hidg_plat_driver = {
diff --git a/drivers/usb/gadget/legacy/mass_storage.c b/drivers/usb/gadget/legacy/mass_storage.c
index 8e27a8c96444..e7bfb081f111 100644
--- a/drivers/usb/gadget/legacy/mass_storage.c
+++ b/drivers/usb/gadget/legacy/mass_storage.c
@@ -130,7 +130,7 @@ static int msg_thread_exits(struct fsg_common *common)
 	return 0;
 }
 
-static int __init msg_do_config(struct usb_configuration *c)
+static int msg_do_config(struct usb_configuration *c)
 {
 	struct fsg_opts *opts;
 	int ret;
@@ -170,7 +170,7 @@ static struct usb_configuration msg_config_driver = {
 
 /****************************** Gadget Bind ******************************/
 
-static int __init msg_bind(struct usb_composite_dev *cdev)
+static int msg_bind(struct usb_composite_dev *cdev)
 {
 	static const struct fsg_operations ops = {
 		.thread_exits = msg_thread_exits,
@@ -248,7 +248,7 @@ static int msg_unbind(struct usb_composite_dev *cdev)
 
 /****************************** Some noise ******************************/
 
-static __refdata struct usb_composite_driver msg_driver = {
+static struct usb_composite_driver msg_driver = {
 	.name		= "g_mass_storage",
 	.dev		= &msg_device_desc,
 	.max_speed	= USB_SPEED_SUPER,
diff --git a/drivers/usb/gadget/legacy/multi.c b/drivers/usb/gadget/legacy/multi.c
index 39d27bb343b4..b21b51f0c9fa 100644
--- a/drivers/usb/gadget/legacy/multi.c
+++ b/drivers/usb/gadget/legacy/multi.c
@@ -149,7 +149,7 @@ static struct usb_function *f_acm_rndis;
 static struct usb_function *f_rndis;
 static struct usb_function *f_msg_rndis;
 
-static __init int rndis_do_config(struct usb_configuration *c)
+static int rndis_do_config(struct usb_configuration *c)
 {
 	struct fsg_opts *fsg_opts;
 	int ret;
@@ -237,7 +237,7 @@ static struct usb_function *f_acm_multi;
 static struct usb_function *f_ecm;
 static struct usb_function *f_msg_multi;
 
-static __init int cdc_do_config(struct usb_configuration *c)
+static int cdc_do_config(struct usb_configuration *c)
 {
 	struct fsg_opts *fsg_opts;
 	int ret;
@@ -466,7 +466,7 @@ fail:
 	return status;
 }
 
-static int __exit multi_unbind(struct usb_composite_dev *cdev)
+static int multi_unbind(struct usb_composite_dev *cdev)
 {
 #ifdef CONFIG_USB_G_MULTI_CDC
 	usb_put_function(f_msg_multi);
@@ -497,13 +497,13 @@ static int __exit multi_unbind(struct usb_composite_dev *cdev)
 /****************************** Some noise ******************************/
 
 
-static __refdata struct usb_composite_driver multi_driver = {
+static struct usb_composite_driver multi_driver = {
 	.name		= "g_multi",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= multi_bind,
-	.unbind		= __exit_p(multi_unbind),
+	.unbind		= multi_unbind,
 	.needs_serial	= 1,
 };
 
diff --git a/drivers/usb/gadget/legacy/ncm.c b/drivers/usb/gadget/legacy/ncm.c
index e90e23db2acb..6ce7421412e9 100644
--- a/drivers/usb/gadget/legacy/ncm.c
+++ b/drivers/usb/gadget/legacy/ncm.c
@@ -107,7 +107,7 @@ static struct usb_function *f_ncm;
 
 /*-------------------------------------------------------------------------*/
 
-static int __init ncm_do_config(struct usb_configuration *c)
+static int ncm_do_config(struct usb_configuration *c)
 {
 	int status;
 
@@ -143,7 +143,7 @@ static struct usb_configuration ncm_config_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __init gncm_bind(struct usb_composite_dev *cdev)
+static int gncm_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
 	struct f_ncm_opts	*ncm_opts;
@@ -186,7 +186,7 @@ fail:
 	return status;
 }
 
-static int __exit gncm_unbind(struct usb_composite_dev *cdev)
+static int gncm_unbind(struct usb_composite_dev *cdev)
 {
 	if (!IS_ERR_OR_NULL(f_ncm))
 		usb_put_function(f_ncm);
@@ -195,13 +195,13 @@ static int __exit gncm_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver ncm_driver = {
+static struct usb_composite_driver ncm_driver = {
 	.name		= "g_ncm",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= gncm_bind,
-	.unbind		= __exit_p(gncm_unbind),
+	.unbind		= gncm_unbind,
 };
 
 module_usb_composite_driver(ncm_driver);
diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/legacy/nokia.c
index 9b8fd701648c..4bb498a38a1c 100644
--- a/drivers/usb/gadget/legacy/nokia.c
+++ b/drivers/usb/gadget/legacy/nokia.c
@@ -118,7 +118,7 @@ static struct usb_function_instance *fi_obex1;
 static struct usb_function_instance *fi_obex2;
 static struct usb_function_instance *fi_phonet;
 
-static int __init nokia_bind_config(struct usb_configuration *c)
+static int nokia_bind_config(struct usb_configuration *c)
 {
 	struct usb_function *f_acm;
 	struct usb_function *f_phonet = NULL;
@@ -224,7 +224,7 @@ err_get_acm:
 	return status;
 }
 
-static int __init nokia_bind(struct usb_composite_dev *cdev)
+static int nokia_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
 	int			status;
@@ -307,7 +307,7 @@ err_usb:
 	return status;
 }
 
-static int __exit nokia_unbind(struct usb_composite_dev *cdev)
+static int nokia_unbind(struct usb_composite_dev *cdev)
 {
 	if (!IS_ERR_OR_NULL(f_obex1_cfg2))
 		usb_put_function(f_obex1_cfg2);
@@ -338,13 +338,13 @@ static int __exit nokia_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver nokia_driver = {
+static struct usb_composite_driver nokia_driver = {
 	.name		= "g_nokia",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
 	.max_speed	= USB_SPEED_HIGH,
 	.bind		= nokia_bind,
-	.unbind		= __exit_p(nokia_unbind),
+	.unbind		= nokia_unbind,
 };
 
 module_usb_composite_driver(nokia_driver);
diff --git a/drivers/usb/gadget/legacy/printer.c b/drivers/usb/gadget/legacy/printer.c
index d5b6ee725a2a..1ce7df1060a5 100644
--- a/drivers/usb/gadget/legacy/printer.c
+++ b/drivers/usb/gadget/legacy/printer.c
@@ -126,7 +126,7 @@ static struct usb_configuration printer_cfg_driver = {
 	.bmAttributes		= USB_CONFIG_ATT_ONE | USB_CONFIG_ATT_SELFPOWER,
 };
 
-static int __init printer_do_config(struct usb_configuration *c)
+static int printer_do_config(struct usb_configuration *c)
 {
 	struct usb_gadget	*gadget = c->cdev->gadget;
 	int			status = 0;
@@ -152,7 +152,7 @@ static int __init printer_do_config(struct usb_configuration *c)
 	return status;
 }
 
-static int __init printer_bind(struct usb_composite_dev *cdev)
+static int printer_bind(struct usb_composite_dev *cdev)
 {
 	struct f_printer_opts *opts;
 	int ret, len;
@@ -191,7 +191,7 @@ static int __init printer_bind(struct usb_composite_dev *cdev)
 	return ret;
 }
 
-static int __exit printer_unbind(struct usb_composite_dev *cdev)
+static int printer_unbind(struct usb_composite_dev *cdev)
 {
 	usb_put_function(f_printer);
 	usb_put_function_instance(fi_printer);
@@ -199,7 +199,7 @@ static int __exit printer_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver printer_driver = {
+static struct usb_composite_driver printer_driver = {
 	.name           = shortname,
 	.dev            = &device_desc,
 	.strings        = dev_strings,
diff --git a/drivers/usb/gadget/legacy/serial.c b/drivers/usb/gadget/legacy/serial.c
index 1f5f978d35d5..8b7528f9b78e 100644
--- a/drivers/usb/gadget/legacy/serial.c
+++ b/drivers/usb/gadget/legacy/serial.c
@@ -174,7 +174,7 @@ out:
 	return ret;
 }
 
-static int __init gs_bind(struct usb_composite_dev *cdev)
+static int gs_bind(struct usb_composite_dev *cdev)
 {
 	int			status;
 
@@ -230,7 +230,7 @@ static int gs_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver gserial_driver = {
+static struct usb_composite_driver gserial_driver = {
 	.name		= "g_serial",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
diff --git a/drivers/usb/gadget/legacy/tcm_usb_gadget.c b/drivers/usb/gadget/legacy/tcm_usb_gadget.c
index 8b80addc4ce6..f9b4882fce52 100644
--- a/drivers/usb/gadget/legacy/tcm_usb_gadget.c
+++ b/drivers/usb/gadget/legacy/tcm_usb_gadget.c
@@ -2397,7 +2397,7 @@ static int usb_target_bind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver usbg_driver = {
+static struct usb_composite_driver usbg_driver = {
 	.name           = "g_target",
 	.dev            = &usbg_device_desc,
 	.strings        = usbg_strings,
diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
index 04a3da20f742..72c976bf3530 100644
--- a/drivers/usb/gadget/legacy/webcam.c
+++ b/drivers/usb/gadget/legacy/webcam.c
@@ -334,7 +334,7 @@ static const struct uvc_descriptor_header * const uvc_ss_streaming_cls[] = {
  * USB configuration
  */
 
-static int __init
+static int
 webcam_config_bind(struct usb_configuration *c)
 {
 	int status = 0;
@@ -358,7 +358,7 @@ static struct usb_configuration webcam_config_driver = {
 	.MaxPower		= CONFIG_USB_GADGET_VBUS_DRAW,
 };
 
-static int /* __init_or_exit */
+static int
 webcam_unbind(struct usb_composite_dev *cdev)
 {
 	if (!IS_ERR_OR_NULL(f_uvc))
@@ -368,7 +368,7 @@ webcam_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static int __init
+static int
 webcam_bind(struct usb_composite_dev *cdev)
 {
 	struct f_uvc_opts *uvc_opts;
@@ -422,7 +422,7 @@ error:
  * Driver
  */
 
-static __refdata struct usb_composite_driver webcam_driver = {
+static struct usb_composite_driver webcam_driver = {
 	.name		= "g_webcam",
 	.dev		= &webcam_device_descriptor,
 	.strings	= webcam_device_strings,
diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index 5ee95152493c..c986e8addb90 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -272,7 +272,7 @@ static struct usb_function_instance *func_inst_lb;
 module_param_named(qlen, gzero_options.qlen, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(qlen, "depth of loopback queue");
 
-static int __init zero_bind(struct usb_composite_dev *cdev)
+static int zero_bind(struct usb_composite_dev *cdev)
 {
 	struct f_ss_opts	*ss_opts;
 	struct f_lb_opts	*lb_opts;
@@ -400,7 +400,7 @@ static int zero_unbind(struct usb_composite_dev *cdev)
 	return 0;
 }
 
-static __refdata struct usb_composite_driver zero_driver = {
+static struct usb_composite_driver zero_driver = {
 	.name		= "zero",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 2fbedca3c2b4..fc4226462f8f 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1942,7 +1942,7 @@ err_unprepare_fclk:
 	return retval;
 }
 
-static int __exit at91udc_remove(struct platform_device *pdev)
+static int at91udc_remove(struct platform_device *pdev)
 {
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
@@ -2018,7 +2018,7 @@ static int at91udc_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver at91_udc_driver = {
-	.remove		= __exit_p(at91udc_remove),
+	.remove		= at91udc_remove,
 	.shutdown	= at91udc_shutdown,
 	.suspend	= at91udc_suspend,
 	.resume		= at91udc_resume,
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 4c01953a0869..351d48550c33 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2186,7 +2186,7 @@ static int usba_udc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit usba_udc_remove(struct platform_device *pdev)
+static int usba_udc_remove(struct platform_device *pdev)
 {
 	struct usba_udc *udc;
 	int i;
@@ -2258,7 +2258,7 @@ static int usba_udc_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(usba_udc_pm_ops, usba_udc_suspend, usba_udc_resume);
 
 static struct platform_driver udc_driver = {
-	.remove		= __exit_p(usba_udc_remove),
+	.remove		= usba_udc_remove,
 	.driver		= {
 		.name		= "atmel_usba_udc",
 		.pm		= &usba_udc_pm_ops,
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 55fcb930f92e..c60022b46a48 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2525,7 +2525,7 @@ err_kfree:
 /* Driver removal function
  * Free resources and finish pending transactions
  */
-static int __exit fsl_udc_remove(struct platform_device *pdev)
+static int fsl_udc_remove(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -2663,7 +2663,7 @@ static const struct platform_device_id fsl_udc_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, fsl_udc_devtype);
 static struct platform_driver udc_driver = {
-	.remove		= __exit_p(fsl_udc_remove),
+	.remove		= fsl_udc_remove,
 	/* Just for FSL i.mx SoC currently */
 	.id_table	= fsl_udc_devtype,
 	/* these suspend and resume are not usb suspend and resume */
diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index fb4df159d32d..3970f453de49 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1342,7 +1342,7 @@ static const struct usb_gadget_ops fusb300_gadget_ops = {
 	.udc_stop	= fusb300_udc_stop,
 };
 
-static int __exit fusb300_remove(struct platform_device *pdev)
+static int fusb300_remove(struct platform_device *pdev)
 {
 	struct fusb300 *fusb300 = platform_get_drvdata(pdev);
 
@@ -1492,7 +1492,7 @@ clean_up:
 }
 
 static struct platform_driver fusb300_driver = {
-	.remove =	__exit_p(fusb300_remove),
+	.remove =	fusb300_remove,
 	.driver		= {
 		.name =	(char *) udc_name,
 	},
diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index 8c7c83c93713..309706fe4bf0 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1528,7 +1528,7 @@ static const struct usb_gadget_ops m66592_gadget_ops = {
 	.pullup			= m66592_pullup,
 };
 
-static int __exit m66592_remove(struct platform_device *pdev)
+static int m66592_remove(struct platform_device *pdev)
 {
 	struct m66592		*m66592 = platform_get_drvdata(pdev);
 
@@ -1695,7 +1695,7 @@ clean_up:
 
 /*-------------------------------------------------------------------------*/
 static struct platform_driver m66592_driver = {
-	.remove =	__exit_p(m66592_remove),
+	.remove =	m66592_remove,
 	.driver		= {
 		.name =	(char *) udc_name,
 	},
diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index 2495fe9c95c5..0293f7169dee 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1820,7 +1820,7 @@ static const struct usb_gadget_ops r8a66597_gadget_ops = {
 	.set_selfpowered	= r8a66597_set_selfpowered,
 };
 
-static int __exit r8a66597_remove(struct platform_device *pdev)
+static int r8a66597_remove(struct platform_device *pdev)
 {
 	struct r8a66597		*r8a66597 = platform_get_drvdata(pdev);
 
@@ -1974,7 +1974,7 @@ clean_up2:
 
 /*-------------------------------------------------------------------------*/
 static struct platform_driver r8a66597_driver = {
-	.remove =	__exit_p(r8a66597_remove),
+	.remove =	r8a66597_remove,
 	.driver		= {
 		.name =	(char *) udc_name,
 	},
