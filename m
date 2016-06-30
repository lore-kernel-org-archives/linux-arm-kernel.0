From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 18:14:30 +0800
Subject: [arm-platforms:irq/irqchip-4.8 16/17]
 drivers/irqchip/irq-gic.c:101:2: error: implicit declaration of function
 'raw_spin_lock_irqrestore'
Message-ID: <201606301829.16okLsBB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.8
head:   f3e9ce36e639f247425f72b4866909367441b4c8
commit: 7e7426522047645e9b02d9f8eaf4911c3cc1388f [16/17] irqchip: gic: Make locking a BL_SWITCHER only feature
config: arm-exynos_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7e7426522047645e9b02d9f8eaf4911c3cc1388f
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/irqchip/irq-gic.c: In function 'gic_set_affinity':
>> drivers/irqchip/irq-gic.c:101:2: error: implicit declaration of function 'raw_spin_lock_irqrestore' [-Werror=implicit-function-declaration]
     raw_spin_lock_irqrestore(&cpu_map_lock, (f))
     ^
>> drivers/irqchip/irq-gic.c:345:2: note: in expansion of macro 'gic_unlock_irqrestore'
     gic_unlock_irqrestore(flags);
     ^
   cc1: some warnings being treated as errors

vim +/raw_spin_lock_irqrestore +101 drivers/irqchip/irq-gic.c

    95	
    96	static DEFINE_RAW_SPINLOCK(cpu_map_lock);
    97	
    98	#define gic_lock_irqsave(f)		\
    99		raw_spin_lock_irqsave(&cpu_map_lock, (f))
   100	#define gic_unlock_irqrestore(f)	\
 > 101		raw_spin_lock_irqrestore(&cpu_map_lock, (f))
   102	
   103	#define gic_lock()			raw_spin_lock(&cpu_map_lock)
   104	#define gic_unlock()			raw_spin_unlock(&cpu_map_lock)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24944 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/c534140c/attachment-0001.obj>
