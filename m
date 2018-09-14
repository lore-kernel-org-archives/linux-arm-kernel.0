From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Sep 2018 18:43:42 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 12/13]
 drivers//irqchip/irq-keystone.c:109:4: error: 'ret' undeclared; did you mean
 'rseq'?
Message-ID: <201809141839.vRQEyjGT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   878c6d8883cfc2fc6f8e557f61e13765449fa2f1
commit: bf0e815fd99bf71a4f6fc78eb5c2fc5de751c192 [12/13] irqdomain: Generalize usage of generic_handle_domain_irq
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bf0e815fd99bf71a4f6fc78eb5c2fc5de751c192
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers//irqchip/irq-keystone.c: In function 'keystone_irq_handler':
>> drivers//irqchip/irq-keystone.c:109:4: error: 'ret' undeclared (first use in this function); did you mean 'rseq'?
       ret = generic_handle_domain_irq(kirq->irqd, src);
       ^~~
       rseq
   drivers//irqchip/irq-keystone.c:109:4: note: each undeclared identifier is reported only once for each function it appears in

vim +109 drivers//irqchip/irq-keystone.c

    86	
    87	static irqreturn_t keystone_irq_handler(int irq, void *keystone_irq)
    88	{
    89		struct keystone_irq_device *kirq = keystone_irq;
    90		unsigned long wa_lock_flags;
    91		unsigned long pending;
    92		int src;
    93	
    94		dev_dbg(kirq->dev, "start irq %d\n", irq);
    95	
    96		pending = keystone_irq_readl(kirq);
    97		keystone_irq_writel(kirq, pending);
    98	
    99		dev_dbg(kirq->dev, "pending 0x%lx, mask 0x%x\n", pending, kirq->mask);
   100	
   101		pending = (pending >> BIT_OFS) & ~kirq->mask;
   102	
   103		dev_dbg(kirq->dev, "pending after mask 0x%lx\n", pending);
   104	
   105		for (src = 0; src < KEYSTONE_N_IRQ; src++) {
   106			if (BIT(src) & pending) {
   107				dev_dbg(kirq->dev, "dispatch bit %d\n", src);
   108				raw_spin_lock_irqsave(&kirq->wa_lock, wa_lock_flags);
 > 109				ret = generic_handle_domain_irq(kirq->irqd, src);
   110				raw_spin_unlock_irqrestore(&kirq->wa_lock,
   111							   wa_lock_flags);
   112				if (ret)
   113					dev_warn(kirq->dev, "spurious irq detected hwirq %d\n",
   114						 src);
   115			}
   116		}
   117	
   118		dev_dbg(kirq->dev, "end irq %d\n", irq);
   119		return IRQ_HANDLED;
   120	}
   121	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44389 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180914/b13096fa/attachment-0001.gz>
