From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 21:58:09 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 5/12]
 arch/powerpc/sysdev/fsl_mpic_err.c:116:17: error: implicit declaration of
 function 'irq_linear_revmap'
Message-ID: <201809132104.A0T71LnM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   1cd5475f4e5ee8d056a26731de9ef22f941775b4
commit: dcf82fd21b0681fb1aed451940eb125e36213d08 [5/12] irqdomain: Kill irq_domain_add_legacy_isa
config: powerpc-ksi8560_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dcf82fd21b0681fb1aed451940eb125e36213d08
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/fsl_mpic_err.c: In function 'fsl_error_int_handler':
>> arch/powerpc/sysdev/fsl_mpic_err.c:116:17: error: implicit declaration of function 'irq_linear_revmap' [-Werror=implicit-function-declaration]
      cascade_irq = irq_linear_revmap(mpic->irqhost,
                    ^~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/fsl_mpic_err.c: In function 'mpic_err_int_init':
>> arch/powerpc/sysdev/fsl_mpic_err.c:136:9: error: implicit declaration of function 'irq_create_mapping'; did you mean 'irq_set_parent'? [-Werror=implicit-function-declaration]
     virq = irq_create_mapping(mpic->irqhost, irqnum);
            ^~~~~~~~~~~~~~~~~~
            irq_set_parent
   cc1: all warnings being treated as errors

vim +/irq_linear_revmap +116 arch/powerpc/sysdev/fsl_mpic_err.c

0a4081641 Varun Sethi      2012-08-08  100  
0a4081641 Varun Sethi      2012-08-08  101  static irqreturn_t fsl_error_int_handler(int irq, void *data)
0a4081641 Varun Sethi      2012-08-08  102  {
0a4081641 Varun Sethi      2012-08-08  103  	struct mpic *mpic = (struct mpic *) data;
0a4081641 Varun Sethi      2012-08-08  104  	u32 eisr, eimr;
0a4081641 Varun Sethi      2012-08-08  105  	int errint;
0a4081641 Varun Sethi      2012-08-08  106  	unsigned int cascade_irq;
0a4081641 Varun Sethi      2012-08-08  107  
0a4081641 Varun Sethi      2012-08-08  108  	eisr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EISR);
0a4081641 Varun Sethi      2012-08-08  109  	eimr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
0a4081641 Varun Sethi      2012-08-08  110  
0a4081641 Varun Sethi      2012-08-08  111  	if (!(eisr & ~eimr))
0a4081641 Varun Sethi      2012-08-08  112  		return IRQ_NONE;
0a4081641 Varun Sethi      2012-08-08  113  
0a4081641 Varun Sethi      2012-08-08  114  	while (eisr) {
0a4081641 Varun Sethi      2012-08-08  115  		errint = __builtin_clz(eisr);
0a4081641 Varun Sethi      2012-08-08 @116  		cascade_irq = irq_linear_revmap(mpic->irqhost,
0a4081641 Varun Sethi      2012-08-08  117  				 mpic->err_int_vecs[errint]);
ef24ba709 Michael Ellerman 2016-09-06  118  		WARN_ON(!cascade_irq);
ef24ba709 Michael Ellerman 2016-09-06  119  		if (cascade_irq) {
0a4081641 Varun Sethi      2012-08-08  120  			generic_handle_irq(cascade_irq);
0a4081641 Varun Sethi      2012-08-08  121  		} else {
0a4081641 Varun Sethi      2012-08-08  122  			eimr |=  1 << (31 - errint);
0a4081641 Varun Sethi      2012-08-08  123  			mpic_fsl_err_write(mpic->err_regs, eimr);
0a4081641 Varun Sethi      2012-08-08  124  		}
0a4081641 Varun Sethi      2012-08-08  125  		eisr &= ~(1 << (31 - errint));
0a4081641 Varun Sethi      2012-08-08  126  	}
0a4081641 Varun Sethi      2012-08-08  127  
0a4081641 Varun Sethi      2012-08-08  128  	return IRQ_HANDLED;
0a4081641 Varun Sethi      2012-08-08  129  }
0a4081641 Varun Sethi      2012-08-08  130  
0a4081641 Varun Sethi      2012-08-08  131  void mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
0a4081641 Varun Sethi      2012-08-08  132  {
0a4081641 Varun Sethi      2012-08-08  133  	unsigned int virq;
0a4081641 Varun Sethi      2012-08-08  134  	int ret;
0a4081641 Varun Sethi      2012-08-08  135  
0a4081641 Varun Sethi      2012-08-08 @136  	virq = irq_create_mapping(mpic->irqhost, irqnum);

:::::: The code at line 116 was first introduced by commit
:::::: 0a4081641d722d3dee140505a86330ecf44db0fe powerpc/mpic: FSL MPIC error interrupt support.

:::::: TO: Varun Sethi <Varun.Sethi@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11673 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/adfe97f6/attachment-0001.gz>
