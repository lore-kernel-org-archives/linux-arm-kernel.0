From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Mar 2017 10:33:19 +0800
Subject: [PATCH] genirq: Notify clients whenever there is change in
 affinity
In-Reply-To: <1490027777-29130-2-git-send-email-psodagud@codeaurora.org>
Message-ID: <201703231023.IdopmGoq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasad,

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.11-rc3 next-20170322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Prasad-Sodagudi/genirq-Notify-clients-whenever-there-is-change-in-affinity/20170323-094431
config: x86_64-randconfig-x015-201712 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   kernel/irq/migration.c: In function 'irq_move_masked_irq':
>> kernel/irq/migration.c:46:3: error: too few arguments to function 'irq_do_set_affinity'
      irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
      ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/irq/migration.c:5:0:
   kernel/irq/internals.h:116:12: note: declared here
    extern int irq_do_set_affinity(struct irq_data *data,
               ^~~~~~~~~~~~~~~~~~~

vim +/irq_do_set_affinity +46 kernel/irq/migration.c

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

:::::: The code at line 46 was first introduced by commit
:::::: 818b0f3bfb236ae66cac3ff38e86b9e47f24b7aa genirq: Introduce irq_do_set_affinity() to reduce duplicated code

:::::: TO: Jiang Liu <liuj97@gmail.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25930 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170323/57d9c433/attachment-0001.gz>
