From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 07:01:31 +0800
Subject: [xlnx:master 1768/1831] drivers/fpga/fpga-mgr.c:659:2: warning: ISO
 C90 forbids mixed declarations and code
Message-ID: <201809130728.4e9ChvhT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   5a0f5d4c5b359939907b9cf874d3a9f8ad72d5e3
commit: e3e63147b9d23f6cfc6c8996c49fe3af4dd0c643 [1768/1831] fpga: fpga-mgr: Add readback support
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e3e63147b9d23f6cfc6c8996c49fe3af4dd0c643
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/fpga/fpga-mgr.c: In function 'fpga_mgr_register':
>> drivers/fpga/fpga-mgr.c:659:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     struct dentry *d, *parent;
     ^~~~~~

vim +659 drivers/fpga/fpga-mgr.c

   591	
   592	/**
   593	 * fpga_mgr_register - register a low level fpga manager driver
   594	 * @dev:	fpga manager device from pdev
   595	 * @name:	fpga manager name
   596	 * @mops:	pointer to structure of fpga manager ops
   597	 * @priv:	fpga manager private data
   598	 *
   599	 * Return: 0 on success, negative error code otherwise.
   600	 */
   601	int fpga_mgr_register(struct device *dev, const char *name,
   602			      const struct fpga_manager_ops *mops,
   603			      void *priv)
   604	{
   605		struct fpga_manager *mgr;
   606		int id, ret;
   607	
   608		if (!mops || !mops->write_complete || !mops->state ||
   609		    !mops->write_init || (!mops->write && !mops->write_sg) ||
   610		    (mops->write && mops->write_sg)) {
   611			dev_err(dev, "Attempt to register without fpga_manager_ops\n");
   612			return -EINVAL;
   613		}
   614	
   615		if (!name || !strlen(name)) {
   616			dev_err(dev, "Attempt to register with no name!\n");
   617			return -EINVAL;
   618		}
   619	
   620		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
   621		if (!mgr)
   622			return -ENOMEM;
   623	
   624		id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
   625		if (id < 0) {
   626			ret = id;
   627			goto error_kfree;
   628		}
   629	
   630		mutex_init(&mgr->ref_mutex);
   631	
   632		mgr->name = name;
   633		mgr->mops = mops;
   634		mgr->priv = priv;
   635	
   636		/*
   637		 * Initialize framework state by requesting low level driver read state
   638		 * from device.  FPGA may be in reset mode or may have been programmed
   639		 * by bootloader or EEPROM.
   640		 */
   641		mgr->state = mgr->mops->state(mgr);
   642	
   643		device_initialize(&mgr->dev);
   644		mgr->dev.class = fpga_mgr_class;
   645		mgr->dev.parent = dev;
   646		mgr->dev.of_node = dev->of_node;
   647		mgr->dev.id = id;
   648		dev_set_drvdata(dev, mgr);
   649	
   650		ret = dev_set_name(&mgr->dev, "fpga%d", id);
   651		if (ret)
   652			goto error_device;
   653	
   654		ret = device_add(&mgr->dev);
   655		if (ret)
   656			goto error_device;
   657	
   658	#ifdef CONFIG_FPGA_MGR_DEBUG_FS
 > 659		struct dentry *d, *parent;
   660	
   661		mgr->dir = debugfs_create_dir("fpga", NULL);
   662		if (!mgr->dir)
   663			goto error_device;
   664	
   665		parent = mgr->dir;
   666		d = debugfs_create_dir(mgr->dev.kobj.name, parent);
   667		if (!d) {
   668			debugfs_remove_recursive(parent);
   669			goto error_device;
   670		}
   671	
   672		parent = d;
   673		d = debugfs_create_file("image", 0644, parent, mgr,
   674					&fpga_mgr_ops_image);
   675		if (!d) {
   676			debugfs_remove_recursive(mgr->dir);
   677			goto error_device;
   678		}
   679	#endif
   680		dev_info(&mgr->dev, "%s registered\n", mgr->name);
   681	
   682		return 0;
   683	
   684	error_device:
   685		ida_simple_remove(&fpga_mgr_ida, id);
   686	error_kfree:
   687		kfree(mgr);
   688	
   689		return ret;
   690	}
   691	EXPORT_SYMBOL_GPL(fpga_mgr_register);
   692	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52316 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/8471d9a4/attachment-0001.gz>
