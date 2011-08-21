From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 21 Aug 2011 00:33:57 -0600 (MDT)
Subject: [PATCHv2 1/4] OMAP4: clockdata: Make compiler shut up about
	possible uninitialized variable
In-Reply-To: <CAFULf_wBTEVHYTPyJqWt09gNaenWHiVJCLvNdeRG204TkeBe6Q@mail.gmail.com>
References: <CAFULf_yAOTABxF_OV2xacF2CMhNVEguwSpgDHNbkeKKZif4ncA@mail.gmail.com>
	<CAFULf_wBTEVHYTPyJqWt09gNaenWHiVJCLvNdeRG204TkeBe6Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1108210031560.20233@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bjarne,

On Fri, 12 Aug 2011, Bjarne Steinsbo wrote:

> Stop `warning: 'cpu_clkflg' may be used uninitialized in this
> function' from compiler.
> 
> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>

Thanks for the patch.  The following patch seems to make a little more 
sense to me, I think Tony wants the clock init routines to be initcalls 
eventually.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 21 Aug 2011 00:28:56 -0600
Subject: [PATCH] OMAP4: clock: fix compile warning

Fix the following compile warning:

arch/arm/mach-omap2/clock44xx_data.c: In function 'omap4xxx_clk_init':
arch/arm/mach-omap2/clock44xx_data.c:3371:6: warning: 'cpu_clkflg' may be used uninitialized in this function

The approach taken here is intended to work if omap4xxx_clk_init() is
converted into an initcall.

Thanks to Bjarne Steinsbo <bsteinsbo@gmail.com> for proposing another
approach.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2af0e3f..4304768 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3376,6 +3376,8 @@ int __init omap4xxx_clk_init(void)
 	} else if (cpu_is_omap446x()) {
 		cpu_mask = RATE_IN_4460;
 		cpu_clkflg = CK_446X;
+	} else {
+		return 0;
 	}
 
 	clk_init(&omap2_clk_functions);
-- 
1.7.5.4
