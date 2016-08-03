From: lkp@intel.com (kbuild test robot)
Date: Wed, 3 Aug 2016 14:00:37 +0800
Subject: [PATCH v12 8/8] vfio/type1: return MSI geometry through
 VFIO_IOMMU_GET_INFO capability chains
In-Reply-To: <1470159012-7110-9-git-send-email-eric.auger@redhat.com>
Message-ID: <201608031302.KdveMA97%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on vfio/next]
[also build test ERROR on v4.7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160803-122924
base:   https://github.com/awilliam/linux-vfio.git next
config: x86_64-randconfig-s1-08031247 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/vfio/vfio_iommu_type1.c:39:29: error: linux/msi-iommu.h: No such file or directory
   drivers/vfio/vfio_iommu_type1.c:40:32: error: linux/msi-doorbell.h: No such file or directory
   drivers/vfio/vfio_iommu_type1.c: In function 'vfio_set_msi_aperture':
   drivers/vfio/vfio_iommu_type1.c:455: error: implicit declaration of function 'iommu_msi_set_aperture'
   drivers/vfio/vfio_iommu_type1.c: In function 'vfio_iommu_type1_attach_group':
   drivers/vfio/vfio_iommu_type1.c:935: error: implicit declaration of function 'msi_doorbell_safe'
   drivers/vfio/vfio_iommu_type1.c: In function 'compute_msi_geometry_caps':
   drivers/vfio/vfio_iommu_type1.c:1113: error: storage size of 'msi_geometry' isn't known
   drivers/vfio/vfio_iommu_type1.c:1122: error: 'DOMAIN_ATTR_MSI_GEOMETRY' undeclared (first use in this function)
   drivers/vfio/vfio_iommu_type1.c:1122: error: (Each undeclared identifier is reported only once
   drivers/vfio/vfio_iommu_type1.c:1122: error: for each function it appears in.)
>> drivers/vfio/vfio_iommu_type1.c:1152: error: implicit declaration of function 'msi_doorbell_calc_pages'
   drivers/vfio/vfio_iommu_type1.c:1113: warning: unused variable 'msi_geometry'
   At top level:
   cc1: warning: unrecognized command line option "-Wno-maybe-uninitialized"

vim +/msi_doorbell_calc_pages +1152 drivers/vfio/vfio_iommu_type1.c

  1146		vfio_msi_geometry->order = order;
  1147		/*
  1148		 * we compute a system-wide requirement based on all the registered
  1149		 * doorbells
  1150		 */
  1151		vfio_msi_geometry->size =
> 1152			msi_doorbell_calc_pages(order) * ((uint64_t) 1 << order);
  1153	
  1154		return 0;
  1155	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19855 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160803/1289b1fe/attachment-0001.obj>
