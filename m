From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 Mar 2016 04:05:48 +0800
Subject: [PATCH] sched/kasan: clear stale stack poison
In-Reply-To: <20160301194204.GB335@leverpostej>
Message-ID: <201603020407.MpuzPX1T%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v4.5-rc6 next-20160301]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Rutland/sched-kasan-clear-stale-stack-poison/20160302-034556
config: sparc64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:29:0:
   include/linux/kasan.h:71:53: warning: 'struct task_struct' declared inside parameter list
    static inline void kasan_unpoison_task_stack(struct task_struct *idle) {}
                                                        ^
   include/linux/kasan.h:71:53: warning: its scope is only this definition or declaration, which is probably not what you want
   kernel/sched/core.c: In function 'init_idle':
>> kernel/sched/core.c:5026:2: warning: passing argument 1 of 'kasan_unpoison_task_stack' from incompatible pointer type
     kasan_unpoison_task_stack(idle);
     ^
   In file included from kernel/sched/core.c:29:0:
   include/linux/kasan.h:71:20: note: expected 'struct task_struct *' but argument is of type 'struct task_struct *'
    static inline void kasan_unpoison_task_stack(struct task_struct *idle) {}
                       ^

vim +/kasan_unpoison_task_stack +5026 kernel/sched/core.c

  5010	 *
  5011	 * NOTE: this function does not set the idle thread's NEED_RESCHED
  5012	 * flag, to make booting more robust.
  5013	 */
  5014	void init_idle(struct task_struct *idle, int cpu)
  5015	{
  5016		struct rq *rq = cpu_rq(cpu);
  5017		unsigned long flags;
  5018	
  5019		raw_spin_lock_irqsave(&idle->pi_lock, flags);
  5020		raw_spin_lock(&rq->lock);
  5021	
  5022		__sched_fork(0, idle);
  5023		idle->state = TASK_RUNNING;
  5024		idle->se.exec_start = sched_clock();
  5025	
> 5026		kasan_unpoison_task_stack(idle);
  5027	
  5028	#ifdef CONFIG_SMP
  5029		/*
  5030		 * Its possible that init_idle() gets called multiple times on a task,
  5031		 * in that case do_set_cpus_allowed() will not do the right thing.
  5032		 *
  5033		 * And since this is boot we can forgo the serialization.
  5034		 */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160302/d02ef05f/attachment-0001.obj>
