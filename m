From: lkp@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 13:12:07 +0800
Subject: [PATCH 09/10] iommu/exynos: Make use of iommu_device_register
 interface
In-Reply-To: <1486397429-29327-10-git-send-email-joro@8bytes.org>
Message-ID: <201702071323.LHot8M9l%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc7]
[cannot apply to iommu/next next-20170206]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joerg-Roedel/Let-IOMMU-core-know-about-individual-IOMMUs/20170207-003931
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Joerg-Roedel/Let-IOMMU-core-know-about-individual-IOMMUs/20170207-003931 HEAD 0b8fd0f8bbcfb693621ee90abffb0774c143549d builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/iommu/exynos-iommu.c: In function 'exynos_sysmmu_probe':
>> drivers/iommu/exynos-iommu.c:624:13: error: 'struct iommu_device' has no member named 'fwnode'
     data->iommu.fwnode = &dev->of_node->fwnode;
                ^

vim +624 drivers/iommu/exynos-iommu.c

   618		ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
   619					     "sysmmu.%pa", &ioaddr);
   620		if (ret)
   621			return ret;
   622	
   623		data->iommu.ops    = &exynos_iommu_ops;
 > 624		data->iommu.fwnode = &dev->of_node->fwnode;
   625	
   626		ret = iommu_device_register(&data->iommu);
   627		if (ret)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59744 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/c64f2561/attachment-0001.gz>
