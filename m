From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Jan 2014 10:26:11 +0800
Subject: [PATCH V4 1/6] ARM: dts: imx6q: add common compatible name for
 reused modules
In-Reply-To: <20140113151623.GL16215@pengutronix.de>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
 <20140113121016.GJ16215@pengutronix.de>
 <20140113142249.GW23525@S2101-09.ap.freescale.net>
 <20140113151623.GL16215@pengutronix.de>
Message-ID: <20140114022609.GA1896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 04:16:23PM +0100, Sascha Hauer wrote:
> On Mon, Jan 13, 2014 at 10:22:51PM +0800, Shawn Guo wrote:
> > On Mon, Jan 13, 2014 at 01:10:16PM +0100, Sascha Hauer wrote:
> > > > @@ -840,7 +840,7 @@
> > > >  			};
> > > >  
> > > >  			mmdc0: mmdc at 021b0000 { /* MMDC0 */
> > > > -				compatible = "fsl,imx6q-mmdc";
> > > > +				compatible = "fsl,imx6q-mmdc", "fsl,mmdc";
> > > 
> > > This is not nice. Here you introduce a fsl,mmdc compatible claiming all
> > > mmdc are compatible to each other and in the driver code you have:
> > > 
> > > static const u32 imx6q_mmdc_io_dsm_offset[]
> > > static const u32 imx6dl_mmdc_io_dsm_offset[]
> > > 
> > > which proves they are *not* compatible.
> > > 
> > > You do this just to share a
> > > 
> > > imx6_pm_get_base(&pm_info->mmdc_base, "fsl,mmdc");
> > > 
> > > across the different i.MX6 SoCs.
> > > 
> > > You can sanitize this by introducing a SoC struct which you populate
> > > differently for the SoCs
> > > 
> > > static pm_soc_data imx6q_data {
> > > 	.mmdc_compat = "fsl,imx6q-mmdc",
> > > };
> > > 
> > > And by putting cpu_type, mmdc_io_num and others in this struct you can
> > > also remove the if(cpu_is_x()) else if (cpu_is_y()) else...
> > 
> > Good point.
> > 
> > Anson, the change below is a demonstration of Sascha's suggestion.
> > Sascha, correct me if I misunderstood your comment.
> 
> Looks good. That's exactly what I meant. Maybe the cpu_type field can
> even be removed the way you did it.

Since the assembly function imx6_suspend() needs to check the cpu_type,
we have to keep it in imx6_cpu_pm_info.  So I assume you're suggesting
we remove the field from imx6_pm_socdata and determine the cpu_type by
comparing socdata pointer with particular imx6_pm_socdata like below?

	if (socdata == &imx6q_pm_data)
		pm_info->cpu_type = MXC_CPU_IMX6Q;
	else if (socdata == &imx6dl_pm_data)
		pm_info->cpu_type = MXC_CPU_IMX6DL;
	else if (socdata == &imx6sl_pm_data)
		pm_info->cpu_type = MXC_CPU_IMX6SL;

Looking at these if-clauses, I do not think we win too much from doing
thing in this way.

Shawn
