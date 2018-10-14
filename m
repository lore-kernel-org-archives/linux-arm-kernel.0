From: lkp@intel.com (kbuild test robot)
Date: Sun, 14 Oct 2018 23:27:12 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 5/31]
 drivers/watchdog/octeon-wdt-main.c:324:9: error: implicit declaration of
 function 'irq_find_mapping'; did you mean 'qid_has_mapping'?
Message-ID: <201810142348.k25huktZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   5b674d6b7f6dac3d673db524bd832ba18176007a
commit: 61ea5635f5bee04180917c7ec55fd1987a3f0ddd [5/31] MIPS: Do not include linux/irqdomain.h from asm/irq.h
config: mips-cavium_octeon_defconfig (attached as .config)
compiler: mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61ea5635f5bee04180917c7ec55fd1987a3f0ddd
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/watchdog/octeon-wdt-main.c: In function 'octeon_wdt_cpu_to_irq':
>> drivers/watchdog/octeon-wdt-main.c:324:9: error: implicit declaration of function 'irq_find_mapping'; did you mean 'qid_has_mapping'? [-Werror=implicit-function-declaration]
      irq = irq_find_mapping(domain, hwirq);
            ^~~~~~~~~~~~~~~~
            qid_has_mapping
   drivers/watchdog/octeon-wdt-main.c: In function 'octeon_wdt_cpu_online':
>> drivers/watchdog/octeon-wdt-main.c:378:9: error: implicit declaration of function 'irq_create_mapping'; did you mean 'qid_has_mapping'? [-Werror=implicit-function-declaration]
      irq = irq_create_mapping(domain, hwirq);
            ^~~~~~~~~~~~~~~~~~
            qid_has_mapping
   cc1: some warnings being treated as errors

vim +324 drivers/watchdog/octeon-wdt-main.c

