From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 11 Feb 2018 23:47:50 +0800
Subject: [arm-platforms:hack/kevin 13/19] drivers/mfd/cros_ec.c:152:2: error:
 implicit declaration of function 'cros_ec_check_features'
Message-ID: <201802112349.jdL7Yw4f%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git hack/kevin
head:   1b72d390ddf16ef46ff8a182db6a9ca869f2d28c
commit: afef7b6c71990b94b58f78dd12a0cdfa4bfe2a82 [13/19] mfd: cros_ec: add RTC as mfd subdevice
config: i386-randconfig-a1-201806 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout afef7b6c71990b94b58f78dd12a0cdfa4bfe2a82
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the arm-platforms/hack/kevin HEAD 1b72d390ddf16ef46ff8a182db6a9ca869f2d28c builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/mfd/cros_ec.c: In function 'cros_ec_register':
>> drivers/mfd/cros_ec.c:152:2: error: implicit declaration of function 'cros_ec_check_features' [-Werror=implicit-function-declaration]
     if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
     ^
   cc1: some warnings being treated as errors

vim +/cros_ec_check_features +152 drivers/mfd/cros_ec.c

   107	
   108	int cros_ec_register(struct cros_ec_device *ec_dev)
   109	{
   110		struct device *dev = ec_dev->dev;
   111		int err = 0;
   112	
   113		BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
   114	
   115		ec_dev->max_request = sizeof(struct ec_params_hello);
   116		ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
   117		ec_dev->max_passthru = 0;
   118	
   119		ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
   120		if (!ec_dev->din)
   121			return -ENOMEM;
   122	
   123		ec_dev->dout = devm_kzalloc(dev, ec_dev->dout_size, GFP_KERNEL);
   124		if (!ec_dev->dout)
   125			return -ENOMEM;
   126	
   127		mutex_init(&ec_dev->lock);
   128	
   129		cros_ec_query_all(ec_dev);
   130	
   131		if (ec_dev->irq) {
   132			err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
   133						   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
   134						   "chromeos-ec", ec_dev);
   135			if (err) {
   136				dev_err(dev, "Failed to request IRQ %d: %d",
   137					ec_dev->irq, err);
   138				return err;
   139			}
   140		}
   141	
   142		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell, 1,
   143				      NULL, ec_dev->irq, NULL);
   144		if (err) {
   145			dev_err(dev,
   146				"Failed to register Embedded Controller subdevice %d\n",
   147				err);
   148			goto fail_mfd;
   149		}
   150	
   151		/* Check whether this EC has RTC support */
 > 152		if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
   153			cros_ec_rtc_register(ec_dev);
   154	
   155		if (ec_dev->max_passthru) {
   156			/*
   157			 * Register a PD device as well on top of this device.
   158			 * We make the following assumptions:
   159			 * - behind an EC, we have a pd
   160			 * - only one device added.
   161			 * - the EC is responsive at init time (it is not true for a
   162			 *   sensor hub.
   163			 */
   164			err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
   165					      &ec_pd_cell, 1, NULL, ec_dev->irq, NULL);
   166			if (err) {
   167				dev_err(dev,
   168					"Failed to register Power Delivery subdevice %d\n",
   169					err);
   170				goto fail_mfd;
   171			}
   172		}
   173	
   174		if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
   175			err = devm_of_platform_populate(dev);
   176			if (err) {
   177				mfd_remove_devices(dev);
   178				dev_err(dev, "Failed to register sub-devices\n");
   179				goto fail_mfd;
   180			}
   181		}
   182	
   183		/*
   184		 * Clear sleep event - this will fail harmlessly on platforms that
   185		 * don't implement the sleep event host command.
   186		 */
   187		err = cros_ec_sleep_event(ec_dev, 0);
   188		if (err < 0)
   189			dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
   190				err);
   191	
   192		dev_info(dev, "Chrome EC device registered\n");
   193	
   194		cros_ec_acpi_install_gpe_handler(dev);
   195	
   196		return 0;
   197	
   198	fail_mfd:
   199		if (ec_dev->irq)
   200			free_irq(ec_dev->irq, ec_dev);
   201		return err;
   202	}
   203	EXPORT_SYMBOL(cros_ec_register);
   204	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24043 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180211/2fed673a/attachment-0001.gz>
