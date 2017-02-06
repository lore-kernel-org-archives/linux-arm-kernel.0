From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 04:36:03 +0800
Subject: [hisi:topic-lpc-4.10-libio 143/148] drivers/bus/hisi_lpc.c:569:8:
 error: implicit declaration of function 'register_io_range_bus'
Message-ID: <201702070459.usqdH1lk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: af636c18ad0df46e7c7d498eb56306565a77272c [143/148] defined wrappers for register_io_range
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout af636c18ad0df46e7c7d498eb56306565a77272c
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/bus/hisi_lpc.c: In function 'hisi_lpc_pio_to_addr':
   drivers/bus/hisi_lpc.c:257:31: error: dereferencing pointer to incomplete type 'struct io_range'
     return pio - lpcdev->io_range->io_start + lpcdev->io_range->bus_start;
                                  ^~
   drivers/bus/hisi_lpc.c: At top level:
   drivers/bus/hisi_lpc.c:439:15: error: variable 'hisi_lpc_ops' has initializer but incomplete type
    static struct libio_ops hisi_lpc_ops = {
                  ^~~~~~~~~
   drivers/bus/hisi_lpc.c:440:2: error: unknown field 'pfin' specified in initializer
     .pfin = hisilpc_comm_in,
     ^
   drivers/bus/hisi_lpc.c:440:10: warning: excess elements in struct initializer
     .pfin = hisilpc_comm_in,
             ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:440:10: note: (near initialization for 'hisi_lpc_ops')
   drivers/bus/hisi_lpc.c:441:2: error: unknown field 'pfout' specified in initializer
     .pfout = hisilpc_comm_out,
     ^
   drivers/bus/hisi_lpc.c:441:11: warning: excess elements in struct initializer
     .pfout = hisilpc_comm_out,
              ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:441:11: note: (near initialization for 'hisi_lpc_ops')
   drivers/bus/hisi_lpc.c:442:2: error: unknown field 'pfins' specified in initializer
     .pfins = hisilpc_comm_ins,
     ^
   drivers/bus/hisi_lpc.c:442:11: warning: excess elements in struct initializer
     .pfins = hisilpc_comm_ins,
              ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:442:11: note: (near initialization for 'hisi_lpc_ops')
   drivers/bus/hisi_lpc.c:443:2: error: unknown field 'pfouts' specified in initializer
     .pfouts = hisilpc_comm_outs,
     ^
   drivers/bus/hisi_lpc.c:443:12: warning: excess elements in struct initializer
     .pfouts = hisilpc_comm_outs,
               ^~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:443:12: note: (near initialization for 'hisi_lpc_ops')
   drivers/bus/hisi_lpc.c: In function 'hisilpc_probe':
   drivers/bus/hisi_lpc.c:482:21: error: implicit declaration of function 'find_io_range_from_fwnode' [-Werror=implicit-function-declaration]
     lpcdev->io_range = find_io_range_from_fwnode(dev->fwnode);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:482:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     lpcdev->io_range = find_io_range_from_fwnode(dev->fwnode);
                      ^
   drivers/bus/hisi_lpc.c: In function 'hisilpc_bus_platform_notify':
>> drivers/bus/hisi_lpc.c:569:8: error: implicit declaration of function 'register_io_range_bus' [-Werror=implicit-function-declaration]
     ret = register_io_range_bus(dev->fwnode, LPC_MIN_BUS_RANGE,
           ^~~~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:577:11: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     io_range = find_io_range_from_fwnode(dev->fwnode);
              ^
   drivers/bus/hisi_lpc.c:592:10: error: implicit declaration of function 'acpi_set_libio_resource' [-Werror=implicit-function-declaration]
       ret = acpi_set_libio_resource(child, root);
             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c: At top level:
   drivers/bus/hisi_lpc.c:439:25: error: storage size of 'hisi_lpc_ops' isn't known
    static struct libio_ops hisi_lpc_ops = {
                            ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/register_io_range_bus +569 drivers/bus/hisi_lpc.c

   437	}
   438	
   439	static struct libio_ops hisi_lpc_ops = {
   440		.pfin = hisilpc_comm_in,
   441		.pfout = hisilpc_comm_out,
   442		.pfins = hisilpc_comm_ins,
 > 443		.pfouts = hisilpc_comm_outs,
   444	};
   445	
   446	/**
   447	 * hisilpc_probe - the probe callback function for hisi lpc device,
   448	 *		   will finish all the initialization.
   449	 * @pdev: the platform device corresponding to hisi lpc
   450	 *
   451	 * Returns 0 on success, non-zero on fail.
   452	 *
   453	 */
   454	static int hisilpc_probe(struct platform_device *pdev)
   455	{
   456		struct device *dev = &pdev->dev;
   457		struct resource *res;
   458		struct hisilpc_dev *lpcdev;
   459		int ret = 0;
   460	
   461		dev_info(dev, "probing...\n");
   462	
   463		lpcdev = devm_kzalloc(dev, sizeof(struct hisilpc_dev), GFP_KERNEL);
   464		if (!lpcdev)
   465			return -ENOMEM;
   466	
   467		spin_lock_init(&lpcdev->cycle_lock);
   468	
   469		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   470		if (!res) {
   471			dev_err(dev, "no MEM resource\n");
   472			return -ENODEV;
   473		}
   474	
   475		lpcdev->membase = devm_ioremap_resource(dev, res);
   476		if (IS_ERR(lpcdev->membase)) {
   477			dev_err(dev, "remap failed\n");
   478			return PTR_ERR(lpcdev->membase);
   479		}
   480	
   481		/* get the linux virtual IO node registered before. */
   482		lpcdev->io_range = find_io_range_from_fwnode(dev->fwnode);
   483		if (!lpcdev->io_range) {
   484			dev_err(dev, "No io range registered!\n");
   485			return -EFAULT;
   486		}
   487	
   488		lpcdev->io_range->devpara = lpcdev;
   489		lpcdev->io_range->ops = &hisi_lpc_ops;
   490	
   491		platform_set_drvdata(pdev, lpcdev);
   492	
   493		/*
   494		 * The children scanning is only for dts. For ACPI children, the
   495		 * corresponding devices had be created during ACPI scanning.
   496		 */
   497		if (!has_acpi_companion(dev)) {
   498			ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
   499			if (ret)
   500				dev_err(dev, "OF: enumerate LPC bus fail(%d)\n", ret);
   501		}
   502	
   503		if (!ret)
   504			dev_info(dev, "hslpc end probing. range[0x%lx - %lx]\n",
   505				 lpcdev->io_range->io_start,
   506				 lpcdev->io_range->io_start + lpcdev->io_range->size);
   507		else
   508			dev_info(dev, "hslpc probing is fail(%d)\n", ret);
   509	
   510		return ret;
   511	}
   512	
   513	static const struct of_device_id hisilpc_of_match[] = {
   514		{ .compatible = "hisilicon,hip06-lpc", },
   515		{ .compatible = "hisilicon,hip07-lpc", },
   516		{},
   517	};
   518	
   519	static const struct acpi_device_id hisilpc_acpi_match[] = {
   520		{"HISI0191", },
   521		{},
   522	};
   523	
   524	static struct platform_driver hisilpc_driver = {
   525		.driver = {
   526			.name           = "hisi_lpc",
   527			.of_match_table = hisilpc_of_match,
   528			.acpi_match_table = hisilpc_acpi_match,
   529		},
   530		.probe = hisilpc_probe,
   531	};
   532	
   533	
   534	builtin_platform_driver(hisilpc_driver);
   535	
   536	/*
   537	 * hisilpc_bus_platform_notify -- notify callback function specific for
   538	 *			hisi-lpc bus. Here, will register linux virtual
   539	 *			PIO for the bus detected, then the bus children
   540	 *			can translate their bus-local IO to linux PIO.
   541	 */
   542	static int hisilpc_bus_platform_notify(struct notifier_block *nb,
   543				unsigned long action, void *data)
   544	{
   545		struct io_range *io_range;
   546		struct device *dev = data;
   547		int ret;
   548	
   549		if (!is_of_node(dev->fwnode) && !is_acpi_node(dev->fwnode))
   550			return NOTIFY_DONE;
   551	
   552		if (action != BUS_NOTIFY_ADD_DEVICE)
   553			return NOTIFY_DONE;
   554	
   555		/* whether the device notified is hisi-lpc? */
   556		if (has_acpi_companion(dev)) {
   557			if (!acpi_match_device(hisilpc_acpi_match, dev))
   558				return NOTIFY_DONE;
   559		} else {
   560			if (!of_match_node(hisilpc_of_match, dev->of_node))
   561				return NOTIFY_DONE;
   562		}
   563	
   564		/*
   565		 * indirectIO bus was detected, time to request the linux virtual
   566		 * IO.
   567		 */
   568	
 > 569		ret = register_io_range_bus(dev->fwnode, LPC_MIN_BUS_RANGE,
   570				LPC_BUS_IO_SIZE);
   571		if (ret) {
   572			dev_err(dev, "register indirectIO range FAIL!\n");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57936 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/7a263f5d/attachment-0001.gz>
