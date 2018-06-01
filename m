From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Jun 2018 01:51:30 +0800
Subject: [PATCH 5/7] iommu/dma: add support for non-strict mode
In-Reply-To: <1527752569-18020-6-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-6-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <201806020106.eRUp2Ehc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc7 next-20180601]
[cannot apply to iommu/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Zhen-Lei/add-non-strict-mode-support-for-arm-smmu-v3/20180602-000418
config: x86_64-randconfig-x008-201821 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers//iommu/amd_iommu.c: In function 'amd_iommu_capable':
>> drivers//iommu/amd_iommu.c:3053:2: warning: enumeration value 'IOMMU_CAP_NON_STRICT' not handled in switch [-Wswitch]
     switch (cap) {
     ^~~~~~

vim +/IOMMU_CAP_NON_STRICT +3053 drivers//iommu/amd_iommu.c

645c4c8d arch/x86/kernel/amd_iommu.c Joerg Roedel 2008-12-02  3050  
ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3051  static bool amd_iommu_capable(enum iommu_cap cap)
dbb9fd86 arch/x86/kernel/amd_iommu.c Sheng Yang   2009-03-18  3052  {
80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27 @3053  	switch (cap) {
80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27  3054  	case IOMMU_CAP_CACHE_COHERENCY:
ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3055  		return true;
bdddadcb drivers/iommu/amd_iommu.c   Joerg Roedel 2012-07-02  3056  	case IOMMU_CAP_INTR_REMAP:
ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3057  		return (irq_remapping_enabled == 1);
cfdeec22 drivers/iommu/amd_iommu.c   Will Deacon  2014-10-27  3058  	case IOMMU_CAP_NOEXEC:
cfdeec22 drivers/iommu/amd_iommu.c   Will Deacon  2014-10-27  3059  		return false;
80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27  3060  	}
80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27  3061  
ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3062  	return false;
dbb9fd86 arch/x86/kernel/amd_iommu.c Sheng Yang   2009-03-18  3063  }
dbb9fd86 arch/x86/kernel/amd_iommu.c Sheng Yang   2009-03-18  3064  

:::::: The code at line 3053 was first introduced by commit
:::::: 80a506b8fdcfa868bb53eb740f928217d0966fc1 x86/amd-iommu: Export cache-coherency capability

:::::: TO: Joerg Roedel <joerg.roedel@amd.com>
:::::: CC: Joerg Roedel <joerg.roedel@amd.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28596 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180602/14d67fbb/attachment-0001.gz>
