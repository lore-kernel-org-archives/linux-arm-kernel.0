From: JOLLYS@xilinx.com (Jolly Shah)
Date: Tue, 17 Jul 2018 20:09:01 +0000
Subject: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-11-git-send-email-jollys@xilinx.com>
 <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
Message-ID: <SN1PR02MB37589FF7DBAFBD0C070F690EB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for the review,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Sunday, July 08, 2018 10:27 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> dmitry.torokhov at gmail.com; gregkh at linuxfoundation.org;
> hkallweit1 at gmail.com; keescook at chromium.org; linux-clk at vger.kernel.org;
> mark.rutland at arm.com; matt at codeblueprint.co.uk; Michal Simek
> <michals@xilinx.com>; mingo at kernel.org; mturquette at baylibre.com;
> robh+dt at kernel.org; sboyd at codeaurora.org; sudeep.holla at arm.com
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
> 
> > +/**
> > + * zynqmp_pm_clock_get_parents() - Get the first 3 parents of clock for given
> id
> > + * @clock_id:  Clock ID
> > + * @index:     Parent index
> > + * @parents:   3 parents of the given clock
> > + *
> > + * This function is used to get 3 parents for the clock specified by
> > + * given clock ID.
> > + *
> > + * This API will return 3 parents with a single response. To get
> > + * other parents, master should call same API in loop with new
> > + * parent index till error is returned. E.g First call should have
> > + * index 0 which will return parents 0,1 and 2. Next call, index
> > + * should be 3 which will return parent 3,4 and 5 and so on.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32
> *parents)
> > +{
> > +       struct zynqmp_pm_query_data qdata = {0};
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> 
> What's the endianness of this payload? Is it little endian? Or do the
> eemi_ops convert to CPU native endianness?

Its little endian

> > +
> > +/**
> > + * zynqmp_clock_init() - Initialize zynqmp clocks
> > + *
> > + * Return: 0 on success else error code
> > + */
> > +static int __init zynqmp_clock_init(void)
> > +{
> > +       int ret;
> > +       struct device_node *np;
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> > +       if (!np)
> > +               return -ENOENT;
> > +       of_node_put(np);
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clk");
> 
> Why can't this be a platform device driver?

Platform driver may probe later(an actually probing later in our case). This will results in clock get failure in clock consumer peripherals. So clock registration needs to be done earlier.

> 
> > +               m = rate_div / FRAC_DIV;
> > +               f = rate_div % FRAC_DIV;
> > +               m = clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
> > +               rate = parent_rate * m;
> > +               frac = (parent_rate * f) / FRAC_DIV;
> > +
> > +               ret = eemi_ops->clock_setdivider(clk_id, m);
> > +               if (ret)
> > +                       pr_warn_once("%s() set divider failed for %s, ret = %d\n",
> > +                                    __func__, clk_name, ret);
> > +
> > +               data = (FRAC_DIV * f) / FRAC_DIV;
> 
> Feels like there must be some macro for this idiom but I failed to find
> it. round_something()?
It was not needed. Removed in v10.

> 
> > +       pll->hw.init = &init;
> > +       pll->clk_id = clk_id;
> > +
> > +       hw = &pll->hw;
> > +       ret = clk_hw_register(dev, hw);
> > +       if (ret) {
> > +               kfree(pll);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> > +       clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
> 
> Why is this necessary?
This is range of rate supported by hardware for PLL.

> 
> > +       if (ret < 0)
> > +               pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
> > +
> > +       return hw;
> > +}


Rest all comments taken care in v10 series(posted today). 

Thanks,
Jolly Shah
