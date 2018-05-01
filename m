From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 May 2018 13:43:57 +0800
Subject: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
References: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
Message-ID: <201805011325.9k8OrJyv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nipun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180430]
[cannot apply to iommu/next glikely/devicetree/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nipun-Gupta/Support-for-fsl-mc-bus-and-its-devices-in-SMMU/20180501-125745
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/bus/fsl-mc/fsl-mc-bus.c: In function 'fsl_mc_dma_configure':
>> drivers/bus/fsl-mc/fsl-mc-bus.c:137:9: error: too many arguments to function 'of_dma_configure'
     return of_dma_configure(dev, dma_dev->of_node, 0);
            ^~~~~~~~~~~~~~~~
   In file included from drivers/bus/fsl-mc/fsl-mc-bus.c:13:0:
   include/linux/of_device.h:58:5: note: declared here
    int of_dma_configure(struct device *dev, struct device_node *np);
        ^~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/fsl-mc-bus.c: At top level:
>> drivers/bus/fsl-mc/fsl-mc-bus.c:161:3: error: 'struct bus_type' has no member named 'dma_configure'
     .dma_configure  = fsl_mc_dma_configure,
      ^~~~~~~~~~~~~

vim +/of_dma_configure +137 drivers/bus/fsl-mc/fsl-mc-bus.c

   129	
   130	static int fsl_mc_dma_configure(struct device *dev)
   131	{
   132		struct device *dma_dev = dev;
   133	
   134		while (dev_is_fsl_mc(dma_dev))
   135			dma_dev = dma_dev->parent;
   136	
 > 137		return of_dma_configure(dev, dma_dev->of_node, 0);
   138	}
   139	
   140	static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
   141				     char *buf)
   142	{
   143		struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
   144	
   145		return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
   146			       mc_dev->obj_desc.type);
   147	}
   148	static DEVICE_ATTR_RO(modalias);
   149	
   150	static struct attribute *fsl_mc_dev_attrs[] = {
   151		&dev_attr_modalias.attr,
   152		NULL,
   153	};
   154	
   155	ATTRIBUTE_GROUPS(fsl_mc_dev);
   156	
   157	struct bus_type fsl_mc_bus_type = {
   158		.name = "fsl-mc",
   159		.match = fsl_mc_bus_match,
   160		.uevent = fsl_mc_bus_uevent,
 > 161		.dma_configure  = fsl_mc_dma_configure,
   162		.dev_groups = fsl_mc_dev_groups,
   163	};
   164	EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
   165	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63098 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180501/594f7044/attachment-0001.gz>
