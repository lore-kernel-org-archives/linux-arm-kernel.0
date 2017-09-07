From: lkp@intel.com (kbuild test robot)
Date: Fri, 8 Sep 2017 02:01:08 +0800
Subject: [PATCH v3 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20170906003016.2159-2-brendanhiggins@google.com>
Message-ID: <201709080102.sovqCRiS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brendan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13 next-20170907]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Brendan-Higgins/arm-npcm-add-basic-support-for-Nuvoton-BMCs/20170907-214055
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/delay.h:21,
                    from arch/arm/mach-npcm/platsmp.c:11:
   arch/arm/mach-npcm/platsmp.c: In function 'npcm7xx_smp_boot_secondary':
>> include/linux/kern_levels.h:4:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'void *' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:10:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:301:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
>> arch/arm/mach-npcm/platsmp.c:43:3: note: in expansion of macro 'pr_err'
      pr_err("could not iomap gcr at: 0x%llx\n", gcr_base);
      ^~~~~~
   arch/arm/mach-npcm/platsmp.c: In function 'npcm7xx_smp_prepare_cpus':
>> include/linux/kern_levels.h:4:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'void *' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:10:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:301:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   arch/arm/mach-npcm/platsmp.c:74:3: note: in expansion of macro 'pr_err'
      pr_err("could not iomap scu at: 0x%llx\n", scu_base);
      ^~~~~~
   arch/arm/mach-npcm/platsmp.c:80:1: warning: label 'out' defined but not used [-Wunused-label]
    out:
    ^~~
   In file included from include/linux/io.h:25:0,
                    from arch/arm/mach-npcm/platsmp.c:14:
   arch/arm/mach-npcm/platsmp.c: In function 'npcm7xx_smp_boot_secondary':
>> arch/arm/include/asm/io.h:421:17: warning: 'gcr_base' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define iounmap iounmap
                    ^~~~~~~
   arch/arm/mach-npcm/platsmp.c:32:16: note: 'gcr_base' was declared here
     void __iomem *gcr_base;
                   ^~~~~~~~

vim +/pr_err +43 arch/arm/mach-npcm/platsmp.c

    27	
    28	static int npcm7xx_smp_boot_secondary(unsigned int cpu,
    29					      struct task_struct *idle)
    30	{
    31		struct device_node *gcr_np;
    32		void __iomem *gcr_base;
    33		int ret = 0;
    34	
    35		gcr_np = of_find_compatible_node(NULL, NULL, "nuvoton,npcm750-gcr");
    36		if (!gcr_np) {
    37			pr_err("no gcr device node\n");
    38			ret = -EFAULT;
    39			goto out;
    40		}
    41		gcr_base = of_iomap(gcr_np, 0);
    42		if (!gcr_base) {
  > 43			pr_err("could not iomap gcr at: 0x%llx\n", gcr_base);
    44			ret = -EFAULT;
    45			goto out;
    46		}
    47	
    48		/* give boot ROM kernel start address. */
    49		iowrite32(__pa_symbol(npcm7xx_secondary_startup), gcr_base +
    50			  NPCM7XX_SCRPAD_REG);
    51		/* make sure npcm7xx_secondary_startup is seen by all observers. */
    52		smp_wmb();
    53		dsb_sev();
    54		/* make sure write buffer is drained */
    55		mb();
    56	
    57	out:
    58		iounmap(gcr_base);
    59		return ret;
    60	}
    61	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/5e718398/attachment-0001.gz>
