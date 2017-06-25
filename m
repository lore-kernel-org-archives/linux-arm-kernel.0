From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 25 Jun 2017 19:00:16 +0200
Subject: [PATCH 1/5] clk: mb86s7x: Suppress build
In-Reply-To: <20170625170020.11791-1-afaerber@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
Message-ID: <20170625170020.11791-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It fails to build once we introduce the ARCH_MB86S7X Kconfig symbol:

  drivers/clk/clk-mb86s7x.c:27:10: fatal error: soc/mb86s7x/scb_mhu.h: No such file or directory
   #include <soc/mb86s7x/scb_mhu.h>
            ^~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

And when commenting out that line, we get:

  drivers/clk/clk-mb86s7x.c: In function 'crg_gate_control':
  drivers/clk/clk-mb86s7x.c:72:8: error: implicit declaration of function 'mb86s7x_send_packet' [-Werror=implicit-function-declaration]
    ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
          ^~~~~~~~~~~~~~~~~~~
  drivers/clk/clk-mb86s7x.c:72:28: error: 'CMD_PERI_CLOCK_GATE_SET_REQ' undeclared (first use in this function)
    ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/clk/clk-mb86s7x.c:72:28: note: each undeclared identifier is reported only once for each function it appears in
  drivers/clk/clk-mb86s7x.c: In function 'crg_rate_control':
  drivers/clk/clk-mb86s7x.c:116:10: error: 'CMD_PERI_CLOCK_RATE_SET_REQ' undeclared (first use in this function)
     code = CMD_PERI_CLOCK_RATE_SET_REQ;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/clk/clk-mb86s7x.c:121:10: error: 'CMD_PERI_CLOCK_RATE_GET_REQ' undeclared (first use in this function); did you mean 'CMD_PERI_CLOCK_RATE_SET_REQ'?
     code = CMD_PERI_CLOCK_RATE_GET_REQ;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
            CMD_PERI_CLOCK_RATE_SET_REQ
  drivers/clk/clk-mb86s7x.c: In function 'mhu_cluster_rate':
  drivers/clk/clk-mb86s7x.c:276:10: error: 'CMD_CPU_CLOCK_RATE_GET_REQ' undeclared (first use in this function)
     code = CMD_CPU_CLOCK_RATE_GET_REQ;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/clk/clk-mb86s7x.c:278:10: error: 'CMD_CPU_CLOCK_RATE_SET_REQ' undeclared (first use in this function); did you mean 'CMD_CPU_CLOCK_RATE_GET_REQ'?
     code = CMD_CPU_CLOCK_RATE_SET_REQ;
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
            CMD_CPU_CLOCK_RATE_GET_REQ
  cc1: some warnings being treated as errors
  scripts/Makefile.build:302: recipe for target
  'drivers/clk/clk-mb86s7x.o' failed
  make[2]: *** [drivers/clk/clk-mb86s7x.o] Error 1

Comment it out in the Makefile for now.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4f6a812342ed..0f0ab6f03ccd 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
-obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
+#obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
-- 
2.12.3
