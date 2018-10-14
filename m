From: lkp@intel.com (kbuild test robot)
Date: Mon, 15 Oct 2018 02:44:49 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 9/31]
 arch/powerpc/platforms/embedded6xx/flipper-pic.c:105:27: error:
 dereferencing pointer to incomplete type 'struct irq_domain'
Message-ID: <201810150223.enne2IJU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   5b674d6b7f6dac3d673db524bd832ba18176007a
commit: ddd13e2b41ae70bca2eb283c6e2dc0f45a836ff3 [9/31] powerpc: Convert irq_domain_add_legacy_isa use to irq_domain_add_legacy
config: powerpc-gamecube_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ddd13e2b41ae70bca2eb283c6e2dc0f45a836ff3
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_map':
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:105:27: error: dereferencing pointer to incomplete type 'struct irq_domain'
     irq_set_chip_data(virq, h->host_data);
                              ^~
   arch/powerpc/platforms/embedded6xx/flipper-pic.c: At top level:
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:111:21: error: variable 'flipper_irq_domain_ops' has initializer but incomplete type
    static const struct irq_domain_ops flipper_irq_domain_ops = {
                        ^~~~~~~~~~~~~~
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:112:3: error: 'const struct irq_domain_ops' has no member named 'map'
     .map = flipper_pic_map,
      ^~~
   arch/powerpc/platforms/embedded6xx/flipper-pic.c:112:9: error: excess elements in struct initializer [-Werror]
     .map = flipper_pic_map,
            ^~~~~~~~~~~~~~~
   arch/powerpc/platforms/embedded6xx/flipper-pic.c:112:9: note: (near initialization for 'flipper_irq_domain_ops')
   arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_init':
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:156:15: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
     irq_domain = irq_domain_add_linear(np, FLIPPER_NR_IRQS,
                  ^~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:156:13: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
     irq_domain = irq_domain_add_linear(np, FLIPPER_NR_IRQS,
                ^
   arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_get_irq':
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:179:9: error: implicit declaration of function 'irq_linear_revmap' [-Werror=implicit-function-declaration]
     return irq_linear_revmap(flipper_irq_host, irq);
            ^~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_probe':
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:197:2: error: implicit declaration of function 'irq_set_default_host'; did you mean 'irq_setup_alt_chip'? [-Werror=implicit-function-declaration]
     irq_set_default_host(flipper_irq_host);
     ^~~~~~~~~~~~~~~~~~~~
     irq_setup_alt_chip
   arch/powerpc/platforms/embedded6xx/flipper-pic.c: At top level:
>> arch/powerpc/platforms/embedded6xx/flipper-pic.c:111:36: error: storage size of 'flipper_irq_domain_ops' isn't known
    static const struct irq_domain_ops flipper_irq_domain_ops = {
                                       ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +105 arch/powerpc/platforms/embedded6xx/flipper-pic.c

028ee972 Albert Herranz    2009-12-12  101  
bae1d8f1 Grant Likely      2012-02-14  102  static int flipper_pic_map(struct irq_domain *h, unsigned int virq,
028ee972 Albert Herranz    2009-12-12  103  			   irq_hw_number_t hwirq)
028ee972 Albert Herranz    2009-12-12  104  {
ec775d0e Thomas Gleixner   2011-03-25 @105  	irq_set_chip_data(virq, h->host_data);
98488db9 Thomas Gleixner   2011-03-25  106  	irq_set_status_flags(virq, IRQ_LEVEL);
ec775d0e Thomas Gleixner   2011-03-25  107  	irq_set_chip_and_handler(virq, &flipper_pic, handle_level_irq);
028ee972 Albert Herranz    2009-12-12  108  	return 0;
028ee972 Albert Herranz    2009-12-12  109  }
028ee972 Albert Herranz    2009-12-12  110  
9f70b8eb Grant Likely      2012-01-26 @111  static const struct irq_domain_ops flipper_irq_domain_ops = {
028ee972 Albert Herranz    2009-12-12 @112  	.map = flipper_pic_map,
028ee972 Albert Herranz    2009-12-12  113  };
028ee972 Albert Herranz    2009-12-12  114  
028ee972 Albert Herranz    2009-12-12  115  /*
028ee972 Albert Herranz    2009-12-12  116   * Platform hooks.
028ee972 Albert Herranz    2009-12-12  117   *
028ee972 Albert Herranz    2009-12-12  118   */
028ee972 Albert Herranz    2009-12-12  119  
028ee972 Albert Herranz    2009-12-12  120  static void __flipper_quiesce(void __iomem *io_base)
028ee972 Albert Herranz    2009-12-12  121  {
028ee972 Albert Herranz    2009-12-12  122  	/* mask and ack all IRQs */
028ee972 Albert Herranz    2009-12-12  123  	out_be32(io_base + FLIPPER_IMR, 0x00000000);
028ee972 Albert Herranz    2009-12-12  124  	out_be32(io_base + FLIPPER_ICR, 0xffffffff);
028ee972 Albert Herranz    2009-12-12  125  }
028ee972 Albert Herranz    2009-12-12  126  
8b51e679 Mathieu Malaterre 2018-02-25  127  static struct irq_domain * __init flipper_pic_init(struct device_node *np)
028ee972 Albert Herranz    2009-12-12  128  {
028ee972 Albert Herranz    2009-12-12  129  	struct device_node *pi;
bae1d8f1 Grant Likely      2012-02-14  130  	struct irq_domain *irq_domain = NULL;
028ee972 Albert Herranz    2009-12-12  131  	struct resource res;
028ee972 Albert Herranz    2009-12-12  132  	void __iomem *io_base;
028ee972 Albert Herranz    2009-12-12  133  	int retval;
028ee972 Albert Herranz    2009-12-12  134  
028ee972 Albert Herranz    2009-12-12  135  	pi = of_get_parent(np);
028ee972 Albert Herranz    2009-12-12  136  	if (!pi) {
028ee972 Albert Herranz    2009-12-12  137  		pr_err("no parent found\n");
028ee972 Albert Herranz    2009-12-12  138  		goto out;
028ee972 Albert Herranz    2009-12-12  139  	}
028ee972 Albert Herranz    2009-12-12  140  	if (!of_device_is_compatible(pi, "nintendo,flipper-pi")) {
028ee972 Albert Herranz    2009-12-12  141  		pr_err("unexpected parent compatible\n");
028ee972 Albert Herranz    2009-12-12  142  		goto out;
028ee972 Albert Herranz    2009-12-12  143  	}
028ee972 Albert Herranz    2009-12-12  144  
028ee972 Albert Herranz    2009-12-12  145  	retval = of_address_to_resource(pi, 0, &res);
028ee972 Albert Herranz    2009-12-12  146  	if (retval) {
028ee972 Albert Herranz    2009-12-12  147  		pr_err("no io memory range found\n");
028ee972 Albert Herranz    2009-12-12  148  		goto out;
028ee972 Albert Herranz    2009-12-12  149  	}
028ee972 Albert Herranz    2009-12-12  150  	io_base = ioremap(res.start, resource_size(&res));
028ee972 Albert Herranz    2009-12-12  151  
028ee972 Albert Herranz    2009-12-12  152  	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
028ee972 Albert Herranz    2009-12-12  153  
028ee972 Albert Herranz    2009-12-12  154  	__flipper_quiesce(io_base);
028ee972 Albert Herranz    2009-12-12  155  
a8db8cf0 Grant Likely      2012-02-14 @156  	irq_domain = irq_domain_add_linear(np, FLIPPER_NR_IRQS,
a8db8cf0 Grant Likely      2012-02-14  157  				  &flipper_irq_domain_ops, io_base);
bae1d8f1 Grant Likely      2012-02-14  158  	if (!irq_domain) {
bae1d8f1 Grant Likely      2012-02-14  159  		pr_err("failed to allocate irq_domain\n");
028ee972 Albert Herranz    2009-12-12  160  		return NULL;
028ee972 Albert Herranz    2009-12-12  161  	}
028ee972 Albert Herranz    2009-12-12  162  
028ee972 Albert Herranz    2009-12-12  163  out:
bae1d8f1 Grant Likely      2012-02-14  164  	return irq_domain;
028ee972 Albert Herranz    2009-12-12  165  }
028ee972 Albert Herranz    2009-12-12  166  
028ee972 Albert Herranz    2009-12-12  167  unsigned int flipper_pic_get_irq(void)
028ee972 Albert Herranz    2009-12-12  168  {
6d166fec Paul Gortmaker    2012-02-22  169  	void __iomem *io_base = flipper_irq_host->host_data;
028ee972 Albert Herranz    2009-12-12  170  	int irq;
028ee972 Albert Herranz    2009-12-12  171  	u32 irq_status;
028ee972 Albert Herranz    2009-12-12  172  
028ee972 Albert Herranz    2009-12-12  173  	irq_status = in_be32(io_base + FLIPPER_ICR) &
028ee972 Albert Herranz    2009-12-12  174  		     in_be32(io_base + FLIPPER_IMR);
028ee972 Albert Herranz    2009-12-12  175  	if (irq_status == 0)
ef24ba70 Michael Ellerman  2016-09-06  176  		return 0;	/* no more IRQs pending */
028ee972 Albert Herranz    2009-12-12  177  
028ee972 Albert Herranz    2009-12-12  178  	irq = __ffs(irq_status);
6d166fec Paul Gortmaker    2012-02-22 @179  	return irq_linear_revmap(flipper_irq_host, irq);
028ee972 Albert Herranz    2009-12-12  180  }
028ee972 Albert Herranz    2009-12-12  181  
028ee972 Albert Herranz    2009-12-12  182  /*
028ee972 Albert Herranz    2009-12-12  183   * Probe function.
028ee972 Albert Herranz    2009-12-12  184   *
028ee972 Albert Herranz    2009-12-12  185   */
028ee972 Albert Herranz    2009-12-12  186  
028ee972 Albert Herranz    2009-12-12  187  void __init flipper_pic_probe(void)
028ee972 Albert Herranz    2009-12-12  188  {
028ee972 Albert Herranz    2009-12-12  189  	struct device_node *np;
028ee972 Albert Herranz    2009-12-12  190  
028ee972 Albert Herranz    2009-12-12  191  	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-pic");
028ee972 Albert Herranz    2009-12-12  192  	BUG_ON(!np);
028ee972 Albert Herranz    2009-12-12  193  
6d166fec Paul Gortmaker    2012-02-22  194  	flipper_irq_host = flipper_pic_init(np);
028ee972 Albert Herranz    2009-12-12  195  	BUG_ON(!flipper_irq_host);
028ee972 Albert Herranz    2009-12-12  196  
028ee972 Albert Herranz    2009-12-12 @197  	irq_set_default_host(flipper_irq_host);
028ee972 Albert Herranz    2009-12-12  198  
028ee972 Albert Herranz    2009-12-12  199  	of_node_put(np);
028ee972 Albert Herranz    2009-12-12  200  }
028ee972 Albert Herranz    2009-12-12  201  

:::::: The code at line 105 was first introduced by commit
:::::: ec775d0e70eb6b7116406b3441cb8501c2849dd2 powerpc: Convert to new irq_* function names

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11534 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/4a5f000a/attachment-0001.gz>
