From: lkp@intel.com (kbuild test robot)
Date: Thu, 31 Mar 2016 00:33:54 +0800
Subject: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
In-Reply-To: <1459353210-20260-6-git-send-email-pmladek@suse.com>
Message-ID: <201603310000.dKufp7mg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

[auto build test ERROR on v4.6-rc1]
[cannot apply to tip/x86/core next-20160330]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20160330-235818
config: i386-randconfig-s1-201613 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/printk/nmi.c: In function 'printk_nmi_flush_on_panic':
>> kernel/printk/nmi.c:218:4: error: implicit declaration of function 'debug_locks_off' [-Werror=implicit-function-declaration]
       debug_locks_off();
       ^
   cc1: some warnings being treated as errors

vim +/debug_locks_off +218 kernel/printk/nmi.c

   212			 * Do not risk a double release when more CPUs are up.
   213			 */
   214			if (raw_spin_is_locked(&logbuf_lock)) {
   215				if (num_online_cpus() > 1)
   216					return;
   217	
 > 218				debug_locks_off();
   219				raw_spin_lock_init(&logbuf_lock);
   220			}
   221	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27512 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/9b73021e/attachment-0001.obj>
