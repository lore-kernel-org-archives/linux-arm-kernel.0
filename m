From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Jul 2018 15:31:47 +0800
Subject: [PATCH v2 4/8] x86: add support for 64-bit place relative
 relocations
In-Reply-To: <20180702181145.4799-5-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-5-ard.biesheuvel@linaro.org>
Message-ID: <201807031304.9Y2r6crU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-jump-tables/20180703-031712
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

   arch/x86/um/../kernel/module.c: In function 'apply_relocate_add':
>> arch/x86/um/../kernel/module.c:204:8: error: 'R_X86_64_PC64' undeclared (first use in this function); did you mean 'R_X86_64_PC16'?
      case R_X86_64_PC64:
           ^~~~~~~~~~~~~
           R_X86_64_PC16
   arch/x86/um/../kernel/module.c:204:8: note: each undeclared identifier is reported only once for each function it appears in

vim +204 arch/x86/um/../kernel/module.c

    99	
   100	#ifdef CONFIG_X86_32
   101	int apply_relocate(Elf32_Shdr *sechdrs,
   102			   const char *strtab,
   103			   unsigned int symindex,
   104			   unsigned int relsec,
   105			   struct module *me)
   106	{
   107		unsigned int i;
   108		Elf32_Rel *rel = (void *)sechdrs[relsec].sh_addr;
   109		Elf32_Sym *sym;
   110		uint32_t *location;
   111	
   112		DEBUGP("Applying relocate section %u to %u\n",
   113		       relsec, sechdrs[relsec].sh_info);
   114		for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
   115			/* This is where to make the change */
   116			location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
   117				+ rel[i].r_offset;
   118			/* This is the symbol it is referring to.  Note that all
   119			   undefined symbols have been resolved.  */
   120			sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
   121				+ ELF32_R_SYM(rel[i].r_info);
   122	
   123			switch (ELF32_R_TYPE(rel[i].r_info)) {
   124			case R_386_32:
   125				/* We add the value into the location given */
   126				*location += sym->st_value;
   127				break;
   128			case R_386_PC32:
   129				/* Add the value, subtract its position */
   130				*location += sym->st_value - (uint32_t)location;
   131				break;
   132			default:
   133				pr_err("%s: Unknown relocation: %u\n",
   134				       me->name, ELF32_R_TYPE(rel[i].r_info));
   135				return -ENOEXEC;
   136			}
   137		}
   138		return 0;
   139	}
   140	#else /*X86_64*/
   141	int apply_relocate_add(Elf64_Shdr *sechdrs,
   142			   const char *strtab,
   143			   unsigned int symindex,
   144			   unsigned int relsec,
   145			   struct module *me)
   146	{
   147		unsigned int i;
   148		Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
   149		Elf64_Sym *sym;
   150		void *loc;
   151		u64 val;
   152	
   153		DEBUGP("Applying relocate section %u to %u\n",
   154		       relsec, sechdrs[relsec].sh_info);
   155		for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
   156			/* This is where to make the change */
   157			loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
   158				+ rel[i].r_offset;
   159	
   160			/* This is the symbol it is referring to.  Note that all
   161			   undefined symbols have been resolved.  */
   162			sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
   163				+ ELF64_R_SYM(rel[i].r_info);
   164	
   165			DEBUGP("type %d st_value %Lx r_addend %Lx loc %Lx\n",
   166			       (int)ELF64_R_TYPE(rel[i].r_info),
   167			       sym->st_value, rel[i].r_addend, (u64)loc);
   168	
   169			val = sym->st_value + rel[i].r_addend;
   170	
   171			switch (ELF64_R_TYPE(rel[i].r_info)) {
   172			case R_X86_64_NONE:
   173				break;
   174			case R_X86_64_64:
   175				if (*(u64 *)loc != 0)
   176					goto invalid_relocation;
   177				*(u64 *)loc = val;
   178				break;
   179			case R_X86_64_32:
   180				if (*(u32 *)loc != 0)
   181					goto invalid_relocation;
   182				*(u32 *)loc = val;
   183				if (val != *(u32 *)loc)
   184					goto overflow;
   185				break;
   186			case R_X86_64_32S:
   187				if (*(s32 *)loc != 0)
   188					goto invalid_relocation;
   189				*(s32 *)loc = val;
   190				if ((s64)val != *(s32 *)loc)
   191					goto overflow;
   192				break;
   193			case R_X86_64_PC32:
   194			case R_X86_64_PLT32:
   195				if (*(u32 *)loc != 0)
   196					goto invalid_relocation;
   197				val -= (u64)loc;
   198				*(u32 *)loc = val;
   199	#if 0
   200				if ((s64)val != *(s32 *)loc)
   201					goto overflow;
   202	#endif
   203				break;
 > 204			case R_X86_64_PC64:
   205				if (*(u64 *)loc != 0)
   206					goto invalid_relocation;
   207				val -= (u64)loc;
   208				*(u64 *)loc = val;
   209				break;
   210			default:
   211				pr_err("%s: Unknown rela relocation: %llu\n",
   212				       me->name, ELF64_R_TYPE(rel[i].r_info));
   213				return -ENOEXEC;
   214			}
   215		}
   216		return 0;
   217	
   218	invalid_relocation:
   219		pr_err("x86/modules: Skipping invalid relocation target, existing value is nonzero for type %d, loc %p, val %Lx\n",
   220		       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
   221		return -ENOEXEC;
   222	
   223	overflow:
   224		pr_err("overflow in relocation type %d val %Lx\n",
   225		       (int)ELF64_R_TYPE(rel[i].r_info), val);
   226		pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
   227		       me->name);
   228		return -ENOEXEC;
   229	}
   230	#endif
   231	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7562 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/85172ebb/attachment-0001.gz>
