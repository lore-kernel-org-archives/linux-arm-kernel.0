From: lkp@intel.com (kbuild test robot)
Date: Thu, 28 Jan 2016 01:55:07 +0800
Subject: [PATCH v4 07/13] ARM: at91: pm: find and remap the pmc
In-Reply-To: <1453911072-23608-8-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201601280150.dFQRALYG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.5-rc1 next-20160127]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/ARM-at91-PMC-driver-rework/20160128-002052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-at91_dt_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   include/linux/of.h: In function 'at91_pm_init':
>> arch/arm/mach-at91/pm.c:403:40: error: atmel_pmc_ids causes a section type conflict with ramc_ids
    static __initconst struct of_device_id atmel_pmc_ids[] = {
                                           ^
   arch/arm/mach-at91/pm.c:320:40: note: 'ramc_ids' was declared here
    static const struct of_device_id const ramc_ids[] __initconst = {
                                           ^

vim +403 arch/arm/mach-at91/pm.c

   397	
   398		/* Copy the pm suspend handler to SRAM */
   399		at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
   400				&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
   401	}
   402	
 > 403	static __initconst struct of_device_id atmel_pmc_ids[] = {
   404		{ .compatible = "atmel,at91rm9200-pmc"  },
   405		{ .compatible = "atmel,at91sam9260-pmc" },
   406		{ .compatible = "atmel,at91sam9g45-pmc" },

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20315 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/29789832/attachment-0001.obj>
