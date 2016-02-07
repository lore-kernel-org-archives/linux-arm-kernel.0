From: lkp@intel.com (kbuild test robot)
Date: Sun, 7 Feb 2016 21:30:25 +0800
Subject: [PATCH v3 6/6] kvm: arm64: Add ACPI support for virt arch timer
In-Reply-To: <1454358418-5157-7-git-send-email-fu.wei@linaro.org>
Message-ID: <201602072148.KCt0P2NE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fu,

[auto build test ERROR on tip/timers/core]
[also build test ERROR on v4.5-rc2 next-20160205]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-clocksource-kvm-add-GTDT-and-ARM-memory-mapped-timer-support/20160202-043111
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/arch_timer.c: In function 'kvm_timer_get_ppi':
>> arch/arm64/kvm/../../../virt/kvm/arm/arch_timer.c:404:2: error: implicit declaration of function 'gtdt_arch_timer_data_init' [-Werror=implicit-function-declaration]
     if (!*ppi && !gtdt_arch_timer_data_init(NULL, &data))
     ^
   cc1: some warnings being treated as errors

vim +/gtdt_arch_timer_data_init +404 arch/arm64/kvm/../../../virt/kvm/arm/arch_timer.c

   398	
   399		*ppi = irq_of_parse_and_map(np, VIRT_PPI);
   400		of_node_put(np);
   401	
   402	skip_of:
   403	#ifdef CONFIG_ACPI_GTDT
 > 404		if (!*ppi && !gtdt_arch_timer_data_init(NULL, &data))
   405			*ppi = data.virt_ppi;
   406	#endif
   407	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160207/e26b4b75/attachment-0001.obj>
