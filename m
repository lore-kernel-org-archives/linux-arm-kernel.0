From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Sep 2018 09:41:12 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 6/14]
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3667:11: error: implicit
 declaration of function 'of_find_node_by_path'; did you mean
 '__inc_node_state'?
Message-ID: <201809140908.tFTTHUPU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   7d998f9af090acce9f3cef3ef2c6de074f6a1875
commit: f329c5fa9758ad65a4c4c3f0b0c3f43696ff417b [6/14] irqdomain: Kill irq_domain_add_legacy_isa
config: powerpc64-allmodconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f329c5fa9758ad65a4c4c3f0b0c3f43696ff417b
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc64 

All error/warnings (new ones prefixed by >>):

   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_get_system_info':
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3667:11: error: implicit declaration of function 'of_find_node_by_path'; did you mean '__inc_node_state'? [-Werror=implicit-function-declaration]
     rootdn = of_find_node_by_path("/");
              ^~~~~~~~~~~~~~~~~~~~
              __inc_node_state
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3667:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     rootdn = of_find_node_by_path("/");
            ^
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3671:10: error: implicit declaration of function 'of_get_property'; did you mean '__get_order'? [-Werror=implicit-function-declaration]
     model = of_get_property(rootdn, "model", NULL);
             ^~~~~~~~~~~~~~~
             __get_order
   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3671:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     model = of_get_property(rootdn, "model", NULL);
           ^
   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3672:5: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     id = of_get_property(rootdn, "system-id", NULL);
        ^
   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3676:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     name = of_get_property(rootdn, "ibm,partition-name", NULL);
          ^
   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3680:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     num = of_get_property(rootdn, "ibm,partition-no", NULL);
         ^
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3682:22: error: implicit declaration of function 'of_read_number'; did you mean 'down_read_nested'? [-Werror=implicit-function-declaration]
      partition_number = of_read_number(num, 1);
                         ^~~~~~~~~~~~~~
                         down_read_nested
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3684:2: error: implicit declaration of function 'of_node_put'; did you mean '__node_set'? [-Werror=implicit-function-declaration]
     of_node_put(rootdn);
     ^~~~~~~~~~~
     __node_set
   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3686:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     vdevdn = of_find_node_by_path("/vdevice");
            ^
   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3690:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      mvds = of_get_property(vdevdn, "ibm,max-virtual-dma-size",
           ^
   cc1: some warnings being treated as errors

vim +3667 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c

88a678bb Bryant G. Ly 2016-06-28  3660  
88a678bb Bryant G. Ly 2016-06-28  3661  static int ibmvscsis_get_system_info(void)
88a678bb Bryant G. Ly 2016-06-28  3662  {
88a678bb Bryant G. Ly 2016-06-28  3663  	struct device_node *rootdn, *vdevdn;
88a678bb Bryant G. Ly 2016-06-28  3664  	const char *id, *model, *name;
88a678bb Bryant G. Ly 2016-06-28  3665  	const uint *num;
88a678bb Bryant G. Ly 2016-06-28  3666  
88a678bb Bryant G. Ly 2016-06-28 @3667  	rootdn = of_find_node_by_path("/");
88a678bb Bryant G. Ly 2016-06-28  3668  	if (!rootdn)
88a678bb Bryant G. Ly 2016-06-28  3669  		return -ENOENT;
88a678bb Bryant G. Ly 2016-06-28  3670  
88a678bb Bryant G. Ly 2016-06-28 @3671  	model = of_get_property(rootdn, "model", NULL);
88a678bb Bryant G. Ly 2016-06-28 @3672  	id = of_get_property(rootdn, "system-id", NULL);
88a678bb Bryant G. Ly 2016-06-28  3673  	if (model && id)
88a678bb Bryant G. Ly 2016-06-28  3674  		snprintf(system_id, sizeof(system_id), "%s-%s", model, id);
88a678bb Bryant G. Ly 2016-06-28  3675  
88a678bb Bryant G. Ly 2016-06-28  3676  	name = of_get_property(rootdn, "ibm,partition-name", NULL);
88a678bb Bryant G. Ly 2016-06-28  3677  	if (name)
88a678bb Bryant G. Ly 2016-06-28  3678  		strncpy(partition_name, name, sizeof(partition_name));
88a678bb Bryant G. Ly 2016-06-28  3679  
88a678bb Bryant G. Ly 2016-06-28 @3680  	num = of_get_property(rootdn, "ibm,partition-no", NULL);
88a678bb Bryant G. Ly 2016-06-28  3681  	if (num)
9c93cf03 Michael Cyr  2016-10-13 @3682  		partition_number = of_read_number(num, 1);
88a678bb Bryant G. Ly 2016-06-28  3683  
88a678bb Bryant G. Ly 2016-06-28 @3684  	of_node_put(rootdn);
88a678bb Bryant G. Ly 2016-06-28  3685  
88a678bb Bryant G. Ly 2016-06-28  3686  	vdevdn = of_find_node_by_path("/vdevice");
88a678bb Bryant G. Ly 2016-06-28  3687  	if (vdevdn) {
88a678bb Bryant G. Ly 2016-06-28  3688  		const uint *mvds;
88a678bb Bryant G. Ly 2016-06-28  3689  
88a678bb Bryant G. Ly 2016-06-28  3690  		mvds = of_get_property(vdevdn, "ibm,max-virtual-dma-size",
88a678bb Bryant G. Ly 2016-06-28  3691  				       NULL);
88a678bb Bryant G. Ly 2016-06-28  3692  		if (mvds)
88a678bb Bryant G. Ly 2016-06-28  3693  			max_vdma_size = *mvds;
88a678bb Bryant G. Ly 2016-06-28  3694  		of_node_put(vdevdn);
88a678bb Bryant G. Ly 2016-06-28  3695  	}
88a678bb Bryant G. Ly 2016-06-28  3696  
88a678bb Bryant G. Ly 2016-06-28  3697  	return 0;
88a678bb Bryant G. Ly 2016-06-28  3698  }
88a678bb Bryant G. Ly 2016-06-28  3699  

:::::: The code at line 3667 was first introduced by commit
:::::: 88a678bbc34cecce36bf2c7a8af4cba38f9f77ce ibmvscsis: Initial commit of IBM VSCSI Tgt Driver

:::::: TO: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
:::::: CC: Nicholas Bellinger <nab@linux-iscsi.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58607 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180914/3a5b7a66/attachment-0001.gz>
