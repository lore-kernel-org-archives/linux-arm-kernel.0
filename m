From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 21 Mar 2018 19:59:21 +0000
Subject: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <152149019011.242365.2529338400397080149@swboyd.mtv.corp.google.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-4-git-send-email-jollys@xilinx.com>
 <152149019011.242365.2529338400397080149@swboyd.mtv.corp.google.com>
Message-ID: <DM2PR0201MB07674E4EE557F73BC195853EB8AA0@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephan,

Thanks for the review,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Monday, March 19, 2018 1:10 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; linux-clk at vger.kernel.org;
> mark.rutland at arm.com; michal.simek at xilinx.com; mturquette at baylibre.com;
> robh+dt at kernel.org; sboyd at codeaurora.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>
> Subject: Re: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
> 
> > +/**
> > + * struct zynqmp_clock - Structure for clock
> > + * @clk_name:          Clock name
> > + * @valid:             Validity flag of clock
> > + * @init_enable:       init_enable flag of clock
> > + * @type:              Clock type (Output/External)
> > + * @node:              Clock tolology nodes
> > + * @num_nodes:         Number of nodes present in topology
> > + * @parent:            structure of parent of clock
> > + * @num_parents:       Number of parents of clock
> > + */
> > +struct zynqmp_clock {
> > +       char clk_name[MAX_NAME_LEN];
> > +       u32 valid;
> > +       u32 init_enable;
> > +       enum clk_type type;
> 
> Is this ever assigned?

Yes its assigned in zynqmp_get_clock_info function below.

> 
> > + * Return: Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32
> *parents)
> > +{
> > +       struct zynqmp_pm_query_data qdata = {0};
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > +       int ret;
> > +
> > +       qdata.qid = PM_QID_CLOCK_GET_PARENTS;
> > +       qdata.arg1 = clock_id;
> > +       qdata.arg2 = index;
> > +
> > +       ret = eemi_ops->query_data(qdata, ret_payload);
> > +       memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS *
> 4);
> 
> Is 4 sizeof(u32)? Or is it supposed to be 3 for the 3 parents returned?

It should be 3.

> 
> > +
> > +/**
> > + * zynqmp_clk_setup() - Setup the clock framework and register clocks
> > + * @np:                Device node
> > + */
> > +static void __init zynqmp_clk_setup(struct device_node *np)
> > +{
> > +       int idx;
> > +
> > +       idx = of_property_match_string(np, "clock-names", "pss_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("pss_ref_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "video_clk");
> > +       if (idx < 0) {
> > +               pr_err("video_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "pss_alt_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("pss_alt_ref_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "aux_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("aux_ref_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "gt_crx_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("aux_ref_clk not provided\n");
> > +               return;
> > +       }
> 
> Why are we doing all this? Please don't verify DT contents in driver
> code.

The intent is not to go ahead with other clock registration if these external clocks are not available.
Where should it be validated?

> > +
> > +/**
> > + * pll_get_mode - Get mode of PLL
> > + * @hw: Handle between common and hardware-specific interfaces
> > + *
> > + * Return: Mode of PLL
> > + */
> > +static inline enum pll_mode pll_get_mode(struct clk_hw *hw)
> > +{
> > +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> > +       u32 clk_id = clk->clk_id;
> > +       const char *clk_name = clk_hw_get_name(hw);
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> 
> How big is PAYLOAD_ARG_CNT?
> 
Its 5.

Rest all comments will be taken care in next version.


Thanks,
Jolly Shah
