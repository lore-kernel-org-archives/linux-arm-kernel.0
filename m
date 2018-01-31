From: lkp@intel.com (kbuild test robot)
Date: Wed, 31 Jan 2018 20:12:11 +0800
Subject: [PATCH] arch/arm/Kconfig: enable ARM_MODULE_PLTS when LOCKDEP=y
In-Reply-To: <20180129234900.11121-1-anders.roxell@linaro.org>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
Message-ID: <201801312036.gXYpKLF3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anders,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15 next-20180126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anders-Roxell/arch-arm-Kconfig-enable-ARM_MODULE_PLTS-when-LOCKDEP-y/20180131-115917
config: arm-moxart_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/module-plts.c: In function 'in_init':
>> arch/arm/kernel/module-plts.c:36:23: error: dereferencing pointer to incomplete type 'const struct module'
     return loc - (u32)mod->init_layout.base < mod->init_layout.size;
                          ^~
   arch/arm/kernel/module-plts.c: In function 'get_module_plt':
>> arch/arm/kernel/module-plts.c:41:56: error: dereferencing pointer to incomplete type 'struct module'
     struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
                                                           ^~

vim +36 arch/arm/kernel/module-plts.c

7d485f64 Ard Biesheuvel 2014-11-24  33  
b7ede5a1 Ard Biesheuvel 2017-02-22  34  static bool in_init(const struct module *mod, unsigned long loc)
b7ede5a1 Ard Biesheuvel 2017-02-22  35  {
b7ede5a1 Ard Biesheuvel 2017-02-22 @36  	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
b7ede5a1 Ard Biesheuvel 2017-02-22  37  }
b7ede5a1 Ard Biesheuvel 2017-02-22  38  
7d485f64 Ard Biesheuvel 2014-11-24  39  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
7d485f64 Ard Biesheuvel 2014-11-24  40  {
b7ede5a1 Ard Biesheuvel 2017-02-22 @41  	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
b7ede5a1 Ard Biesheuvel 2017-02-22  42  							  &mod->arch.init;
b7ede5a1 Ard Biesheuvel 2017-02-22  43  
b7ede5a1 Ard Biesheuvel 2017-02-22  44  	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
66e94ba3 Ard Biesheuvel 2016-08-18  45  	int idx = 0;
35fa91ee Ard Biesheuvel 2016-08-16  46  
66e94ba3 Ard Biesheuvel 2016-08-18  47  	/*
66e94ba3 Ard Biesheuvel 2016-08-18  48  	 * Look for an existing entry pointing to 'val'. Given that the
66e94ba3 Ard Biesheuvel 2016-08-18  49  	 * relocations are sorted, this will be the last entry we allocated.
66e94ba3 Ard Biesheuvel 2016-08-18  50  	 * (if one exists).
66e94ba3 Ard Biesheuvel 2016-08-18  51  	 */
b7ede5a1 Ard Biesheuvel 2017-02-22  52  	if (pltsec->plt_count > 0) {
b7ede5a1 Ard Biesheuvel 2017-02-22  53  		plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
b7ede5a1 Ard Biesheuvel 2017-02-22  54  		idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
7d485f64 Ard Biesheuvel 2014-11-24  55  
66e94ba3 Ard Biesheuvel 2016-08-18  56  		if (plt->lit[idx] == val)
66e94ba3 Ard Biesheuvel 2016-08-18  57  			return (u32)&plt->ldr[idx];
66e94ba3 Ard Biesheuvel 2016-08-18  58  
66e94ba3 Ard Biesheuvel 2016-08-18  59  		idx = (idx + 1) % PLT_ENT_COUNT;
66e94ba3 Ard Biesheuvel 2016-08-18  60  		if (!idx)
66e94ba3 Ard Biesheuvel 2016-08-18  61  			plt++;
66e94ba3 Ard Biesheuvel 2016-08-18  62  	}
66e94ba3 Ard Biesheuvel 2016-08-18  63  
b7ede5a1 Ard Biesheuvel 2017-02-22  64  	pltsec->plt_count++;
b7ede5a1 Ard Biesheuvel 2017-02-22  65  	BUG_ON(pltsec->plt_count * PLT_ENT_SIZE > pltsec->plt->sh_size);
7d485f64 Ard Biesheuvel 2014-11-24  66  
66e94ba3 Ard Biesheuvel 2016-08-18  67  	if (!idx)
7d485f64 Ard Biesheuvel 2014-11-24  68  		/* Populate a new set of entries */
7d485f64 Ard Biesheuvel 2014-11-24  69  		*plt = (struct plt_entries){
7d485f64 Ard Biesheuvel 2014-11-24  70  			{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
7d485f64 Ard Biesheuvel 2014-11-24  71  			{ val, }
7d485f64 Ard Biesheuvel 2014-11-24  72  		};
66e94ba3 Ard Biesheuvel 2016-08-18  73  	else
66e94ba3 Ard Biesheuvel 2016-08-18  74  		plt->lit[idx] = val;
66e94ba3 Ard Biesheuvel 2016-08-18  75  
66e94ba3 Ard Biesheuvel 2016-08-18  76  	return (u32)&plt->ldr[idx];
7d485f64 Ard Biesheuvel 2014-11-24  77  }
7d485f64 Ard Biesheuvel 2014-11-24  78  

:::::: The code at line 36 was first introduced by commit
:::::: b7ede5a1f5905ac394cc8e61712a13e3c5cb7b8f ARM: 8662/1: module: split core and init PLT sections

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12748 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180131/58416439/attachment-0001.gz>
