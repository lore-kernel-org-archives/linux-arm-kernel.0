From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Mar 2012 21:13:30 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <20120317202931.GN3852@pengutronix.de>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
 <20120317202931.GN3852@pengutronix.de>
Message-ID: <201203172113.31122.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 March 2012, Sascha Hauer wrote:
> On Sat, Mar 17, 2012 at 11:02:11AM -0700, Turquette, Mike wrote:
> >
> > Much like experimental I'm not sure how needed this change is.  The
> > help section does say to leave it disabled by default, if unsure.  If
> > you merge it I won't object but this might be fixing an imaginary
> > problem.
> 
> Architectures without common clock support won't build with this option
> enabled (multiple definition of clk_enable etc), so I think this should
> not be user visible.

I've applied this patch now.

	Arnd

commit c173033d154e9792b1b5059783b802f82536d48f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Mar 17 21:10:51 2012 +0000

    clk: make CONFIG_COMMON_CLK invisible
    
    All platforms that use the common clk infrastructure should select
    COMMON_CLK from platform code, and on all other platforms, it must
    not be enabled, so there is no point making the option visible to
    users, and when it is visible, we break randconfig builds.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 2eaf17e..82bcfbd 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -10,18 +10,14 @@ config HAVE_MACH_CLKDEV
 	bool
 
 menuconfig COMMON_CLK
-	bool "Common Clock Framework"
+	bool
 	select HAVE_CLK_PREPARE
 	---help---
 	  The common clock framework is a single definition of struct
 	  clk, useful across many platforms, as well as an
 	  implementation of the clock API in include/linux/clk.h.
 	  Architectures utilizing the common struct clk should select
-	  this automatically, but it may be necessary to manually select
-	  this option for loadable modules requiring the common clock
-	  framework.
-
-	  If in doubt, say "N".
+	  this option.
 
 if COMMON_CLK
 
