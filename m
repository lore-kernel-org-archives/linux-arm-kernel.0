From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 11 Nov 2013 00:10:26 -0800
Subject: [PATCH] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
Message-ID: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is proposal for armv7-m build failure in sigreturn_codes.S. The 
armv7-m build issue was discussed in [1].

Proposed solution is based on conditional compilation. If 
CONFIG_CPU_THUMBONLY is set instead of arm opcodes nops in thumb mode
are used. I've tried to wrap conditional compilation as nice as I 
found possible. Other suggestions/approaches are welcome.

Fix was tested:
   linux-next with efm32_defconfig build (along with few other fixes)
   rmk-next BE/LE arndale build/boot and LTP rt_sigaction0? tests run

Uwe, is it possible for you to test that the fix runs on efm32. Also
if the platform can run LTP, you give a spin to LTP rt_sigaction0? 
tests that would be great. It is known that this tests covers code 
under change.

If folks don't like this fix, I have another variant as I mention
in [1] that backs out 574e2b5111e13827da501771b27d92e6e3f2e3d7 
(ARM: signal: sigreturn_codes should be endian neutral to work in BE8)
and use asm/opcodes to byteswap manually crafted instructions.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/209334.html

Victor Kamensky (1):
  ARM: signal: fix armv7-m build issue in sigreturn_codes.S

 arch/arm/kernel/sigreturn_codes.S | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
1.8.1.4
