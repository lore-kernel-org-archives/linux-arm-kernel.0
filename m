From: lkp@intel.com (kbuild test robot)
Date: Sat, 15 Sep 2018 10:05:58 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 7/14]
 arch/powerpc/sysdev/ehv_pic.c:191:29: error: dereferencing pointer to
 incomplete type 'struct irq_domain'
Message-ID: <201809151053.9oqsjaRC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   3d1729bd2f533ea8e9cecd34b28ddbfaec819f11
commit: ca2b892913eb5fb9ac9a84cf384a7b4c51b49886 [7/14] irqdomain: Kill irq_domain_add_legacy_isa
config: powerpc-ppc64e_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ca2b892913eb5fb9ac9a84cf384a7b4c51b49886
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/ehv_pic.c: In function 'ehv_pic_get_irq':
>> arch/powerpc/sysdev/ehv_pic.c:177:9: error: implicit declaration of function 'irq_linear_revmap' [-Werror=implicit-function-declaration]
     return irq_linear_revmap(global_ehv_pic->irqhost, irq);
            ^~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/ehv_pic.c: At top level:
   arch/powerpc/sysdev/ehv_pic.c:181:15: error: 'enum irq_domain_bus_token' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
             enum irq_domain_bus_token bus_token)
                  ^~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/sysdev/ehv_pic.c:181:36: error: parameter 3 ('bus_token') has incomplete type
             enum irq_domain_bus_token bus_token)
                                       ^~~~~~~~~
>> arch/powerpc/sysdev/ehv_pic.c:180:12: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node,
               ^~~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/ehv_pic.c: In function 'ehv_pic_host_match':
>> arch/powerpc/sysdev/ehv_pic.c:184:32: error: implicit declaration of function 'irq_domain_get_of_node'; did you mean 'irq_data_get_node'? [-Werror=implicit-function-declaration]
     struct device_node *of_node = irq_domain_get_of_node(h);
                                   ^~~~~~~~~~~~~~~~~~~~~~
                                   irq_data_get_node
>> arch/powerpc/sysdev/ehv_pic.c:184:32: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
   arch/powerpc/sysdev/ehv_pic.c: In function 'ehv_pic_host_map':
>> arch/powerpc/sysdev/ehv_pic.c:191:29: error: dereferencing pointer to incomplete type 'struct irq_domain'
     struct ehv_pic *ehv_pic = h->host_data;
                                ^~
   arch/powerpc/sysdev/ehv_pic.c: At top level:
