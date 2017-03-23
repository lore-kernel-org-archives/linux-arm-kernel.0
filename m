From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Mar 2017 14:18:34 +0800
Subject: [PATCH] genirq: Notify clients whenever there is change in
 affinity
In-Reply-To: <1490027777-29130-2-git-send-email-psodagud@codeaurora.org>
Message-ID: <201703231444.06qWwK1u%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasad,

[auto build test WARNING on tip/irq/core]
[also build test WARNING on v4.11-rc3 next-20170322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Prasad-Sodagudi/genirq-Notify-clients-whenever-there-is-change-in-affinity/20170323-094431
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> kernel/irq/migration.c:46:36: sparse: not enough arguments for function irq_do_set_affinity
   kernel/irq/migration.c: In function 'irq_move_masked_irq':
   kernel/irq/migration.c:46:3: error: too few arguments to function 'irq_do_set_affinity'
      irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
      ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/irq/migration.c:5:0:
   kernel/irq/internals.h:116:12: note: declared here
    extern int irq_do_set_affinity(struct irq_data *data,
               ^~~~~~~~~~~~~~~~~~~

vim +46 kernel/irq/migration.c

c777ac55 Andrew Morton     2006-03-25  30  
239007b8 Thomas Gleixner   2009-11-17  31  	assert_raw_spin_locked(&desc->lock);
501f2499 Bryan Holty       2006-03-25  32  
c777ac55 Andrew Morton     2006-03-25  33  	/*
c777ac55 Andrew Morton     2006-03-25  34  	 * If there was a valid mask to work with, please
c777ac55 Andrew Morton     2006-03-25  35  	 * do the disable, re-program, enable sequence.
c777ac55 Andrew Morton     2006-03-25  36  	 * This is *not* particularly important for level triggered
c777ac55 Andrew Morton     2006-03-25  37  	 * but in a edge trigger case, we might be setting rte
25985edc Lucas De Marchi   2011-03-30  38  	 * when an active trigger is coming in. This could
c777ac55 Andrew Morton     2006-03-25  39  	 * cause some ioapics to mal-function.
c777ac55 Andrew Morton     2006-03-25  40  	 * Being paranoid i guess!
e7b946e9 Eric W. Biederman 2006-10-04  41  	 *
e7b946e9 Eric W. Biederman 2006-10-04  42  	 * For correct operation this depends on the caller
e7b946e9 Eric W. Biederman 2006-10-04  43  	 * masking the irqs.
c777ac55 Andrew Morton     2006-03-25  44  	 */
818b0f3b Jiang Liu         2012-03-30  45  	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids)
818b0f3b Jiang Liu         2012-03-30 @46  		irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
57b150cc Yinghai Lu        2009-04-27  47  
7f7ace0c Mike Travis       2009-01-10  48  	cpumask_clear(desc->pending_mask);
e7b946e9 Eric W. Biederman 2006-10-04  49  }
e7b946e9 Eric W. Biederman 2006-10-04  50  
a439520f Thomas Gleixner   2011-02-04  51  void irq_move_irq(struct irq_data *idata)
e7b946e9 Eric W. Biederman 2006-10-04  52  {
f1a06390 Thomas Gleixner   2011-01-28  53  	bool masked;
e7b946e9 Eric W. Biederman 2006-10-04  54  

:::::: The code at line 46 was first introduced by commit
:::::: 818b0f3bfb236ae66cac3ff38e86b9e47f24b7aa genirq: Introduce irq_do_set_affinity() to reduce duplicated code

:::::: TO: Jiang Liu <liuj97@gmail.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
