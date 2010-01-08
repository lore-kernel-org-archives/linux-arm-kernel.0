From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:09 +0000
Subject: [S3C-CLK] ARM: S3C64XX: Fix possible clock look in EPLL and MPLL
	clock chains
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a possibility of a loop happening in the PLL output clock
chain on the S3C64XX series. clk_mpll's parent was set to be
clk_mout_mpll, but this is fed from clk_fout_epll (which is also
clk_mpll).

clk_mpll is meant to be the output from the MPLL, and clk_mout_mpll
is a seperate clock derived from the mux of clk_mpll and clk_fin_mpll
and thus should be considered a seperate clock.

Anything using clk_mpll directly really should not be relying on this
being the clock that is eventually routed to a peripheral, so remove the
loop and ensure that the clocks accurately represent the clock chain
in the device.

The clk_mpll is not being used outside of the s3c6400-clock.c code, so
this change should not break anything else.

Do the same for the EPLL.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 6ffa21e..ffd56de 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -46,6 +46,7 @@ static struct clk clk_ext_xtal_mux = {
 #define clk_fin_epll clk_ext_xtal_mux
 
 #define clk_fout_mpll	clk_mpll
+#define clk_fout_epll	clk_epll
 
 struct clk_sources {
 	unsigned int	nr_sources;
@@ -88,11 +89,6 @@ static struct clksrc_clk clk_mout_apll = {
 	.sources	= &clk_src_apll,
 };
 
-static struct clk clk_fout_epll = {
-	.name		= "fout_epll",
-	.id		= -1,
-};
-
 static struct clk *clk_src_epll_list[] = {
 	[0] = &clk_fin_epll,
 	[1] = &clk_fout_epll,
@@ -715,7 +711,6 @@ static struct clk *clks[] __initdata = {
 	&clk_iis_cd1,
 	&clk_pcm_cd,
 	&clk_mout_epll.clk,
-	&clk_fout_epll,
 	&clk_mout_mpll.clk,
 	&clk_dout_mpll,
 	&clk_mmc0.clk,
@@ -760,7 +755,4 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
 			       clkp->name, ret);
 		}
 	}
-
-	clk_mpll.parent = &clk_mout_mpll.clk;
-	clk_epll.parent = &clk_mout_epll.clk;
 }
-- 
1.6.0.4