1d1821b2 Carlos Munoz              2017-08-29  307  
1d1821b2 Carlos Munoz              2017-08-29  308  static int octeon_wdt_cpu_to_irq(int cpu)
1d1821b2 Carlos Munoz              2017-08-29  309  {
1d1821b2 Carlos Munoz              2017-08-29  310  	unsigned int coreid;
1d1821b2 Carlos Munoz              2017-08-29  311  	int node;
1d1821b2 Carlos Munoz              2017-08-29  312  	int irq;
1d1821b2 Carlos Munoz              2017-08-29  313  
1d1821b2 Carlos Munoz              2017-08-29  314  	coreid = cpu2core(cpu);
1d1821b2 Carlos Munoz              2017-08-29  315  	node = cpu_to_node(cpu);
1d1821b2 Carlos Munoz              2017-08-29  316  
1d1821b2 Carlos Munoz              2017-08-29  317  	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
1d1821b2 Carlos Munoz              2017-08-29  318  		struct irq_domain *domain;
1d1821b2 Carlos Munoz              2017-08-29  319  		int hwirq;
1d1821b2 Carlos Munoz              2017-08-29  320  
1d1821b2 Carlos Munoz              2017-08-29  321  		domain = octeon_irq_get_block_domain(node,
1d1821b2 Carlos Munoz              2017-08-29  322  						     WD_BLOCK_NUMBER);
1d1821b2 Carlos Munoz              2017-08-29  323  		hwirq = WD_BLOCK_NUMBER << 12 | 0x200 | coreid;
1d1821b2 Carlos Munoz              2017-08-29 @324  		irq = irq_find_mapping(domain, hwirq);
1d1821b2 Carlos Munoz              2017-08-29  325  	} else {
1d1821b2 Carlos Munoz              2017-08-29  326  		irq = OCTEON_IRQ_WDOG0 + coreid;
1d1821b2 Carlos Munoz              2017-08-29  327  	}
1d1821b2 Carlos Munoz              2017-08-29  328  	return irq;
4c076fb4 David Daney               2010-07-24  329  }
4c076fb4 David Daney               2010-07-24  330  
948b9c60 Sebastian Andrzej Siewior 2016-11-17  331  static int octeon_wdt_cpu_pre_down(unsigned int cpu)
4c076fb4 David Daney               2010-07-24  332  {
4c076fb4 David Daney               2010-07-24  333  	unsigned int core;
1d1821b2 Carlos Munoz              2017-08-29  334  	int node;
4c076fb4 David Daney               2010-07-24  335  	union cvmx_ciu_wdogx ciu_wdog;
4c076fb4 David Daney               2010-07-24  336  
4c076fb4 David Daney               2010-07-24  337  	core = cpu2core(cpu);
4c076fb4 David Daney               2010-07-24  338  
1d1821b2 Carlos Munoz              2017-08-29  339  	node = cpu_to_node(cpu);
4c076fb4 David Daney               2010-07-24  340  
4c076fb4 David Daney               2010-07-24  341  	/* Poke the watchdog to clear out its state */
1d1821b2 Carlos Munoz              2017-08-29  342  	cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
4c076fb4 David Daney               2010-07-24  343  
4c076fb4 David Daney               2010-07-24  344  	/* Disable the hardware. */
4c076fb4 David Daney               2010-07-24  345  	ciu_wdog.u64 = 0;
1d1821b2 Carlos Munoz              2017-08-29  346  	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
4c076fb4 David Daney               2010-07-24  347  
1d1821b2 Carlos Munoz              2017-08-29  348  	free_irq(octeon_wdt_cpu_to_irq(cpu), octeon_wdt_poke_irq);
948b9c60 Sebastian Andrzej Siewior 2016-11-17  349  	return 0;
4c076fb4 David Daney               2010-07-24  350  }
4c076fb4 David Daney               2010-07-24  351  
948b9c60 Sebastian Andrzej Siewior 2016-11-17  352  static int octeon_wdt_cpu_online(unsigned int cpu)
4c076fb4 David Daney               2010-07-24  353  {
4c076fb4 David Daney               2010-07-24  354  	unsigned int core;
4c076fb4 David Daney               2010-07-24  355  	unsigned int irq;
4c076fb4 David Daney               2010-07-24  356  	union cvmx_ciu_wdogx ciu_wdog;
1d1821b2 Carlos Munoz              2017-08-29  357  	int node;
1d1821b2 Carlos Munoz              2017-08-29  358  	struct irq_domain *domain;
1d1821b2 Carlos Munoz              2017-08-29  359  	int hwirq;
4c076fb4 David Daney               2010-07-24  360  
4c076fb4 David Daney               2010-07-24  361  	core = cpu2core(cpu);
1d1821b2 Carlos Munoz              2017-08-29  362  	node = cpu_to_node(cpu);
4c076fb4 David Daney               2010-07-24  363  
49d148b4 Steven J. Hill            2017-08-29  364  	octeon_wdt_bootvector[core].target_ptr = (u64)octeon_wdt_nmi_stage2;
49d148b4 Steven J. Hill            2017-08-29  365  
4c076fb4 David Daney               2010-07-24  366  	/* Disable it before doing anything with the interrupts. */
4c076fb4 David Daney               2010-07-24  367  	ciu_wdog.u64 = 0;
1d1821b2 Carlos Munoz              2017-08-29  368  	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
4c076fb4 David Daney               2010-07-24  369  
4c076fb4 David Daney               2010-07-24  370  	per_cpu_countdown[cpu] = countdown_reset;
4c076fb4 David Daney               2010-07-24  371  
1d1821b2 Carlos Munoz              2017-08-29  372  	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
1d1821b2 Carlos Munoz              2017-08-29  373  		/* Must get the domain for the watchdog block */
1d1821b2 Carlos Munoz              2017-08-29  374  		domain = octeon_irq_get_block_domain(node, WD_BLOCK_NUMBER);
1d1821b2 Carlos Munoz              2017-08-29  375  
1d1821b2 Carlos Munoz              2017-08-29  376  		/* Get a irq for the wd intsn (hardware interrupt) */
1d1821b2 Carlos Munoz              2017-08-29  377  		hwirq = WD_BLOCK_NUMBER << 12 | 0x200 | core;
1d1821b2 Carlos Munoz              2017-08-29 @378  		irq = irq_create_mapping(domain, hwirq);
1d1821b2 Carlos Munoz              2017-08-29  379  		irqd_set_trigger_type(irq_get_irq_data(irq),
1d1821b2 Carlos Munoz              2017-08-29  380  				      IRQ_TYPE_EDGE_RISING);
1d1821b2 Carlos Munoz              2017-08-29  381  	} else
4c076fb4 David Daney               2010-07-24  382  		irq = OCTEON_IRQ_WDOG0 + core;
4c076fb4 David Daney               2010-07-24  383  
4c076fb4 David Daney               2010-07-24  384  	if (request_irq(irq, octeon_wdt_poke_irq,
47bfd058 Venkat Subbiah            2011-10-03  385  			IRQF_NO_THREAD, "octeon_wdt", octeon_wdt_poke_irq))
4c076fb4 David Daney               2010-07-24  386  		panic("octeon_wdt: Couldn't obtain irq %d", irq);
4c076fb4 David Daney               2010-07-24  387  
1d1821b2 Carlos Munoz              2017-08-29  388  	/* Must set the irq affinity here */
1d1821b2 Carlos Munoz              2017-08-29  389  	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
1d1821b2 Carlos Munoz              2017-08-29  390  		cpumask_t mask;
1d1821b2 Carlos Munoz              2017-08-29  391  
1d1821b2 Carlos Munoz              2017-08-29  392  		cpumask_clear(&mask);
1d1821b2 Carlos Munoz              2017-08-29  393  		cpumask_set_cpu(cpu, &mask);
1d1821b2 Carlos Munoz              2017-08-29  394  		irq_set_affinity(irq, &mask);
1d1821b2 Carlos Munoz              2017-08-29  395  	}
1d1821b2 Carlos Munoz              2017-08-29  396  
4c076fb4 David Daney               2010-07-24  397  	cpumask_set_cpu(cpu, &irq_enabled_cpus);
4c076fb4 David Daney               2010-07-24  398  
4c076fb4 David Daney               2010-07-24  399  	/* Poke the watchdog to clear out its state */
1d1821b2 Carlos Munoz              2017-08-29  400  	cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
4c076fb4 David Daney               2010-07-24  401  
4c076fb4 David Daney               2010-07-24  402  	/* Finally enable the watchdog now that all handlers are installed */
4c076fb4 David Daney               2010-07-24  403  	ciu_wdog.u64 = 0;
4c076fb4 David Daney               2010-07-24  404  	ciu_wdog.s.len = timeout_cnt;
4c076fb4 David Daney               2010-07-24  405  	ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
1d1821b2 Carlos Munoz              2017-08-29  406  	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
4c076fb4 David Daney               2010-07-24  407  
948b9c60 Sebastian Andrzej Siewior 2016-11-17  408  	return 0;
4c076fb4 David Daney               2010-07-24  409  }
4c076fb4 David Daney               2010-07-24  410  

:::::: The code at line 324 was first introduced by commit
:::::: 1d1821b20d4a3ed9d0abf063014776979e6822dc watchdog: octeon-wdt: Add support for 78XX SOCs.

:::::: TO: Carlos Munoz <carlos.munoz@caviumnetworks.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16718 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181014/077303b1/attachment-0001.gz>
