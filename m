From: lkp@intel.com (kbuild test robot)
Date: Wed, 8 Jun 2016 01:35:37 +0800
Subject: [PATCH v5 01/18] remoteproc: make rsc table support optional
In-Reply-To: <1465316352-20691-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <201606080126.eqsX0kUy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.7-rc2 next-20160607]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160608-002710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/remoteproc/remoteproc_core.c: In function '__rproc_boot':
>> drivers/remoteproc/remoteproc_core.c:887:20: warning: 'loaded_table' may be used uninitialized in this function [-Wmaybe-uninitialized]
      rproc->table_ptr = loaded_table;
      ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   drivers/remoteproc/remoteproc_core.c:803:33: note: 'loaded_table' was declared here
     struct resource_table *table, *loaded_table;
                                    ^~~~~~~~~~~~
   drivers/remoteproc/remoteproc_core.c: In function 'rproc_trigger_recovery':
>> drivers/remoteproc/remoteproc_core.c:1012:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return ret;
            ^~~

vim +/loaded_table +887 drivers/remoteproc/remoteproc_core.c

a2b950ac Ohad Ben-Cohen       2013-04-07   881  	/*
a2b950ac Ohad Ben-Cohen       2013-04-07   882  	 * Update table_ptr so that all subsequent vring allocations and
a2b950ac Ohad Ben-Cohen       2013-04-07   883  	 * virtio fields manipulation update the actual loaded resource table
a2b950ac Ohad Ben-Cohen       2013-04-07   884  	 * in device memory.
a2b950ac Ohad Ben-Cohen       2013-04-07   885  	 */
ea76063f Peter Griffin        2016-06-07   886  	if (rproc->has_rsctable)
a2b950ac Ohad Ben-Cohen       2013-04-07  @887  		rproc->table_ptr = loaded_table;
a2b950ac Ohad Ben-Cohen       2013-04-07   888  
400e64df Ohad Ben-Cohen       2011-10-20   889  	rproc->state = RPROC_RUNNING;
400e64df Ohad Ben-Cohen       2011-10-20   890  
400e64df Ohad Ben-Cohen       2011-10-20   891  	dev_info(dev, "remote processor %s is now up\n", rproc->name);
400e64df Ohad Ben-Cohen       2011-10-20   892  
400e64df Ohad Ben-Cohen       2011-10-20   893  	return 0;
400e64df Ohad Ben-Cohen       2011-10-20   894  
400e64df Ohad Ben-Cohen       2011-10-20   895  clean_up:
400e64df Ohad Ben-Cohen       2011-10-20   896  	rproc_resource_cleanup(rproc);
400e64df Ohad Ben-Cohen       2011-10-20   897  	rproc_disable_iommu(rproc);
400e64df Ohad Ben-Cohen       2011-10-20   898  	return ret;
400e64df Ohad Ben-Cohen       2011-10-20   899  }
400e64df Ohad Ben-Cohen       2011-10-20   900  
400e64df Ohad Ben-Cohen       2011-10-20   901  /*
400e64df Ohad Ben-Cohen       2011-10-20   902   * take a firmware and look for virtio devices to register.
400e64df Ohad Ben-Cohen       2011-10-20   903   *
400e64df Ohad Ben-Cohen       2011-10-20   904   * Note: this function is called asynchronously upon registration of the
400e64df Ohad Ben-Cohen       2011-10-20   905   * remote processor (so we must wait until it completes before we try
400e64df Ohad Ben-Cohen       2011-10-20   906   * to unregister the device. one other option is just to use kref here,
400e64df Ohad Ben-Cohen       2011-10-20   907   * that might be cleaner).
400e64df Ohad Ben-Cohen       2011-10-20   908   */
400e64df Ohad Ben-Cohen       2011-10-20   909  static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
400e64df Ohad Ben-Cohen       2011-10-20   910  {
400e64df Ohad Ben-Cohen       2011-10-20   911  	struct rproc *rproc = context;
1e3e2c7c Ohad Ben-Cohen       2012-02-13   912  	struct resource_table *table;
1e3e2c7c Ohad Ben-Cohen       2012-02-13   913  	int ret, tablesz;
400e64df Ohad Ben-Cohen       2011-10-20   914  
400e64df Ohad Ben-Cohen       2011-10-20   915  	if (rproc_fw_sanity_check(rproc, fw) < 0)
400e64df Ohad Ben-Cohen       2011-10-20   916  		goto out;
400e64df Ohad Ben-Cohen       2011-10-20   917  
1e3e2c7c Ohad Ben-Cohen       2012-02-13   918  	/* look for the resource table */
bd484984 Sjur Br?ndeland      2012-06-19   919  	table = rproc_find_rsc_table(rproc, fw,  &tablesz);
1e3e2c7c Ohad Ben-Cohen       2012-02-13   920  	if (!table)
1e3e2c7c Ohad Ben-Cohen       2012-02-13   921  		goto out;
1e3e2c7c Ohad Ben-Cohen       2012-02-13   922  
a2b950ac Ohad Ben-Cohen       2013-04-07   923  	rproc->table_csum = crc32(0, table, tablesz);
a2b950ac Ohad Ben-Cohen       2013-04-07   924  
a2b950ac Ohad Ben-Cohen       2013-04-07   925  	/*
a2b950ac Ohad Ben-Cohen       2013-04-07   926  	 * Create a copy of the resource table. When a virtio device starts
a2b950ac Ohad Ben-Cohen       2013-04-07   927  	 * and calls vring_new_virtqueue() the address of the allocated vring
a2b950ac Ohad Ben-Cohen       2013-04-07   928  	 * will be stored in the cached_table. Before the device is started,
a2b950ac Ohad Ben-Cohen       2013-04-07   929  	 * cached_table will be copied into devic memory.
a2b950ac Ohad Ben-Cohen       2013-04-07   930  	 */
95cee62c Thomas Meyer         2013-07-01   931  	rproc->cached_table = kmemdup(table, tablesz, GFP_KERNEL);
a2b950ac Ohad Ben-Cohen       2013-04-07   932  	if (!rproc->cached_table)
a2b950ac Ohad Ben-Cohen       2013-04-07   933  		goto out;
a2b950ac Ohad Ben-Cohen       2013-04-07   934  
a2b950ac Ohad Ben-Cohen       2013-04-07   935  	rproc->table_ptr = rproc->cached_table;
a2b950ac Ohad Ben-Cohen       2013-04-07   936  
ba7290e0 Sjur Br?ndeland      2013-02-21   937  	/* count the number of notify-ids */
ba7290e0 Sjur Br?ndeland      2013-02-21   938  	rproc->max_notifyid = -1;
172e6ab1 Suman Anna           2015-02-27   939  	ret = rproc_handle_resources(rproc, tablesz,
172e6ab1 Suman Anna           2015-02-27   940  				     rproc_count_vrings_handler);
1e3e2c7c Ohad Ben-Cohen       2012-02-13   941  	if (ret)
400e64df Ohad Ben-Cohen       2011-10-20   942  		goto out;
400e64df Ohad Ben-Cohen       2011-10-20   943  
a2b950ac Ohad Ben-Cohen       2013-04-07   944  	/* look for virtio devices and register them */
a2b950ac Ohad Ben-Cohen       2013-04-07   945  	ret = rproc_handle_resources(rproc, tablesz, rproc_vdev_handler);
a2b950ac Ohad Ben-Cohen       2013-04-07   946  
400e64df Ohad Ben-Cohen       2011-10-20   947  out:
400e64df Ohad Ben-Cohen       2011-10-20   948  	release_firmware(fw);
160e7c84 Ohad Ben-Cohen       2012-07-04   949  	/* allow rproc_del() contexts, if any, to proceed */
400e64df Ohad Ben-Cohen       2011-10-20   950  	complete_all(&rproc->firmware_loading_complete);
400e64df Ohad Ben-Cohen       2011-10-20   951  }
400e64df Ohad Ben-Cohen       2011-10-20   952  
70b85ef8 Fernando Guzman Lugo 2012-08-30   953  static int rproc_add_virtio_devices(struct rproc *rproc)
70b85ef8 Fernando Guzman Lugo 2012-08-30   954  {
70b85ef8 Fernando Guzman Lugo 2012-08-30   955  	int ret;
70b85ef8 Fernando Guzman Lugo 2012-08-30   956  
70b85ef8 Fernando Guzman Lugo 2012-08-30   957  	/* rproc_del() calls must wait until async loader completes */
70b85ef8 Fernando Guzman Lugo 2012-08-30   958  	init_completion(&rproc->firmware_loading_complete);
70b85ef8 Fernando Guzman Lugo 2012-08-30   959  
70b85ef8 Fernando Guzman Lugo 2012-08-30   960  	/*
70b85ef8 Fernando Guzman Lugo 2012-08-30   961  	 * We must retrieve early virtio configuration info from
70b85ef8 Fernando Guzman Lugo 2012-08-30   962  	 * the firmware (e.g. whether to register a virtio device,
70b85ef8 Fernando Guzman Lugo 2012-08-30   963  	 * what virtio features does it support, ...).
70b85ef8 Fernando Guzman Lugo 2012-08-30   964  	 *
70b85ef8 Fernando Guzman Lugo 2012-08-30   965  	 * We're initiating an asynchronous firmware loading, so we can
70b85ef8 Fernando Guzman Lugo 2012-08-30   966  	 * be built-in kernel code, without hanging the boot process.
70b85ef8 Fernando Guzman Lugo 2012-08-30   967  	 */
70b85ef8 Fernando Guzman Lugo 2012-08-30   968  	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
70b85ef8 Fernando Guzman Lugo 2012-08-30   969  				      rproc->firmware, &rproc->dev, GFP_KERNEL,
70b85ef8 Fernando Guzman Lugo 2012-08-30   970  				      rproc, rproc_fw_config_virtio);
70b85ef8 Fernando Guzman Lugo 2012-08-30   971  	if (ret < 0) {
70b85ef8 Fernando Guzman Lugo 2012-08-30   972  		dev_err(&rproc->dev, "request_firmware_nowait err: %d\n", ret);
70b85ef8 Fernando Guzman Lugo 2012-08-30   973  		complete_all(&rproc->firmware_loading_complete);
70b85ef8 Fernando Guzman Lugo 2012-08-30   974  	}
70b85ef8 Fernando Guzman Lugo 2012-08-30   975  
70b85ef8 Fernando Guzman Lugo 2012-08-30   976  	return ret;
70b85ef8 Fernando Guzman Lugo 2012-08-30   977  }
70b85ef8 Fernando Guzman Lugo 2012-08-30   978  
70b85ef8 Fernando Guzman Lugo 2012-08-30   979  /**
70b85ef8 Fernando Guzman Lugo 2012-08-30   980   * rproc_trigger_recovery() - recover a remoteproc
70b85ef8 Fernando Guzman Lugo 2012-08-30   981   * @rproc: the remote processor
70b85ef8 Fernando Guzman Lugo 2012-08-30   982   *
70b85ef8 Fernando Guzman Lugo 2012-08-30   983   * The recovery is done by reseting all the virtio devices, that way all the
70b85ef8 Fernando Guzman Lugo 2012-08-30   984   * rpmsg drivers will be reseted along with the remote processor making the
70b85ef8 Fernando Guzman Lugo 2012-08-30   985   * remoteproc functional again.
70b85ef8 Fernando Guzman Lugo 2012-08-30   986   *
70b85ef8 Fernando Guzman Lugo 2012-08-30   987   * This function can sleep, so it cannot be called from atomic context.
70b85ef8 Fernando Guzman Lugo 2012-08-30   988   */
70b85ef8 Fernando Guzman Lugo 2012-08-30   989  int rproc_trigger_recovery(struct rproc *rproc)
70b85ef8 Fernando Guzman Lugo 2012-08-30   990  {
70b85ef8 Fernando Guzman Lugo 2012-08-30   991  	struct rproc_vdev *rvdev, *rvtmp;
ea76063f Peter Griffin        2016-06-07   992  	int ret;
70b85ef8 Fernando Guzman Lugo 2012-08-30   993  
70b85ef8 Fernando Guzman Lugo 2012-08-30   994  	dev_err(&rproc->dev, "recovering %s\n", rproc->name);
70b85ef8 Fernando Guzman Lugo 2012-08-30   995  
70b85ef8 Fernando Guzman Lugo 2012-08-30   996  	init_completion(&rproc->crash_comp);
70b85ef8 Fernando Guzman Lugo 2012-08-30   997  
70b85ef8 Fernando Guzman Lugo 2012-08-30   998  	/* clean up remote vdev entries */
70b85ef8 Fernando Guzman Lugo 2012-08-30   999  	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
70b85ef8 Fernando Guzman Lugo 2012-08-30  1000  		rproc_remove_virtio_dev(rvdev);
70b85ef8 Fernando Guzman Lugo 2012-08-30  1001  
70b85ef8 Fernando Guzman Lugo 2012-08-30  1002  	/* wait until there is no more rproc users */
70b85ef8 Fernando Guzman Lugo 2012-08-30  1003  	wait_for_completion(&rproc->crash_comp);
70b85ef8 Fernando Guzman Lugo 2012-08-30  1004  
a2b950ac Ohad Ben-Cohen       2013-04-07  1005  	/* Free the copy of the resource table */
a2b950ac Ohad Ben-Cohen       2013-04-07  1006  	kfree(rproc->cached_table);
ea76063f Peter Griffin        2016-06-07  1007  	rproc->cached_table = NULL;
ea76063f Peter Griffin        2016-06-07  1008  
ea76063f Peter Griffin        2016-06-07  1009  	if (rproc->has_rsctable)
ea76063f Peter Griffin        2016-06-07  1010  		ret = rproc_add_virtio_devices(rproc);
a2b950ac Ohad Ben-Cohen       2013-04-07  1011  
ea76063f Peter Griffin        2016-06-07 @1012  	return ret;
70b85ef8 Fernando Guzman Lugo 2012-08-30  1013  }
70b85ef8 Fernando Guzman Lugo 2012-08-30  1014  
400e64df Ohad Ben-Cohen       2011-10-20  1015  /**

:::::: The code at line 887 was first introduced by commit
:::::: a2b950ac7b1e6442919ee9e79c4963e134698869 remoteproc: perserve resource table data

:::::: TO: Ohad Ben-Cohen <ohad@wizery.com>
:::::: CC: Ohad Ben-Cohen <ohad@wizery.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55044 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/739d9c48/attachment-0001.obj>
