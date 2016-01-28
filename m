From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Jan 2016 05:23:32 +0800
Subject: [PATCH 17/31] Add debugger entry points for ARM
In-Reply-To: <1454010424-29097-1-git-send-email-jeffmerkey@gmail.com>
Message-ID: <201601290502.dJ4amfJL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffrey,

[auto build test ERROR on v4.5-rc1]
[also build test ERROR on next-20160128]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jeffrey-Merkey/Add-hard-soft-lockup-debugger-entry-points/20160129-035852
config: arm-sa1100 (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/traps.c:21:0:
   include/linux/kdebug.h:20:16: warning: 'enum die_val' declared inside parameter list
            struct pt_regs *regs, long err, int trap, int sig);
                   ^
   include/linux/kdebug.h:20:16: warning: its scope is only this definition or declaration, which is probably not what you want
   arch/arm/kernel/traps.c: In function '__die':
>> arch/arm/kernel/traps.c:247:19: error: 'DIE_OOPS' undeclared (first use in this function)
     ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
                      ^
   arch/arm/kernel/traps.c:247:19: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/kernel/traps.c:247:2: error: type of formal parameter 1 is incomplete
     ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
     ^
--
   In file included from include/linux/kdebug.h:4:0,
                    from kernel/notifier.c:1:
   arch/arm/include/asm/kdebug.h: In function 'arch_breakpoint':
>> arch/arm/include/asm/kdebug.h:4:6: error: expected string literal before '__inst_arm'
     asm(__inst_arm(0xe7ffdeff));
         ^
   In file included from kernel/notifier.c:1:0:
   include/linux/kdebug.h: At top level:
   include/linux/kdebug.h:20:16: warning: 'enum die_val' declared inside parameter list
            struct pt_regs *regs, long err, int trap, int sig);
                   ^
   include/linux/kdebug.h:20:16: warning: its scope is only this definition or declaration, which is probably not what you want
   kernel/notifier.c:537:16: warning: 'enum die_val' declared inside parameter list
            struct pt_regs *regs, long err, int trap, int sig)
                   ^
   kernel/notifier.c:536:37: error: parameter 1 ('val') has incomplete type
    int notrace notify_die(enum die_val val, const char *str,
                                        ^
   kernel/notifier.c: In function 'notify_die':
   kernel/notifier.c:550:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +/__inst_arm +4 arch/arm/include/asm/kdebug.h

     1	
     2	static inline void arch_breakpoint(void)
     3	{
   > 4		asm(__inst_arm(0xe7ffdeff));
     5	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22240 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/b1c44719/attachment-0001.obj>
