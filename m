From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 19 Nov 2013 23:21:11 -0800
Subject: [PATCH v4] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
Message-ID: <1384932072-8103-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is version 4 of fix to armv7-m build failure in 
sigreturn_codes.S. The difference with version 3 is
fixed formating and renamed internally used macro
as per Dave's comments on [3].

Solution is based on .org directive Dave's suggestion 
on last email in [1].

It uses conditional compilation and it uses .org 
directive to keep sigreturn_codes layout.

Note I did not use ARM and THUMB macros because 
those switch between CONFIG_THUMB2_KERNEL and not.
On v7a kernel we need both arm and thumb snipets
regardless of CONFIG_THUMB2_KERNEL setting.
And conditional compilation only kicks in with
CONFIG_CPU_THUMBONLY, for that local ARM_INSTR
macro is created.

Version 3 [3] conditional compilation and .org directive.
Pretty much the same code but incorrectly formated. Please 
look at [3] for details.

Version 2 [2] tried to use '.acrh armv4t' directive
to allow both arm and thumb2 opcodes, but solution
deemed to be too fragile.

Version 1 [1] used conditional compilation and added
thumb2 nop instructions in  CONFIG_CPU_THUMBONLY

Fix was tested
   linux-next with efm32_defconfig build (along with few other fixes)
   rmk-next BE/LE vexpress build/boot and LTP rt_sigaction0? tests run
   Uwe tested version 1 and 3 with efm32

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210393.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210949.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/212307.html

Victor Kamensky (1):
  ARM: signal: fix armv7-m build issue in sigreturn_codes.S

 arch/arm/kernel/sigreturn_codes.S | 40 ++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

-- 
1.8.1.4
