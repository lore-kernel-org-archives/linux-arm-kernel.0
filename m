From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 18 Nov 2013 22:49:49 -0800
Subject: [PATCH v3] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
Message-ID: <1384843790-14394-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is version 3 of fix to armv7-m build failure in 
sigreturn_codes.S. It is based on .org directive 
Dave's suggestion on last email in [1].

It uses conditional compilation and it uses .org 
directive to keep sigreturn_codes layout.

Note I did not use ARM and THUMB macros because 
those switch between CONFIG_THUMB2_KERNEL and not.
On v7a kernel we need both arm and thumb snipets
regardless of CONFIG_THUMB2_KERNEL setting.
And conditional compilation only kicks in with
CONFIG_CPU_THUMBONLY, for that local ARM_INSTR
macro is created.

Version 1 [1] used conditional compilation and added
thumb2 nop instructions in  CONFIG_CPU_THUMBONLY

Version 2 [2] tried to use '.acrh armv4t' directive
to allow both arm and thumb2 opcodes, but solution
deemed to be too fragile.

Fix was tested
   linux-next with efm32_defconfig build (along with few other fixes)
   rmk-next BE/LE arndale build/boot and LTP rt_sigaction0? tests run

Dave, I've added your name with Suggested-by tag, please
let me know if it is not OK with you, I'll remove it then.

Uwe, is it possible for you to test that this fix runs on 
efm32? Sorry, for multiple requests.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210393.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210949.html

Victor Kamensky (1):
  ARM: signal: fix armv7-m build issue in sigreturn_codes.S

 arch/arm/kernel/sigreturn_codes.S | 40 ++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

-- 
1.8.1.4
