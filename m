From: lkp@intel.com (kbuild test robot)
Date: Fri, 13 Jan 2017 18:40:37 +0800
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range
 passed to arch_setup_dma_ops()
In-Reply-To: <1484159512-28515-2-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <201701131852.pk5JuBJy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikita,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc3 next-20170112]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nikita-Yushchenko/dma-mapping-let-arch-know-origin-of-dma-range-passed-to-arch_setup_dma_ops/20170113-152733
config: x86_64-randconfig-u0-01131618 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/acpi/scan.c: In function 'acpi_dma_configure':
>> drivers/acpi/scan.c:1388:2: error: too many arguments to function 'arch_setup_dma_ops'
     arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, false, iommu,
     ^~~~~~~~~~~~~~~~~~
   In file included from drivers/acpi/scan.c:15:0:
   include/linux/dma-mapping.h:611:20: note: declared here
    static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
                       ^~~~~~~~~~~~~~~~~~

vim +/arch_setup_dma_ops +1388 drivers/acpi/scan.c

  1382		iommu = iort_iommu_configure(dev);
  1383	
  1384		/*
  1385		 * Assume dma valid range starts at 0 and covers the whole
  1386		 * coherent_dma_mask.
  1387		 */
> 1388		arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, false, iommu,
  1389				   attr == DEV_DMA_COHERENT);
  1390	}
  1391	EXPORT_SYMBOL_GPL(acpi_dma_configure);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25665 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170113/7e91dc43/attachment-0001.gz>
