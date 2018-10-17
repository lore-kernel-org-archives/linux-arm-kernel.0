From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Oct 2018 23:42:47 +0800
Subject: [PATCH v4 3/4] perf/smmuv3: Add MSI irq support
In-Reply-To: <20181016124920.24708-4-shameerali.kolothum.thodi@huawei.com>
References: <20181016124920.24708-4-shameerali.kolothum.thodi@huawei.com>
Message-ID: <201810172330.GRaDCqBM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shameer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux-sof-driver/master]
[also build test ERROR on v4.19-rc8 next-20181017]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shameer-Kolothum/arm64-SMMUv3-PMU-driver-with-IORT-support/20181017-063949
base:   https://github.com/thesofproject/linux master
config: sh-allyesconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/perf/arm_smmuv3_pmu.c:37:
   drivers/perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_counter_set_value':
   include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers/perf/arm_smmuv3_pmu.c:152:31: note: in expansion of macro 'BIT'
     if (smmu_pmu->counter_mask & BIT(32))
                                  ^~~
   drivers/perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_counter_get_value':
   include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers/perf/arm_smmuv3_pmu.c:162:31: note: in expansion of macro 'BIT'
     if (smmu_pmu->counter_mask & BIT(32))
                                  ^~~
   drivers/perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_free_msis':
>> drivers/perf/arm_smmuv3_pmu.c:601:2: error: implicit declaration of function 'platform_msi_domain_free_irqs'; did you mean 'platform_pm_freeze'? [-Werror=implicit-function-declaration]
     platform_msi_domain_free_irqs(dev);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     platform_pm_freeze
   drivers/perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_setup_msi':
   drivers/perf/arm_smmuv3_pmu.c:632:8: error: implicit declaration of function 'platform_msi_domain_alloc_irqs'; did you mean 'platform_device_alloc'? [-Werror=implicit-function-declaration]
     ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           platform_device_alloc
   In file included from include/linux/list.h:9:0,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/perf/arm_smmuv3_pmu.c:37:
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
   drivers/perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro 'first_msi_entry'
     desc = first_msi_entry(dev);
            ^~~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/acpi.h:25,
                    from drivers/perf/arm_smmuv3_pmu.c:37:
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
   drivers/perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro 'first_msi_entry'
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
   drivers/perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro 'first_msi_entry'
     desc = first_msi_entry(dev);
            ^~~~~~~~~~~~~~~
   drivers/perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_probe':

vim +601 drivers/perf/arm_smmuv3_pmu.c

   596	
   597	static void smmu_pmu_free_msis(void *data)
   598	{
   599		struct device *dev = data;
   600	
 > 601		platform_msi_domain_free_irqs(dev);
   602	}
   603	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47775 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/6a955108/attachment-0001.gz>
