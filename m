From: stefan@agner.ch (Stefan Agner)
Date: Sat, 11 Aug 2018 14:29:24 +0200
Subject: Function Tracing with clang on ARM32
Message-ID: <35ae3d464c7b77a5fe86a732079e32bc@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am currently looking into function tracing support when compiling an
ARM32 kernel with clang.

With v4.18-rc1 and:
CONFIG_FTRACE=y                                                         
                                                                   
CONFIG_FUNCTION_TRACER=y

Building fails:

  LD      vmlinux.o                                                     
                                                                  
  MODPOST vmlinux.o
kernel/softirq.o: In function `_local_bh_enable':
/home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:152:
undefined reference to `mcount'
kernel/softirq.o: In function `__local_bh_enable_ip':
/home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:159:
undefined reference to `mcount'
kernel/softirq.o: In function `do_softirq':
/home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:316:
undefined reference to `mcount'
kernel/softirq.o: In function `irq_enter':
/home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:337:
undefined reference to `mcount'
kernel/softirq.o: In function `irq_exit':
/home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:395:
undefined reference to `mcount'

It seems that clang/LLVM uses a different mcount interface. However,
there is an option to use the gcc compatible symbol __gnu_mcount_nc when
using -meabi gnu. So adding
CFLAGS_ABI     +=-meabi gnu

Builds the kernel successfully. However, the kernel crashes immediately
on boot. Even with earlyprintk enabled, I only get:

Uncompressing Linux... done, booting the kernel.

I poked a bit around in arch/arm/kernel/entry-ftrace.S. Not calling
__mcount in __gnu_mcount_nc produces a bootable kernel. Removing the
call into the ftrace logic by only using mcount_enter/exit in the
__mcount macro does not boot...

I guess the mcount ABI is slightly different in LLVM/clang still then?
Before I dive deeper, maybe anyone has an idea?

--
Stefan
