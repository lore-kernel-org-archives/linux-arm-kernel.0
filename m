From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Aug 2017 13:12:55 +0800
Subject: [PATCH v3 3/5] ACPI: Introduce DMA ranges parsing
In-Reply-To: <20170803123239.11359-4-lorenzo.pieralisi@arm.com>
Message-ID: <201708061311.4aEB8P1Q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.13-rc3 next-20170804]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Pieralisi/ACPICA-resource_mgr-Allow-_DMA-method-in-walk-resources/20170804-185152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

Note: the linux-review/Lorenzo-Pieralisi/ACPICA-resource_mgr-Allow-_DMA-method-in-walk-resources/20170804-185152 HEAD 37e91dddbbeb771d4df0001f716607f1dd8719f8 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/acpi/scan.c: In function 'acpi_dma_configure':
>> drivers/acpi/scan.c:1451:2: error: implicit declaration of function 'iort_dma_setup' [-Werror=implicit-function-declaration]
     iort_dma_setup(dev, &dma_addr, &size);
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/iort_dma_setup +1451 drivers/acpi/scan.c

  1440	
  1441	/**
  1442	 * acpi_dma_configure - Set-up DMA configuration for the device.
  1443	 * @dev: The pointer to the device
  1444	 * @attr: device dma attributes
  1445	 */
  1446	int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
  1447	{
  1448		const struct iommu_ops *iommu;
  1449		u64 dma_addr = 0, size = 0;
  1450	
> 1451		iort_dma_setup(dev, &dma_addr, &size);
  1452	
  1453		iommu = iort_iommu_configure(dev);
  1454		if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
  1455			return -EPROBE_DEFER;
  1456	
  1457		arch_setup_dma_ops(dev, dma_addr, size,
  1458					iommu, attr == DEV_DMA_COHERENT);
  1459	
  1460		return 0;
  1461	}
  1462	EXPORT_SYMBOL_GPL(acpi_dma_configure);
  1463	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6018 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170806/ed737158/attachment.gz>
