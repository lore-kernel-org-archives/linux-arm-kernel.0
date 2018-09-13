From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 20:32:53 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 12/12]
 arch/nios2/kernel/irq.c:36:2: error: implicit declaration of function
 'generic_handle_domain_irq'; did you mean 'generic_handle_irq'?
Message-ID: <201809132046.7C9LyZSM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   82c6e1da4fdbb691540bd5240c900a93dfba1fd1
commit: 82c6e1da4fdbb691540bd5240c900a93dfba1fd1 [12/12] nios2: Don't include irqdomain.h from asm/irq.h
config: nios2-10m50_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 82c6e1da4fdbb691540bd5240c900a93dfba1fd1
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=nios2 

All error/warnings (new ones prefixed by >>):

   arch/nios2/kernel/irq.c: In function 'do_IRQ':
>> arch/nios2/kernel/irq.c:36:2: error: implicit declaration of function 'generic_handle_domain_irq'; did you mean 'generic_handle_irq'? [-Werror=implicit-function-declaration]
     generic_handle_domain_irq(NULL, hwirq);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
     generic_handle_irq
   arch/nios2/kernel/irq.c: At top level:
>> arch/nios2/kernel/irq.c:68:21: error: variable 'irq_ops' has initializer but incomplete type
    static const struct irq_domain_ops irq_ops = {
                        ^~~~~~~~~~~~~~
>> arch/nios2/kernel/irq.c:69:3: error: 'const struct irq_domain_ops' has no member named 'map'
     .map = irq_map,
      ^~~
>> arch/nios2/kernel/irq.c:69:9: warning: excess elements in struct initializer
     .map = irq_map,
            ^~~~~~~
   arch/nios2/kernel/irq.c:69:9: note: (near initialization for 'irq_ops')
>> arch/nios2/kernel/irq.c:70:3: error: 'const struct irq_domain_ops' has no member named 'xlate'
     .xlate = irq_domain_xlate_onecell,
      ^~~~~
>> arch/nios2/kernel/irq.c:70:11: error: 'irq_domain_xlate_onecell' undeclared here (not in a function); did you mean 'irq_domain_chip_generic'?
     .xlate = irq_domain_xlate_onecell,
              ^~~~~~~~~~~~~~~~~~~~~~~~
              irq_domain_chip_generic
   arch/nios2/kernel/irq.c:70:11: warning: excess elements in struct initializer
   arch/nios2/kernel/irq.c:70:11: note: (near initialization for 'irq_ops')
   arch/nios2/kernel/irq.c: In function 'init_IRQ':
>> arch/nios2/kernel/irq.c:84:11: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
     domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
              ^~~~~~~~~~~~~~~~~~~~~
>> arch/nios2/kernel/irq.c:84:9: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
            ^
>> arch/nios2/kernel/irq.c:87:2: error: implicit declaration of function 'irq_set_default_host'; did you mean 'irq_set_affinity_hint'? [-Werror=implicit-function-declaration]
     irq_set_default_host(domain);
     ^~~~~~~~~~~~~~~~~~~~
     irq_set_affinity_hint
   arch/nios2/kernel/irq.c: At top level:
>> arch/nios2/kernel/irq.c:68:36: error: storage size of 'irq_ops' isn't known
    static const struct irq_domain_ops irq_ops = {
                                       ^~~~~~~
   cc1: some warnings being treated as errors

vim +36 arch/nios2/kernel/irq.c

f27ffc75 Ley Foon Tan   2014-11-06  30  
f27ffc75 Ley Foon Tan   2014-11-06  31  asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
f27ffc75 Ley Foon Tan   2014-11-06  32  {
f27ffc75 Ley Foon Tan   2014-11-06  33  	struct pt_regs *oldregs = set_irq_regs(regs);
f27ffc75 Ley Foon Tan   2014-11-06  34  
f27ffc75 Ley Foon Tan   2014-11-06  35  	irq_enter();
7e11e7e9 Marc Zyngier   2018-09-13 @36  	generic_handle_domain_irq(NULL, hwirq);
f27ffc75 Ley Foon Tan   2014-11-06  37  	irq_exit();
f27ffc75 Ley Foon Tan   2014-11-06  38  
f27ffc75 Ley Foon Tan   2014-11-06  39  	set_irq_regs(oldregs);
f27ffc75 Ley Foon Tan   2014-11-06  40  }
f27ffc75 Ley Foon Tan   2014-11-06  41  
f27ffc75 Ley Foon Tan   2014-11-06  42  static void chip_unmask(struct irq_data *d)
f27ffc75 Ley Foon Tan   2014-11-06  43  {
f27ffc75 Ley Foon Tan   2014-11-06  44  	ienable |= (1 << d->hwirq);
f27ffc75 Ley Foon Tan   2014-11-06  45  	WRCTL(CTL_IENABLE, ienable);
f27ffc75 Ley Foon Tan   2014-11-06  46  }
f27ffc75 Ley Foon Tan   2014-11-06  47  
f27ffc75 Ley Foon Tan   2014-11-06  48  static void chip_mask(struct irq_data *d)
f27ffc75 Ley Foon Tan   2014-11-06  49  {
f27ffc75 Ley Foon Tan   2014-11-06  50  	ienable &= ~(1 << d->hwirq);
f27ffc75 Ley Foon Tan   2014-11-06  51  	WRCTL(CTL_IENABLE, ienable);
f27ffc75 Ley Foon Tan   2014-11-06  52  }
f27ffc75 Ley Foon Tan   2014-11-06  53  
f27ffc75 Ley Foon Tan   2014-11-06  54  static struct irq_chip m_irq_chip = {
f27ffc75 Ley Foon Tan   2014-11-06  55  	.name		= "NIOS2-INTC",
f27ffc75 Ley Foon Tan   2014-11-06  56  	.irq_unmask	= chip_unmask,
f27ffc75 Ley Foon Tan   2014-11-06  57  	.irq_mask	= chip_mask,
f27ffc75 Ley Foon Tan   2014-11-06  58  };
f27ffc75 Ley Foon Tan   2014-11-06  59  
f27ffc75 Ley Foon Tan   2014-11-06  60  static int irq_map(struct irq_domain *h, unsigned int virq,
f27ffc75 Ley Foon Tan   2014-11-06  61  				irq_hw_number_t hw_irq_num)
f27ffc75 Ley Foon Tan   2014-11-06  62  {
f27ffc75 Ley Foon Tan   2014-11-06  63  	irq_set_chip_and_handler(virq, &m_irq_chip, handle_level_irq);
f27ffc75 Ley Foon Tan   2014-11-06  64  
f27ffc75 Ley Foon Tan   2014-11-06  65  	return 0;
f27ffc75 Ley Foon Tan   2014-11-06  66  }
f27ffc75 Ley Foon Tan   2014-11-06  67  
57ac76ed Tobias Klauser 2017-04-02 @68  static const struct irq_domain_ops irq_ops = {
f27ffc75 Ley Foon Tan   2014-11-06 @69  	.map	= irq_map,
f27ffc75 Ley Foon Tan   2014-11-06 @70  	.xlate	= irq_domain_xlate_onecell,
f27ffc75 Ley Foon Tan   2014-11-06  71  };
f27ffc75 Ley Foon Tan   2014-11-06  72  
f27ffc75 Ley Foon Tan   2014-11-06  73  void __init init_IRQ(void)
f27ffc75 Ley Foon Tan   2014-11-06  74  {
f27ffc75 Ley Foon Tan   2014-11-06  75  	struct irq_domain *domain;
f27ffc75 Ley Foon Tan   2014-11-06  76  	struct device_node *node;
f27ffc75 Ley Foon Tan   2014-11-06  77  
f27ffc75 Ley Foon Tan   2014-11-06  78  	node = of_find_compatible_node(NULL, NULL, "altr,nios2-1.0");
f27ffc75 Ley Foon Tan   2014-11-06  79  	if (!node)
f27ffc75 Ley Foon Tan   2014-11-06  80  		node = of_find_compatible_node(NULL, NULL, "altr,nios2-1.1");
f27ffc75 Ley Foon Tan   2014-11-06  81  
f27ffc75 Ley Foon Tan   2014-11-06  82  	BUG_ON(!node);
f27ffc75 Ley Foon Tan   2014-11-06  83  
f27ffc75 Ley Foon Tan   2014-11-06 @84  	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
f27ffc75 Ley Foon Tan   2014-11-06  85  	BUG_ON(!domain);
f27ffc75 Ley Foon Tan   2014-11-06  86  
f27ffc75 Ley Foon Tan   2014-11-06 @87  	irq_set_default_host(domain);

:::::: The code at line 36 was first introduced by commit
:::::: 7e11e7e9f09a4b0b3369fb4af96d8d377557c88c More generic_handle_domain_irq use

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 9646 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/0df317e4/attachment.gz>
