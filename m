From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 13 Sep 2016 01:37:06 +0800
Subject: [arm-platforms:irq/irqchip-4.9 1/3]
 drivers/irqchip/irq-gic.c:100:34: error: implicit declaration of function
 'raw_spin_lock_irqrestore'
Message-ID: <201609130104.OJL5PDok%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.9
head:   7aaa3012a3d487cb852fd9ace4359e3994b05bad
commit: 05189a8d2fbddc41cb8b7b56f781430651ac8dd4 [1/3] irqchip: gic: Make locking a BL_SWITCHER only feature
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 05189a8d2fbddc41cb8b7b56f781430651ac8dd4
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/irqchip/irq-gic.c: In function 'gic_set_affinity':
>> drivers/irqchip/irq-gic.c:100:34: error: implicit declaration of function 'raw_spin_lock_irqrestore' [-Werror=implicit-function-declaration]
    #define gic_unlock_irqrestore(f) raw_spin_lock_irqrestore(&cpu_map_lock,\
                                     ^
>> drivers/irqchip/irq-gic.c:345:2: note: in expansion of macro 'gic_unlock_irqrestore'
     gic_unlock_irqrestore(flags);
     ^
   cc1: some warnings being treated as errors

vim +/raw_spin_lock_irqrestore +100 drivers/irqchip/irq-gic.c

    94	#ifdef CONFIG_BL_SWITCHER
    95	
    96	static DEFINE_RAW_SPINLOCK(cpu_map_lock);
    97	
    98	#define gic_lock_irqsave(f)		raw_spin_lock_irqsave(&cpu_map_lock,\
    99								      (f))
 > 100	#define gic_unlock_irqrestore(f)	raw_spin_lock_irqrestore(&cpu_map_lock,\
   101									 (f))
   102	
   103	#define gic_lock()			raw_spin_lock(&cpu_map_lock)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58520 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160913/9ee9aa59/attachment-0001.obj>
