From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 18 Oct 2017 19:25:45 +0800
Subject: [arm-platforms:irq/irqchip-4.15 7/19]
 drivers/irqchip/irq-gic-v3.c:577:4: note: in expansion of macro 'pr_crit'
Message-ID: <201710181942.2M01lPyt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.15
head:   0beae24927562ef40a444409d2a9a0d162a18ae7
commit: 0de6aeba71c72a84dfc47568fc68ec187ac4537c [7/19] irqchip/gicv3: Add support for Range Selector (RS) feature
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0de6aeba71c72a84dfc47568fc68ec187ac4537c
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/irqchip/irq-gic-v3.c:20:
   drivers/irqchip/irq-gic-v3.c: In function 'gic_cpu_sys_reg_init':
>> include/linux/kern_levels.h:4:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'u32 {aka unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:9:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_CRIT KERN_SOH "2" /* critical conditions */
                      ^~~~~~~~
>> include/linux/printk.h:299:9: note: in expansion of macro 'KERN_CRIT'
     printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
>> drivers/irqchip/irq-gic-v3.c:577:4: note: in expansion of macro 'pr_crit'
       pr_crit("CPU%d (%llx) can't SGI CPU%d (%llx), no RSS\n",
       ^~~~~~~
--
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers//irqchip/irq-gic-v3.c:20:
   drivers//irqchip/irq-gic-v3.c: In function 'gic_cpu_sys_reg_init':
>> include/linux/kern_levels.h:4:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'u32 {aka unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:9:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_CRIT KERN_SOH "2" /* critical conditions */
                      ^~~~~~~~
>> include/linux/printk.h:299:9: note: in expansion of macro 'KERN_CRIT'
     printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
   drivers//irqchip/irq-gic-v3.c:577:4: note: in expansion of macro 'pr_crit'
       pr_crit("CPU%d (%llx) can't SGI CPU%d (%llx), no RSS\n",
       ^~~~~~~

vim +/pr_crit +577 drivers/irqchip/irq-gic-v3.c

   529	
   530	static void gic_cpu_sys_reg_init(void)
   531	{
   532		int i, cpu = smp_processor_id();
   533		u64 mpidr = cpu_logical_map(cpu);
   534		u64 need_rss = MPIDR_RS(mpidr);
   535	
   536		/*
   537		 * Need to check that the SRE bit has actually been set. If
   538		 * not, it means that SRE is disabled at EL2. We're going to
   539		 * die painfully, and there is nothing we can do about it.
   540		 *
   541		 * Kindly inform the luser.
   542		 */
   543		if (!gic_enable_sre())
   544			pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
   545	
   546		/* Set priority mask register */
   547		gic_write_pmr(DEFAULT_PMR_VALUE);
   548	
   549		/*
   550		 * Some firmwares hand over to the kernel with the BPR changed from
   551		 * its reset value (and with a value large enough to prevent
   552		 * any pre-emptive interrupts from working at all). Writing a zero
   553		 * to BPR restores is reset value.
   554		 */
   555		gic_write_bpr1(0);
   556	
   557		if (static_key_true(&supports_deactivate)) {
   558			/* EOI drops priority only (mode 1) */
   559			gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop);
   560		} else {
   561			/* EOI deactivates interrupt too (mode 0) */
   562			gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
   563		}
   564	
   565		/* ... and let's hit the road... */
   566		gic_write_grpen1(1);
   567	
   568		/* Keep the RSS capability status in per_cpu variable */
   569		per_cpu(has_rss, cpu) = !!(gic_read_ctlr() & ICC_CTLR_EL1_RSS);
   570	
   571		/* Check all the CPUs have capable of sending SGIs to other CPUs */
   572		for_each_online_cpu(i) {
   573			bool have_rss = per_cpu(has_rss, i) && per_cpu(has_rss, cpu);
   574	
   575			need_rss |= MPIDR_RS(cpu_logical_map(i));
   576			if (need_rss && (!have_rss))
 > 577				pr_crit("CPU%d (%llx) can't SGI CPU%d (%llx), no RSS\n",
   578					cpu, mpidr, i, cpu_logical_map(i));
   579		}
   580	
   581		/**
   582		 * GIC spec says, when ICC_CTLR_EL1.RSS==1 and GICD_TYPER.RSS==0,
   583		 * writing ICC_ASGI1R_EL1 register with RS != 0 is a CONSTRAINED
   584		 * UNPREDICTABLE choice of :
   585		 *   - The write is ignored.
   586		 *   - The RS field is treated as 0.
   587		 */
   588		if (need_rss && (!gic_data.has_rss))
   589			pr_crit_once("RSS is required but GICD doesn't support it\n");
   590	}
   591	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42224 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/c08668b9/attachment-0001.gz>
