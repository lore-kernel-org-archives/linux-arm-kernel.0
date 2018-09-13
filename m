From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Sep 2018 06:06:41 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 10/14]
 kernel//irq/irqdesc.c:648:9: error: implicit declaration of function
 'generic_handle_domain_irq'; did you mean '__handle_domain_irq'?
Message-ID: <201809140638.vjOrVbpk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   7d998f9af090acce9f3cef3ef2c6de074f6a1875
commit: da7a26c53511b2e690a8a335fff97d3afc07db0c [10/14] irqdesc: Make __handle_domain_irq use irq_data instead of irq numbers
config: mips-mips_paravirt_defconfig (attached as .config)
compiler: mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout da7a26c53511b2e690a8a335fff97d3afc07db0c
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   kernel//irq/irqdesc.c: In function '__handle_domain_irq':
>> kernel//irq/irqdesc.c:648:9: error: implicit declaration of function 'generic_handle_domain_irq'; did you mean '__handle_domain_irq'? [-Werror=implicit-function-declaration]
      ret = generic_handle_domain_irq(domain, hwirq);
            ^~~~~~~~~~~~~~~~~~~~~~~~~
            __handle_domain_irq
   cc1: some warnings being treated as errors

vim +648 kernel//irq/irqdesc.c

   628	
   629	#ifdef CONFIG_HANDLE_DOMAIN_IRQ
   630	/**
   631	 * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain
   632	 * @domain:	The domain where to perform the lookup
   633	 * @hwirq:	The HW irq number to convert to a logical one
   634	 * @lookup:	Whether to perform the domain lookup or not
   635	 * @regs:	Register file coming from the low-level handling code
   636	 *
   637	 * Returns:	0 on success, or -EINVAL if conversion has failed
   638	 */
   639	int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
   640				bool lookup, struct pt_regs *regs)
   641	{
   642		struct pt_regs *old_regs = set_irq_regs(regs);
   643		int ret;
   644	
   645		irq_enter();
   646	
   647		if (IS_ENABLED(CONFIG_IRQ_DOMAIN) && lookup)
 > 648			ret = generic_handle_domain_irq(domain, hwirq);
   649		else
   650			ret = generic_handle_irq(hwirq);
   651	
   652		/*
   653		 * Some hardware gives randomly wrong interrupts.  Rather
   654		 * than crashing, do something sensible.
   655		 */
   656		if (unlikely(ret))
   657			ack_bad_irq(hwirq);
   658	
   659		irq_exit();
   660		set_irq_regs(old_regs);
   661		return ret;
   662	}
   663	#endif
   664	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11668 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180914/f0372513/attachment-0001.gz>
