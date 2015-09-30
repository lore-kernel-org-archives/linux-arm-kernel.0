From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Sep 2015 11:48:40 +0800
Subject: [PATCH v5 10/23] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <1443564860-31208-11-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201509301157.6EM7wq2e%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm64-allnoconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout fe86f28ac31c45961e8b7bedb02c1836ddc91860
  # save the attached .config to linux build tree
  make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/process.c:48:0:
>> arch/arm64/include/asm/compat.h:336:38: error: macro "is_compat_task" passed 1 arguments, but takes just 0
    static inline int is_compat_task(void)
                                         ^
>> arch/arm64/include/asm/compat.h:337:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
>> arch/arm64/include/asm/compat.h:341:19: error: redefinition of 'is_compat_thread'
    static inline int is_compat_thread(struct thread_info *thread)
                      ^
   arch/arm64/include/asm/compat.h:324:19: note: previous definition of 'is_compat_thread' was here
    static inline int is_compat_thread(struct thread_info *thread)
                      ^
   arch/arm64/include/asm/compat.h: In function 'is_compat_thread':
>> arch/arm64/include/asm/compat.h:343:2: error: implicit declaration of function 'is_a32_compat_thread' [-Werror=implicit-function-declaration]
     return is_a32_compat_thread(thread);
     ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm64/kernel/ptrace.c:41:0:
>> arch/arm64/include/asm/compat.h:336:38: error: macro "is_compat_task" passed 1 arguments, but takes just 0
    static inline int is_compat_task(void)
                                         ^
>> arch/arm64/include/asm/compat.h:337:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
>> arch/arm64/include/asm/compat.h:341:19: error: redefinition of 'is_compat_thread'
    static inline int is_compat_thread(struct thread_info *thread)
                      ^
   arch/arm64/include/asm/compat.h:324:19: note: previous definition of 'is_compat_thread' was here
    static inline int is_compat_thread(struct thread_info *thread)
                      ^
   arch/arm64/include/asm/compat.h: In function 'is_compat_thread':
>> arch/arm64/include/asm/compat.h:343:2: error: implicit declaration of function 'is_a32_compat_thread' [-Werror=implicit-function-declaration]
     return is_a32_compat_thread(thread);
     ^
   arch/arm64/kernel/ptrace.c: At top level:
   arch/arm64/kernel/ptrace.c:1190:56: error: unknown type name 'compat_long_t'
    long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
                                                           ^
   arch/arm64/kernel/ptrace.c:1191:8: error: unknown type name 'compat_ulong_t'
           compat_ulong_t caddr, compat_ulong_t cdata)
           ^
   arch/arm64/kernel/ptrace.c:1191:30: error: unknown type name 'compat_ulong_t'
           compat_ulong_t caddr, compat_ulong_t cdata)
                                 ^
   cc1: some warnings being treated as errors
--
   arch/arm64/kernel/signal.c: In function 'setup_restart_syscall':
>> arch/arm64/kernel/signal.c:279:2: error: implicit declaration of function 'is_a32_compat_task' [-Werror=implicit-function-declaration]
     if (is_a32_compat_task())
     ^
   arch/arm64/kernel/signal.c:280:3: error: implicit declaration of function 'compat_setup_restart_syscall' [-Werror=implicit-function-declaration]
      compat_setup_restart_syscall(regs);
      ^
   arch/arm64/kernel/signal.c: In function 'handle_signal':
   arch/arm64/kernel/signal.c:300:4: error: implicit declaration of function 'compat_setup_rt_frame' [-Werror=implicit-function-declaration]
       ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
       ^
   arch/arm64/kernel/signal.c:302:4: error: implicit declaration of function 'compat_setup_frame' [-Werror=implicit-function-declaration]
       ret = compat_setup_frame(usig, ksig, oldset, regs);
       ^
   cc1: some warnings being treated as errors

vim +/is_compat_task +336 arch/arm64/include/asm/compat.h

   330	{
   331		return 0;
   332	}
   333	
   334	#endif /* CONFIG_COMPAT */
   335	
 > 336	static inline int is_compat_task(void)
 > 337	{
   338		return is_a32_compat_task();
   339	}
   340	
 > 341	static inline int is_compat_thread(struct thread_info *thread)
   342	{
 > 343		return is_a32_compat_thread(thread);
   344	}
   345	#endif /* __KERNEL__ */
   346	#endif /* __ASM_COMPAT_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5480 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/706e9e2d/attachment-0001.obj>
