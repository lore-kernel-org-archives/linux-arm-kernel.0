From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 4 Oct 2017 19:56:12 +0800
Subject: [arm64:for-next/core 8/11] arch/arm64/kernel/setup.c:247:10: error:
 implicit declaration of function 'init_utsname'
Message-ID: <201710041909.9ayqjprI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
head:   03d1315cf115bfae05f3f70a5c1b3256cbb5613d
commit: 374f1b872ff597b11b96b3c1f06accf72d246668 [8/11] arm64: consistently log boot/secondary CPU IDs
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 374f1b872ff597b11b96b3c1f06accf72d246668
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/setup.c: In function 'setup_arch':
>> arch/arm64/kernel/setup.c:247:10: error: implicit declaration of function 'init_utsname' [-Werror=implicit-function-declaration]
     sprintf(init_utsname()->machine, UTS_MACHINE);
             ^~~~~~~~~~~~
>> arch/arm64/kernel/setup.c:247:24: error: invalid type argument of '->' (have 'int')
     sprintf(init_utsname()->machine, UTS_MACHINE);
                           ^~
>> arch/arm64/kernel/setup.c:247:35: error: 'UTS_MACHINE' undeclared (first use in this function)
     sprintf(init_utsname()->machine, UTS_MACHINE);
                                      ^~~~~~~~~~~
   arch/arm64/kernel/setup.c:247:35: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/init_utsname +247 arch/arm64/kernel/setup.c

   244	
   245	void __init setup_arch(char **cmdline_p)
   246	{
 > 247		sprintf(init_utsname()->machine, UTS_MACHINE);
   248		init_mm.start_code = (unsigned long) _text;
   249		init_mm.end_code   = (unsigned long) _etext;
   250		init_mm.end_data   = (unsigned long) _edata;
   251		init_mm.brk	   = (unsigned long) _end;
   252	
   253		*cmdline_p = boot_command_line;
   254	
   255		early_fixmap_init();
   256		early_ioremap_init();
   257	
   258		setup_machine_fdt(__fdt_pointer);
   259	
   260		parse_early_param();
   261	
   262		/*
   263		 *  Unmask asynchronous aborts after bringing up possible earlycon.
   264		 * (Report possible System Errors once we can report this occurred)
   265		 */
   266		local_async_enable();
   267	
   268		/*
   269		 * TTBR0 is only used for the identity mapping at this stage. Make it
   270		 * point to zero page to avoid speculatively fetching new entries.
   271		 */
   272		cpu_uninstall_idmap();
   273	
   274		xen_early_init();
   275		efi_init();
   276		arm64_memblock_init();
   277	
   278		paging_init();
   279	
   280		acpi_table_upgrade();
   281	
   282		/* Parse the ACPI tables for possible boot-time configuration */
   283		acpi_boot_table_init();
   284	
   285		if (acpi_disabled)
   286			unflatten_device_tree();
   287	
   288		bootmem_init();
   289	
   290		kasan_init();
   291	
   292		request_standard_resources();
   293	
   294		early_ioremap_reset();
   295	
   296		if (acpi_disabled)
   297			psci_dt_init();
   298		else
   299			psci_acpi_init();
   300	
   301		cpu_read_bootcpu_ops();
   302		smp_init_cpus();
   303		smp_build_mpidr_hash();
   304	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36749 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/843e93fd/attachment-0001.gz>
