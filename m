From: lkp@intel.com (kbuild test robot)
Date: Wed, 24 Oct 2018 03:32:11 +0800
Subject: [PATCH] arm64/module: use mod->klp_info section header information
In-Reply-To: <20181023175553.gaobskk26koft6s2@linux-8ccs>
References: <20181023175553.gaobskk26koft6s2@linux-8ccs>
Message-ID: <201810240304.xBI18Icm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jessica,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/arm64-module-use-mod-klp_info-section-header-information/20181024-023709
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: x86_64-randconfig-x002-201842 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   kernel/module.c: In function 'post_relocation':
>> kernel/module.c:3369:30: warning: passing argument 2 of 'copy_module_elf' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      err = copy_module_elf(mod, info);
                                 ^~~~
   kernel/module.c:2103:12: note: expected 'struct load_info *' but argument is of type 'const struct load_info *'
    static int copy_module_elf(struct module *mod, struct load_info *info)
               ^~~~~~~~~~~~~~~

vim +3369 kernel/module.c

  3353	
  3354	static int post_relocation(struct module *mod, const struct load_info *info)
  3355	{
  3356		int err;
  3357	
  3358		/* Sort exception table now relocations are done. */
  3359		sort_extable(mod->extable, mod->extable + mod->num_exentries);
  3360	
  3361		/* Copy relocated percpu area over. */
  3362		percpu_modcopy(mod, (void *)info->sechdrs[info->index.pcpu].sh_addr,
  3363			       info->sechdrs[info->index.pcpu].sh_size);
  3364	
  3365		/* Setup kallsyms-specific fields. */
  3366		add_kallsyms(mod, info);
  3367	
  3368		if (is_livepatch_module(mod)) {
> 3369			err = copy_module_elf(mod, info);
  3370			if (err < 0)
  3371				return err;
  3372		}
  3373	
  3374		/* Arch-specific module finalizing. */
  3375		err = module_finalize(info->hdr, info->sechdrs, mod);
  3376		if (err < 0)
  3377			free_module_elf(mod);
  3378	
  3379		return err;
  3380	}
  3381	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31980 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181024/ea28058b/attachment-0001.gz>
