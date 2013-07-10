From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Jul 2013 23:21:59 +0800
Subject: [PATCH 0/3] ARM: imx6: fix up buggy CCM_CSCMR1 register
Message-ID: <1373469722-32514-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a defect in bits 22 and 21 of i.MX6 CCM_CSCMR1 register.  These
two bits are inverted between read and write.  That said, bit field
CCM_CSCMR1[22-20] (aclk/emi_podf on imx6q/dl and lcdif_pix_podf on
imx6sl) will be something as below between read and write.

  read    write    divider
   000     110       1
   001     111       2
   010     100       3
   011     101       4
   100     010       5
   101     011       6
   110     000       7
   111     001       8

To work around this hardware defect, every single read/modify/write
sequence on the register will require a fix-up (invert bits 22 and 21)
before writing the value into register.  As there are dividers and
multiplexers defined in the register, we choose to inherit the basic
clk-divider and clk-mux and override the functions which writes register
with a fix-up hooked in.

Shawn

Liu Ying (3):
  ARM: imx: add common clock support for fixup div
  ARM: imx: add common clock support for fixup mux
  ARM: imx6: change some clocks to fixup clocks

 arch/arm/mach-imx/Makefile        |    3 +-
 arch/arm/mach-imx/clk-fixup-div.c |  129 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-fixup-mux.c |  107 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c     |   24 +++----
 arch/arm/mach-imx/clk-imx6sl.c    |   20 +++---
 arch/arm/mach-imx/clk.c           |   26 ++++++++
 arch/arm/mach-imx/clk.h           |   10 +++
 7 files changed, 296 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-fixup-div.c
 create mode 100644 arch/arm/mach-imx/clk-fixup-mux.c

-- 
1.7.9.5
