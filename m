From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Sep 2015 13:35:25 +0800
Subject: [PATCH v5 04/23] arm64: change some CONFIG_COMPAT over to use
 CONFIG_AARCH32_EL0 instead
In-Reply-To: <1443564860-31208-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201509301338.uv8BrsnC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm64-allmodconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout 4035143523cbf0106ee81f3ea585b363110c1ab6
  # save the attached .config to linux build tree
  make.cross ARCH=arm64 

Note: the linux-review/Yury-Norov/ILP32-for-ARM64 HEAD 3dd1a64760c74c774056fb5635ff933762dd6453 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/elf.h:4:0,
                    from include/linux/module.h:15,
                    from fs/ocfs2/dlm/dlmdomain.c:27:
>> arch/arm64/include/asm/elf.h:202:0: warning: "compat_elf_check_arch" redefined
    #define compat_elf_check_arch(x) compat_a32_elf_check_arch(x)
    ^
   arch/arm64/include/asm/elf.h:179:0: note: this is the location of the previous definition
    #define compat_elf_check_arch(x) (((x)->e_machine == EM_ARM) && \
    ^
   In file included from include/linux/elf.h:4:0,
                    from include/linux/module.h:15,
                    from fs/ocfs2/dlm/dlmdomain.c:27:
>> arch/arm64/include/asm/elf.h:202:0: warning: "compat_elf_check_arch" redefined
    #define compat_elf_check_arch(x) compat_a32_elf_check_arch(x)
    ^
   arch/arm64/include/asm/elf.h:179:0: note: this is the location of the previous definition
    #define compat_elf_check_arch(x) (((x)->e_machine == EM_ARM) && \
    ^
--
   In file included from include/linux/elf.h:4:0,
                    from include/linux/module.h:15,
                    from fs/ocfs2/dlm/dlmthread.c:28:
>> arch/arm64/include/asm/elf.h:202:0: warning: "compat_elf_check_arch" redefined
    #define compat_elf_check_arch(x) compat_a32_elf_check_arch(x)
    ^
   arch/arm64/include/asm/elf.h:179:0: note: this is the location of the previous definition
    #define compat_elf_check_arch(x) (((x)->e_machine == EM_ARM) && \
    ^
--
   In file included from include/linux/elf.h:4:0,
                    from arch/arm64/kernel/ptrace.c:39:
>> arch/arm64/include/asm/elf.h:202:0: warning: "compat_elf_check_arch" redefined
    #define compat_elf_check_arch(x) compat_a32_elf_check_arch(x)
    ^
   arch/arm64/include/asm/elf.h:179:0: note: this is the location of the previous definition
    #define compat_elf_check_arch(x) (((x)->e_machine == EM_ARM) && \
    ^
>> arch/arm64/kernel/ptrace.c:880:8: error: 'COMPAT_ELF_NGREG' undeclared here (not in a function)
      .n = COMPAT_ELF_NGREG,
           ^
--
   In file included from include/linux/elf.h:4:0,
                    from include/linux/elfcore-compat.h:4,
                    from fs/compat_binfmt_elf.c:20:
>> arch/arm64/include/asm/elf.h:202:0: warning: "compat_elf_check_arch" redefined
    #define compat_elf_check_arch(x) compat_a32_elf_check_arch(x)
    ^
   arch/arm64/include/asm/elf.h:179:0: note: this is the location of the previous definition
    #define compat_elf_check_arch(x) (((x)->e_machine == EM_ARM) && \
    ^
   In file included from fs/compat_binfmt_elf.c:145:0:
   fs/binfmt_elf.c: In function 'load_elf_interp':
>> fs/binfmt_elf.c:533:2: error: implicit declaration of function 'compat_a32_elf_check_arch' [-Werror=implicit-function-declaration]
     if (!elf_check_arch(interp_elf_ex))
     ^
   cc1: some warnings being treated as errors

vim +/COMPAT_ELF_NGREG +880 arch/arm64/kernel/ptrace.c

478fcb2c Will Deacon     2012-03-05  874  	.regsets = aarch32_regsets, .n = ARRAY_SIZE(aarch32_regsets)
478fcb2c Will Deacon     2012-03-05  875  };
478fcb2c Will Deacon     2012-03-05  876  
5d220ff9 Catalin Marinas 2015-07-14  877  static const struct user_regset aarch32_ptrace_regsets[] = {
5d220ff9 Catalin Marinas 2015-07-14  878  	[REGSET_GPR] = {
5d220ff9 Catalin Marinas 2015-07-14  879  		.core_note_type = NT_PRSTATUS,
5d220ff9 Catalin Marinas 2015-07-14 @880  		.n = COMPAT_ELF_NGREG,
5d220ff9 Catalin Marinas 2015-07-14  881  		.size = sizeof(compat_elf_greg_t),
5d220ff9 Catalin Marinas 2015-07-14  882  		.align = sizeof(compat_elf_greg_t),
5d220ff9 Catalin Marinas 2015-07-14  883  		.get = compat_gpr_get,

:::::: The code at line 880 was first introduced by commit
:::::: 5d220ff9420f8b1689805ba2d938bedf9e0860a4 arm64: Better native ptrace support for compat tasks

:::::: TO: Catalin Marinas <catalin.marinas@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45533 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/e787fdb2/attachment-0001.obj>
