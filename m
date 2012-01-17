From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jan 2012 13:24:21 -0200
Subject: [PATCH] ARM: clock-mx28: Fix end of loop condition
In-Reply-To: <CAOMZO5BQ1BCdf2HkUXG55dtfUk-4sSZE6TqnZ+gO9zwXVWt5vw@mail.gmail.com>
References: <1326740477-21576-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5B1ABUr1bqW8f_YLjtE46DBkFt1HocZVziv0barHq1TJg@mail.gmail.com>
 <201201162152.59997.marek.vasut@gmail.com>
 <CAOMZO5BQ1BCdf2HkUXG55dtfUk-4sSZE6TqnZ+gO9zwXVWt5vw@mail.gmail.com>
Message-ID: <CAOMZO5CAkP4ugh-nLU=wqBPXTNePuxerWugd_tKxB3TDQ+0dsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/16/12, Fabio Estevam <festevam@gmail.com> wrote:

> I will make more tests to confirm and post a new patch.

On my tests I am always getting the BUSY bit of HW_CLKCTRL_SAIF0 as 1,
no matter the timeout I add.

BUSY bit is bit 29 of this register and matches the mx28 reference
manual description.

Looking at the Freescale kernel this BUSY bit is defined as 1 instead.

If I do the change below:

diff --git a/arch/arm/mach-mxs/regs-clkctrl-mx28.h
b/arch/arm/mach-mxs/regs-clkctrl-mx28.h
index 7d1b061..1813ff0 100644
--- a/arch/arm/mach-mxs/regs-clkctrl-mx28.h
+++ b/arch/arm/mach-mxs/regs-clkctrl-mx28.h
@@ -288,7 +288,7 @@

 #define BP_CLKCTRL_SAIF0_CLKGATE	31
 #define BM_CLKCTRL_SAIF0_CLKGATE	0x80000000
-#define BM_CLKCTRL_SAIF0_BUSY	0x20000000
+#define BM_CLKCTRL_SAIF0_BUSY		1
 #define BM_CLKCTRL_SAIF0_DIV_FRAC_EN	0x00010000
 #define BP_CLKCTRL_SAIF0_DIV	0
 #define BM_CLKCTRL_SAIF0_DIV	0x0000FFFF
@@ -299,7 +299,7 @@

 #define BP_CLKCTRL_SAIF1_CLKGATE	31
 #define BM_CLKCTRL_SAIF1_CLKGATE	0x80000000
-#define BM_CLKCTRL_SAIF1_BUSY	0x20000000
+#define BM_CLKCTRL_SAIF1_BUSY		1
 #define BM_CLKCTRL_SAIF1_DIV_FRAC_EN	0x00010000
 #define BP_CLKCTRL_SAIF1_DIV	0
 #define BM_CLKCTRL_SAIF1_DIV	0x0000FFFF

,then audio can correctly work.

Will clarify with Freescale team about this.

I plan to also send a patch for replacing the for loops with a proper
timeout mechanism as suggested by Wolfram.

Regards,

Fabio Estevam