>> arch/powerpc/sysdev/ehv_pic.c:248:21: error: variable 'ehv_pic_host_ops' has initializer but incomplete type
    static const struct irq_domain_ops ehv_pic_host_ops = {
                        ^~~~~~~~~~~~~~
>> arch/powerpc/sysdev/ehv_pic.c:249:3: error: 'const struct irq_domain_ops' has no member named 'match'
     .match = ehv_pic_host_match,
      ^~~~~
   arch/powerpc/sysdev/ehv_pic.c:249:11: error: excess elements in struct initializer [-Werror]
     .match = ehv_pic_host_match,
              ^~~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/ehv_pic.c:249:11: note: (near initialization for 'ehv_pic_host_ops')
>> arch/powerpc/sysdev/ehv_pic.c:250:3: error: 'const struct irq_domain_ops' has no member named 'map'
     .map = ehv_pic_host_map,
      ^~~
   arch/powerpc/sysdev/ehv_pic.c:250:9: error: excess elements in struct initializer [-Werror]
     .map = ehv_pic_host_map,
            ^~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/ehv_pic.c:250:9: note: (near initialization for 'ehv_pic_host_ops')
>> arch/powerpc/sysdev/ehv_pic.c:251:3: error: 'const struct irq_domain_ops' has no member named 'xlate'
     .xlate = ehv_pic_host_xlate,
      ^~~~~
   arch/powerpc/sysdev/ehv_pic.c:251:11: error: excess elements in struct initializer [-Werror]
     .xlate = ehv_pic_host_xlate,
              ^~~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/ehv_pic.c:251:11: note: (near initialization for 'ehv_pic_host_ops')
   arch/powerpc/sysdev/ehv_pic.c: In function 'ehv_pic_init':
>> arch/powerpc/sysdev/ehv_pic.c:275:21: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
     ehv_pic->irqhost = irq_domain_add_linear(np, NR_EHV_PIC_INTS,
                        ^~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/sysdev/ehv_pic.c:275:19: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
     ehv_pic->irqhost = irq_domain_add_linear(np, NR_EHV_PIC_INTS,
                      ^
>> arch/powerpc/sysdev/ehv_pic.c:297:2: error: implicit declaration of function 'irq_set_default_host'; did you mean 'irq_set_affinity_hint'? [-Werror=implicit-function-declaration]
     irq_set_default_host(global_ehv_pic->irqhost);
     ^~~~~~~~~~~~~~~~~~~~
     irq_set_affinity_hint
   arch/powerpc/sysdev/ehv_pic.c: At top level:
>> arch/powerpc/sysdev/ehv_pic.c:248:36: error: storage size of 'ehv_pic_host_ops' isn't known
    static const struct irq_domain_ops ehv_pic_host_ops = {
                                       ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +191 arch/powerpc/sysdev/ehv_pic.c

3a93261f7 Ashish Kalra     2011-05-19  157  
ef24ba709 Michael Ellerman 2016-09-06  158  /* Return an interrupt vector or 0 if no interrupt is pending. */
3a93261f7 Ashish Kalra     2011-05-19  159  unsigned int ehv_pic_get_irq(void)
3a93261f7 Ashish Kalra     2011-05-19  160  {
3a93261f7 Ashish Kalra     2011-05-19  161  	int irq;
3a93261f7 Ashish Kalra     2011-05-19  162  
3a93261f7 Ashish Kalra     2011-05-19  163  	BUG_ON(global_ehv_pic == NULL);
3a93261f7 Ashish Kalra     2011-05-19  164  
3a93261f7 Ashish Kalra     2011-05-19  165  	if (global_ehv_pic->coreint_flag)
3a93261f7 Ashish Kalra     2011-05-19  166  		irq = mfspr(SPRN_EPR); /* if core int mode */
3a93261f7 Ashish Kalra     2011-05-19  167  	else
3a93261f7 Ashish Kalra     2011-05-19  168  		ev_int_iack(0, &irq); /* legacy mode */
3a93261f7 Ashish Kalra     2011-05-19  169  
3a93261f7 Ashish Kalra     2011-05-19  170  	if (irq == 0xFFFF)    /* 0xFFFF --> no irq is pending */
ef24ba709 Michael Ellerman 2016-09-06  171  		return 0;
3a93261f7 Ashish Kalra     2011-05-19  172  
3a93261f7 Ashish Kalra     2011-05-19  173  	/*
3a93261f7 Ashish Kalra     2011-05-19  174  	 * this will also setup revmap[] in the slow path for the first
3a93261f7 Ashish Kalra     2011-05-19  175  	 * time, next calls will always use fast path by indexing revmap
3a93261f7 Ashish Kalra     2011-05-19  176  	 */
3a93261f7 Ashish Kalra     2011-05-19 @177  	return irq_linear_revmap(global_ehv_pic->irqhost, irq);
3a93261f7 Ashish Kalra     2011-05-19  178  }
3a93261f7 Ashish Kalra     2011-05-19  179  
ad3aedfbb Marc Zyngier     2015-07-28 @180  static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node,
ad3aedfbb Marc Zyngier     2015-07-28 @181  			      enum irq_domain_bus_token bus_token)
3a93261f7 Ashish Kalra     2011-05-19  182  {
3a93261f7 Ashish Kalra     2011-05-19  183  	/* Exact match, unless ehv_pic node is NULL */
5d4c9bc77 Marc Zyngier     2015-10-13 @184  	struct device_node *of_node = irq_domain_get_of_node(h);
5d4c9bc77 Marc Zyngier     2015-10-13  185  	return of_node == NULL || of_node == node;
3a93261f7 Ashish Kalra     2011-05-19  186  }
3a93261f7 Ashish Kalra     2011-05-19  187  
bae1d8f19 Grant Likely     2012-02-14  188  static int ehv_pic_host_map(struct irq_domain *h, unsigned int virq,
3a93261f7 Ashish Kalra     2011-05-19  189  			 irq_hw_number_t hw)
3a93261f7 Ashish Kalra     2011-05-19  190  {
3a93261f7 Ashish Kalra     2011-05-19 @191  	struct ehv_pic *ehv_pic = h->host_data;
3a93261f7 Ashish Kalra     2011-05-19  192  	struct irq_chip *chip;
3a93261f7 Ashish Kalra     2011-05-19  193  
3a93261f7 Ashish Kalra     2011-05-19  194  	/* Default chip */
3a93261f7 Ashish Kalra     2011-05-19  195  	chip = &ehv_pic->hc_irq;
3a93261f7 Ashish Kalra     2011-05-19  196  
3a93261f7 Ashish Kalra     2011-05-19  197  	if (mpic_percpu_base_vaddr)
3a93261f7 Ashish Kalra     2011-05-19  198  		if (hwirq_intspec[hw] & IRQ_TYPE_MPIC_DIRECT)
3a93261f7 Ashish Kalra     2011-05-19  199  			chip = &ehv_pic_direct_eoi_irq_chip;
3a93261f7 Ashish Kalra     2011-05-19  200  
3a93261f7 Ashish Kalra     2011-05-19  201  	irq_set_chip_data(virq, chip);
3a93261f7 Ashish Kalra     2011-05-19  202  	/*
3a93261f7 Ashish Kalra     2011-05-19  203  	 * using handle_fasteoi_irq as our irq handler, this will
3a93261f7 Ashish Kalra     2011-05-19  204  	 * only call the eoi callback and suitable for the MPIC
3a93261f7 Ashish Kalra     2011-05-19  205  	 * controller which set ISR/IPR automatically and clear the
3a93261f7 Ashish Kalra     2011-05-19  206  	 * highest priority active interrupt in ISR/IPR when we do
3a93261f7 Ashish Kalra     2011-05-19  207  	 * a specific eoi
3a93261f7 Ashish Kalra     2011-05-19  208  	 */
3a93261f7 Ashish Kalra     2011-05-19  209  	irq_set_chip_and_handler(virq, chip, handle_fasteoi_irq);
3a93261f7 Ashish Kalra     2011-05-19  210  
3a93261f7 Ashish Kalra     2011-05-19  211  	/* Set default irq type */
3a93261f7 Ashish Kalra     2011-05-19  212  	irq_set_irq_type(virq, IRQ_TYPE_NONE);
3a93261f7 Ashish Kalra     2011-05-19  213  
3a93261f7 Ashish Kalra     2011-05-19  214  	return 0;
3a93261f7 Ashish Kalra     2011-05-19  215  }
3a93261f7 Ashish Kalra     2011-05-19  216  
bae1d8f19 Grant Likely     2012-02-14  217  static int ehv_pic_host_xlate(struct irq_domain *h, struct device_node *ct,
3a93261f7 Ashish Kalra     2011-05-19  218  			   const u32 *intspec, unsigned int intsize,
3a93261f7 Ashish Kalra     2011-05-19  219  			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
3a93261f7 Ashish Kalra     2011-05-19  220  
3a93261f7 Ashish Kalra     2011-05-19  221  {
3a93261f7 Ashish Kalra     2011-05-19  222  	/*
3a93261f7 Ashish Kalra     2011-05-19  223  	 * interrupt sense values coming from the guest device tree
3a93261f7 Ashish Kalra     2011-05-19  224  	 * interrupt specifiers can have four possible sense and
3a93261f7 Ashish Kalra     2011-05-19  225  	 * level encoding information and they need to
3a93261f7 Ashish Kalra     2011-05-19  226  	 * be translated between firmware type & linux type.
3a93261f7 Ashish Kalra     2011-05-19  227  	 */
3a93261f7 Ashish Kalra     2011-05-19  228  
3a93261f7 Ashish Kalra     2011-05-19  229  	static unsigned char map_of_senses_to_linux_irqtype[4] = {
3a93261f7 Ashish Kalra     2011-05-19  230  		IRQ_TYPE_EDGE_FALLING,
3a93261f7 Ashish Kalra     2011-05-19  231  		IRQ_TYPE_EDGE_RISING,
3a93261f7 Ashish Kalra     2011-05-19  232  		IRQ_TYPE_LEVEL_LOW,
3a93261f7 Ashish Kalra     2011-05-19  233  		IRQ_TYPE_LEVEL_HIGH,
3a93261f7 Ashish Kalra     2011-05-19  234  	};
3a93261f7 Ashish Kalra     2011-05-19  235  
3a93261f7 Ashish Kalra     2011-05-19  236  	*out_hwirq = intspec[0];
3a93261f7 Ashish Kalra     2011-05-19  237  	if (intsize > 1) {
3a93261f7 Ashish Kalra     2011-05-19  238  		hwirq_intspec[intspec[0]] = intspec[1];
3a93261f7 Ashish Kalra     2011-05-19  239  		*out_flags = map_of_senses_to_linux_irqtype[intspec[1] &
3a93261f7 Ashish Kalra     2011-05-19  240  							~IRQ_TYPE_MPIC_DIRECT];
3a93261f7 Ashish Kalra     2011-05-19  241  	} else {
3a93261f7 Ashish Kalra     2011-05-19  242  		*out_flags = IRQ_TYPE_NONE;
3a93261f7 Ashish Kalra     2011-05-19  243  	}
3a93261f7 Ashish Kalra     2011-05-19  244  
3a93261f7 Ashish Kalra     2011-05-19  245  	return 0;
3a93261f7 Ashish Kalra     2011-05-19  246  }
3a93261f7 Ashish Kalra     2011-05-19  247  
9f70b8eb3 Grant Likely     2012-01-26 @248  static const struct irq_domain_ops ehv_pic_host_ops = {
3a93261f7 Ashish Kalra     2011-05-19 @249  	.match = ehv_pic_host_match,
3a93261f7 Ashish Kalra     2011-05-19 @250  	.map = ehv_pic_host_map,
3a93261f7 Ashish Kalra     2011-05-19 @251  	.xlate = ehv_pic_host_xlate,
3a93261f7 Ashish Kalra     2011-05-19  252  };
3a93261f7 Ashish Kalra     2011-05-19  253  
3a93261f7 Ashish Kalra     2011-05-19  254  void __init ehv_pic_init(void)
3a93261f7 Ashish Kalra     2011-05-19  255  {
3a93261f7 Ashish Kalra     2011-05-19  256  	struct device_node *np, *np2;
3a93261f7 Ashish Kalra     2011-05-19  257  	struct ehv_pic *ehv_pic;
3a93261f7 Ashish Kalra     2011-05-19  258  	int coreint_flag = 1;
3a93261f7 Ashish Kalra     2011-05-19  259  
3a93261f7 Ashish Kalra     2011-05-19  260  	np = of_find_compatible_node(NULL, NULL, "epapr,hv-pic");
3a93261f7 Ashish Kalra     2011-05-19  261  	if (!np) {
3a93261f7 Ashish Kalra     2011-05-19  262  		pr_err("ehv_pic_init: could not find epapr,hv-pic node\n");
3a93261f7 Ashish Kalra     2011-05-19  263  		return;
3a93261f7 Ashish Kalra     2011-05-19  264  	}
3a93261f7 Ashish Kalra     2011-05-19  265  
3a93261f7 Ashish Kalra     2011-05-19  266  	if (!of_find_property(np, "has-external-proxy", NULL))
3a93261f7 Ashish Kalra     2011-05-19  267  		coreint_flag = 0;
3a93261f7 Ashish Kalra     2011-05-19  268  
3a93261f7 Ashish Kalra     2011-05-19  269  	ehv_pic = kzalloc(sizeof(struct ehv_pic), GFP_KERNEL);
3a93261f7 Ashish Kalra     2011-05-19  270  	if (!ehv_pic) {
3a93261f7 Ashish Kalra     2011-05-19  271  		of_node_put(np);
3a93261f7 Ashish Kalra     2011-05-19  272  		return;
3a93261f7 Ashish Kalra     2011-05-19  273  	}
3a93261f7 Ashish Kalra     2011-05-19  274  
a8db8cf0d Grant Likely     2012-02-14 @275  	ehv_pic->irqhost = irq_domain_add_linear(np, NR_EHV_PIC_INTS,
a8db8cf0d Grant Likely     2012-02-14  276  						 &ehv_pic_host_ops, ehv_pic);
3a93261f7 Ashish Kalra     2011-05-19  277  	if (!ehv_pic->irqhost) {
3a93261f7 Ashish Kalra     2011-05-19  278  		of_node_put(np);
e3854b6e2 Julia Lawall     2011-08-08  279  		kfree(ehv_pic);
3a93261f7 Ashish Kalra     2011-05-19  280  		return;
3a93261f7 Ashish Kalra     2011-05-19  281  	}
3a93261f7 Ashish Kalra     2011-05-19  282  
3a93261f7 Ashish Kalra     2011-05-19  283  	np2 = of_find_compatible_node(NULL, NULL, "fsl,hv-mpic-per-cpu");
3a93261f7 Ashish Kalra     2011-05-19  284  	if (np2) {
3a93261f7 Ashish Kalra     2011-05-19  285  		mpic_percpu_base_vaddr = of_iomap(np2, 0);
3a93261f7 Ashish Kalra     2011-05-19  286  		if (!mpic_percpu_base_vaddr)
3a93261f7 Ashish Kalra     2011-05-19  287  			pr_err("ehv_pic_init: of_iomap failed\n");
3a93261f7 Ashish Kalra     2011-05-19  288  
3a93261f7 Ashish Kalra     2011-05-19  289  		of_node_put(np2);
3a93261f7 Ashish Kalra     2011-05-19  290  	}
3a93261f7 Ashish Kalra     2011-05-19  291  
3a93261f7 Ashish Kalra     2011-05-19  292  	ehv_pic->hc_irq = ehv_pic_irq_chip;
3a93261f7 Ashish Kalra     2011-05-19  293  	ehv_pic->hc_irq.irq_set_affinity = ehv_pic_set_affinity;
3a93261f7 Ashish Kalra     2011-05-19  294  	ehv_pic->coreint_flag = coreint_flag;
3a93261f7 Ashish Kalra     2011-05-19  295  
3a93261f7 Ashish Kalra     2011-05-19  296  	global_ehv_pic = ehv_pic;
3a93261f7 Ashish Kalra     2011-05-19 @297  	irq_set_default_host(global_ehv_pic->irqhost);

:::::: The code at line 191 was first introduced by commit
:::::: 3a93261f70c7b92f84fb211b66f1d4e66c0b3dce powerpc: introduce the ePAPR embedded hypervisor vmpic driver

:::::: TO: Ashish Kalra <ashish.kalra@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21092 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180915/e81a231f/attachment-0001.gz>
