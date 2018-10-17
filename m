From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Oct 2018 11:35:51 +0800
Subject: [PATCH v4 3/4] perf/smmuv3: Add MSI irq support
In-Reply-To: <20181016124920.24708-4-shameerali.kolothum.thodi@huawei.com>
References: <20181016124920.24708-4-shameerali.kolothum.thodi@huawei.com>
Message-ID: <201810171145.mGVw4SgU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shameer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux-sof-driver/master]
[also build test ERROR on v4.19-rc8 next-20181016]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shameer-Kolothum/arm64-SMMUv3-PMU-driver-with-IORT-support/20181017-063949
base:   https://github.com/thesofproject/linux master
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers//perf/arm_smmuv3_pmu.c:37:
   drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_counter_set_value':
   include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers//perf/arm_smmuv3_pmu.c:152:31: note: in expansion of macro 'BIT'
     if (smmu_pmu->counter_mask & BIT(32))
                                  ^~~
   drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_counter_get_value':
   include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers//perf/arm_smmuv3_pmu.c:162:31: note: in expansion of macro 'BIT'
     if (smmu_pmu->counter_mask & BIT(32))
                                  ^~~
   drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_free_msis':
>> drivers//perf/arm_smmuv3_pmu.c:601:2: error: implicit declaration of function 'platform_msi_domain_free_irqs'; did you mean 'platform_get_device_id'? [-Werror=implicit-function-declaration]
     platform_msi_domain_free_irqs(dev);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     platform_get_device_id
   drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_setup_msi':
>> drivers//perf/arm_smmuv3_pmu.c:632:8: error: implicit declaration of function 'platform_msi_domain_alloc_irqs'; did you mean 'platform_device_alloc'? [-Werror=implicit-function-declaration]
     ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           platform_device_alloc
   In file included from include/linux/list.h:9:0,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers//perf/arm_smmuv3_pmu.c:37:
   include/linux/msi.h:114:38: error: 'struct device' has no member named 'msi_list'
    #define dev_to_msi_list(dev)  (&(dev)->msi_list)
                                         ^
   include/linux/kernel.h:961:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/msi.h:116:2: note: in expansion of macro 'list_first_entry'
     list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
     ^~~~~~~~~~~~~~~~
   include/linux/msi.h:116:19: note: in expansion of macro 'dev_to_msi_list'
     list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
                      ^~~~~~~~~~~~~~~
>> drivers//perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro 'first_msi_entry'
     desc = first_msi_entry(dev);
            ^~~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/acpi.h:25,
                    from drivers//perf/arm_smmuv3_pmu.c:37:
   include/linux/msi.h:114:38: error: 'struct device' has no member named 'msi_list'
    #define dev_to_msi_list(dev)  (&(dev)->msi_list)
                                         ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/msi.h:116:2: note: in expansion of macro 'list_first_entry'
     list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
     ^~~~~~~~~~~~~~~~
   include/linux/msi.h:116:19: note: in expansion of macro 'dev_to_msi_list'
     list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
                      ^~~~~~~~~~~~~~~
>> drivers//perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro 'first_msi_entry'
     desc = first_msi_entry(dev);
            ^~~~~~~~~~~~~~~
   include/linux/msi.h:114:38: error: 'struct device' has no member named 'msi_list'
    #define dev_to_msi_list(dev)  (&(dev)->msi_list)
                                         ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:963:6: note: in expansion of macro '__same_type'
        !__same_type(*(ptr), void),   \
         ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/msi.h:116:2: note: in expansion of macro 'list_first_entry'
     list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
     ^~~~~~~~~~~~~~~~
   include/linux/msi.h:116:19: note: in expansion of macro 'dev_to_msi_list'
     list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
                      ^~~~~~~~~~~~~~~
>> drivers//perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro 'first_msi_entry'
     desc = first_msi_entry(dev);
            ^~~~~~~~~~~~~~~
   drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_probe':
   drivers//perf/arm_smmuv3_pmu.c:745:64: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
                                                                ~~~^
                                                                %x
   cc1: some warnings being treated as errors

vim +601 drivers//perf/arm_smmuv3_pmu.c

   596	
   597	static void smmu_pmu_free_msis(void *data)
   598	{
   599		struct device *dev = data;
   600	
 > 601		platform_msi_domain_free_irqs(dev);
   602	}
   603	
   604	static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
   605	{
   606		phys_addr_t doorbell;
   607		struct device *dev = msi_desc_to_dev(desc);
   608		struct smmu_pmu *pmu = dev_get_drvdata(dev);
   609	
   610		doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
   611		doorbell &= MSI_CFG0_ADDR_MASK;
   612	
   613		writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
   614		writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
   615		writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
   616			       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
   617	}
   618	
   619	static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
   620	{
   621		struct msi_desc *desc;
   622		struct device *dev = pmu->dev;
   623		int ret;
   624	
   625		/* Clear MSI address reg */
   626		writeq_relaxed(0, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
   627	
   628		/* MSI supported or not */
   629		if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
   630			return;
   631	
 > 632		ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
   633		if (ret) {
   634			dev_warn(dev, "failed to allocate MSIs\n");
   635			return;
   636		}
   637	
 > 638		desc = first_msi_entry(dev);
   639		if (desc)
   640			pmu->irq = desc->irq;
   641	
   642		/* Add callback to free MSIs on teardown */
   643		devm_add_action(dev, smmu_pmu_free_msis, dev);
   644	}
   645	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47770 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/aaa37dc2/attachment-0001.gz>
