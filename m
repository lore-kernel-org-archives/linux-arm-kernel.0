From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 Sep 2015 11:36:55 +0800
Subject: [PATCH v5 04/23] arm64: change some CONFIG_COMPAT over to use
 CONFIG_AARCH32_EL0 instead
In-Reply-To: <1443564860-31208-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201509301138.CzkOGZCU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm64-allnoconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout 4035143523cbf0106ee81f3ea585b363110c1ab6
  # save the attached .config to linux build tree
  make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

>> arch/arm64/kernel/ptrace.c:1190:56: error: unknown type name 'compat_long_t'
    long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
                                                           ^
>> arch/arm64/kernel/ptrace.c:1191:8: error: unknown type name 'compat_ulong_t'
           compat_ulong_t caddr, compat_ulong_t cdata)
           ^
   arch/arm64/kernel/ptrace.c:1191:30: error: unknown type name 'compat_ulong_t'
           compat_ulong_t caddr, compat_ulong_t cdata)
                                 ^
--
   arch/arm64/kernel/signal.c: In function 'setup_restart_syscall':
>> arch/arm64/kernel/signal.c:280:3: error: implicit declaration of function 'compat_setup_restart_syscall' [-Werror=implicit-function-declaration]
      compat_setup_restart_syscall(regs);
      ^
   arch/arm64/kernel/signal.c: In function 'handle_signal':
>> arch/arm64/kernel/signal.c:300:4: error: implicit declaration of function 'compat_setup_rt_frame' [-Werror=implicit-function-declaration]
       ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
       ^
>> arch/arm64/kernel/signal.c:302:4: error: implicit declaration of function 'compat_setup_frame' [-Werror=implicit-function-declaration]
       ret = compat_setup_frame(usig, ksig, oldset, regs);
       ^
   cc1: some warnings being treated as errors

vim +/compat_long_t +1190 arch/arm64/kernel/ptrace.c

  1184				break;
  1185		}
  1186	
  1187		return ret;
  1188	}
  1189	#else /* !CONFIG_AARCH32_EL0 */
> 1190	long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
> 1191				    compat_ulong_t caddr, compat_ulong_t cdata)
  1192	{
  1193		return -1;
  1194	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5480 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/cc7d2551/attachment.obj>
