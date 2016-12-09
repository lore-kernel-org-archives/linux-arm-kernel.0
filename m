From: sboyd@codeaurora.org (sboyd at codeaurora.org)
Date: Thu, 8 Dec 2016 16:31:49 -0800
Subject: [PATCH v3] clk: qoriq: added ls1012a clock configuration
In-Reply-To: <DB5PR0401MB1928E67508686321F92863AB91840@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1479955015-37514-1-git-send-email-yuantian.tang@nxp.com>
 <DB5PR0401MB1928925ACE6E6E066961C64A91B60@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <DB6PR0402MB2837A0811DDF5A5DC9E82EF7F0890@DB6PR0402MB2837.eurprd04.prod.outlook.com>
 <20161208231010.GV5423@codeaurora.org>
 <DB5PR0401MB1928E67508686321F92863AB91840@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <20161209003149.GF5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08, Scott Wood wrote:
> On 12/08/2016 05:10 PM, sboyd at codeaurora.org wrote:
> > On 11/25, Y.T. Tang wrote:
> >> Hi Scott,
> >>
> >>> -----Original Message-----
> >>> From: Scott Wood
> >>> Sent: Thursday, November 24, 2016 4:21 PM
> >>> To: Y.T. Tang <yuantian.tang@nxp.com>; mturquette at baylibre.com
> >>> Cc: sboyd at codeaurora.org; linux-clk at vger.kernel.org; linux-
> >>> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> >>> Subject: Re: [PATCH v3] clk: qoriq: added ls1012a clock configuration
> >>>
> >>> On 11/23/2016 08:50 PM, yuantian.tang at nxp.com wrote:
> >>>> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> >>>>
> >>>> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> >>>> ---
> >>>> v3:
> >>>>   - rebased to latest kernel and re-sorted the code
> >>> [snip]
> >>>> @@ -1316,6 +1334,7 @@ CLK_OF_DECLARE(qoriq_clockgen_2,
> >>>> "fsl,qoriq-clockgen-2.0", clockgen_init);
> >>>> CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen",
> >>>> clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_ls1043a,
> >>>> "fsl,ls1043a-clockgen", clockgen_init);
> >>>> CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen",
> >>>> clockgen_init);
> >>>> +CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen",
> >>>> +clockgen_init);
> >>>>  CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen",
> >>>> clockgen_init);
> >>>
> >>> You need a better sorting algorithm. :-P
> >>>
> >> I don't think so. This time, each code snip goes right after ls1046a.
> >> The sorting 'algorithm' is best ever. :)
> >>
> > 
> > I will sort it and apply it? Ack Scott?
> > 
> 
> Acked-by: Scott Wood <oss@buserror.net>
> 

Thanks. Applied this to clk-next:

---8<----
From: Tang Yuantian <Yuantian.Tang@nxp.com>
Subject: [PATCH] clk: qoriq: added ls1012a clock configuration

Acked-by: Scott Wood <oss@buserror.net>
Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
[sboyd at codeaurora.org: Sorted list]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-qoriq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 7dd4351efdd6..d0bf8b1c67de 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -291,6 +291,14 @@ static const struct clockgen_muxinfo ls1046a_hwa2 = {
 	},
 };
 
+static const struct clockgen_muxinfo ls1012a_cmux = {
+	{
+		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
+		{},
+		[2] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+	}
+};
+
 static const struct clockgen_muxinfo t1023_hwa1 = {
 	{
 		{},
@@ -529,6 +537,16 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_PLL_8BIT,
 	},
 	{
+		.compat = "fsl,ls1012a-clockgen",
+		.cmux_groups = {
+			&ls1012a_cmux
+		},
+		.cmux_to_group = {
+			0, -1
+		},
+		.pll_mask = 0x03,
+	},
+	{
 		.compat = "fsl,ls2080a-clockgen",
 		.cmux_groups = {
 			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
@@ -1313,6 +1331,7 @@ static void __init clockgen_init(struct device_node *np)
 
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
