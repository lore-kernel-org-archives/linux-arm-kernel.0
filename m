From: lkp@intel.com (kbuild test robot)
Date: Sat, 13 May 2017 09:04:57 +0800
Subject: [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #74
In-Reply-To: <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
Message-ID: <201705130903.fQrzniDd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linu,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.11 next-20170512]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Geetha-sowjanya/Cavium-ThunderX2-SMMUv3-errata-workarounds/20170513-065956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers//iommu/arm-smmu-v3.c: In function 'acpi_smmu_get_options':
>> drivers//iommu/arm-smmu-v3.c:2605:15: error: 'ACPI_IORT_SMMU_CAVIUM_CN99XX' undeclared (first use in this function)
     if (model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//iommu/arm-smmu-v3.c:2605:15: note: each undeclared identifier is reported only once for each function it appears in

vim +/ACPI_IORT_SMMU_CAVIUM_CN99XX +2605 drivers//iommu/arm-smmu-v3.c

  2599		return 0;
  2600	}
  2601	
  2602	#ifdef CONFIG_ACPI
  2603	static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
  2604	{
> 2605		if (model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
  2606			smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
  2607	
  2608		dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34579 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170513/92438abc/attachment-0001.gz>
