From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 04:01:39 +0800
Subject: [hisi:topic-lpc-4.10-libio 137/148] drivers/bus/hisi_lpc.c:597:10:
 error: implicit declaration of function 'acpi_set_libio_resource'
Message-ID: <201702070437.cmsCZBYi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: d00a25ce31fe04e883575c46eededb6f3531a6fe [137/148] libio: replace extio with libio
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout d00a25ce31fe04e883575c46eededb6f3531a6fe
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/bus/hisi_lpc.c: In function 'hisi_lpc_pio_to_addr':
   drivers/bus/hisi_lpc.c:257:28: error: dereferencing pointer to incomplete type 'struct libio_node'
     return pio - lpcdev->libio->io_start + lpcdev->libio->bus_start;
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
   drivers/bus/hisi_lpc.c:482:18: error: implicit declaration of function 'libio_find_node' [-Werror=implicit-function-declaration]
     lpcdev->libio = libio_find_node(dev->fwnode);
                     ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:482:16: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     lpcdev->libio = libio_find_node(dev->fwnode);
                   ^
   drivers/bus/hisi_lpc.c: In function 'hisilpc_bus_platform_notify':
   drivers/bus/hisi_lpc.c:584:2: error: implicit declaration of function 'register_libio' [-Werror=implicit-function-declaration]
     register_libio(io_node);
     ^~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:597:10: error: implicit declaration of function 'acpi_set_libio_resource' [-Werror=implicit-function-declaration]
       ret = acpi_set_libio_resource(child, root);
             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c: At top level:
   drivers/bus/hisi_lpc.c:439:25: error: storage size of 'hisi_lpc_ops' isn't known
    static struct libio_ops hisi_lpc_ops = {
                            ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/acpi_set_libio_resource +597 drivers/bus/hisi_lpc.c

   476		if (IS_ERR(lpcdev->membase)) {
   477			dev_err(dev, "remap failed\n");
   478			return PTR_ERR(lpcdev->membase);
   479		}
   480	
   481		/* get the linux virtual IO node registered before. */
 > 482		lpcdev->libio = libio_find_node(dev->fwnode);
   483		if (!lpcdev->libio) {
   484			dev_err(dev, "No libio node registered!\n");
   485			return -EFAULT;
   486		}
   487	
   488		lpcdev->libio->devpara = lpcdev;
   489		lpcdev->libio->ops = &hisi_lpc_ops;
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
   505				 lpcdev->libio->io_start,
   506				 lpcdev->libio->io_start + lpcdev->libio->range_size);
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
   545		struct libio_node *io_node;
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
   568		io_node = kzalloc(sizeof(*io_node), GFP_KERNEL);
   569		if (!io_node)
   570			return NOTIFY_DONE;
   571	
   572		io_node->bus_start = LPC_MIN_BUS_RANGE;
   573		io_node->range_size = LPC_BUS_IO_SIZE;
   574	
   575		ret = pci_register_io_range(dev->fwnode, IO_RANGE_IOEXT,
   576				io_node->range_size, &io_node->io_start);
   577		if (ret) {
   578			dev_err(dev, "register indirectIO range FAIL!\n");
   579			kfree(io_node);
   580			return NOTIFY_DONE;
   581		}
   582		io_node->fwnode = dev->fwnode;
   583		/* register the linux virtual IO range node to list. */
   584		register_libio(io_node);
   585	
   586		/*
   587		 * For ACPI children, translate the bus-local I/O range to logical
   588		 * I/O range and set it as the current resource before the children
   589		 * are enumerated.
   590		 */
   591		if (has_acpi_companion(dev)) {
   592			struct acpi_device *root, *child;
   593	
   594			root = to_acpi_device_node(dev->fwnode);
   595			/* For hisilpc, only care about the sons of host. */
   596			list_for_each_entry(child, &root->children, node) {
 > 597				ret = acpi_set_libio_resource(child, root);
   598				if (ret) {
   599					dev_err(dev, "set resource failed..\n");
   600					break;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57936 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/2cdc13e1/attachment-0001.gz>
