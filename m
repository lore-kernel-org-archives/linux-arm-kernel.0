From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 12 Nov 2013 22:57:46 -0800
Subject: [PATCH v2] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
Message-ID: <1384325867-5140-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is version 2 of fix to armv7-m build failure in sigreturn_codes.S.
It is based on Dave's suggestion on [1]. Basically it set
arch to arm4t explicitly if CONFIG_CPU_THUMBONLY is set.
That enables both arm and thumb opcodes and code merged with
the rest of image.

Version 1 [2] used conditional compilation.

Fix was tested
   linux-next with efm32_defconfig build (along with few other fixes)
   rmk-next BE/LE arndale build/boot and LTP rt_sigaction0? tests run

Dave, I've added your name with Suggested-by tag, please
let me know if it is not OK with you, I'll remove it then.

Uwe, is it possible for you to test that this fix runs on 
efm32? Sorry, for multiple requests.

To address concern about fragility of proposed solution
I looked binutils bfd/elf32-arm.c

  https://sourceware.org/git/?p=binutils.git;a=blob;f=bfd/elf32-arm.c;h=5af1643bf506870e741ee4da7bd645083619e16d;hb=HEAD

Attributes merge deals with couple things:

Tag_CPU_arch: tag_cpu_arch_combine function deals with it
and from its tables it seems that v4t is compatible with
any latter version and resulting value will come from 
latter version. I.e v4t and v7 (v7m) would merge fine.

Tag_CPU_arch_profile: since in case of '.arch armv4t' 
profile attribute is not generated it is merged fine
with any other profile. Unlike in case of 
'.arch armv7a' and '.arch armv7m' profile values would
be 'Application' and 'Microcontroller' and those 
conflict.

Above logic seems to be universal, so other linkers
may follow it too. So it seems it is good to use 
'.arch armv4t' with armv7m code.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210631.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210393.html

Victor Kamensky (1):
  ARM: signal: fix armv7-m build issue in sigreturn_codes.S

 arch/arm/kernel/sigreturn_codes.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.1.4
