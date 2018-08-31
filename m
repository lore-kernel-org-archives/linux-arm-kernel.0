From: andy.tang@nxp.com (Andy Tang)
Date: Fri, 31 Aug 2018 06:12:23 +0000
Subject: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
In-Reply-To: <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
 <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
 <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
Message-ID: <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

Please see my replay inline.

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
> On Behalf Of Scott Wood
> Sent: 2018?8?31? 1:43
> To: Vabhav Sharma <vabhav.sharma@nxp.com>;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com;
> linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> mturquette at baylibre.com; sboyd at kernel.org; rjw at rjwysocki.net;
> viresh.kumar at linaro.org; linux-clk at vger.kernel.org;
> linux-pm at vger.kernel.org; linux-kernel-owner at vger.kernel.org;
> catalin.marinas at arm.com; will.deacon at arm.com;
> gregkh at linuxfoundation.org; arnd at arndb.de;
> kstewart at linuxfoundation.org; yamada.masahiro at socionext.com
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Andy Tang
> <andy.tang@nxp.com>; linux at armlinux.org.uk; Varun Sethi
> <V.Sethi@nxp.com>; Udit Kumar <udit.kumar@nxp.com>
> Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
> lx2160a
> 
> On Thu, 2018-08-30 at 12:39 -0500, Scott Wood wrote:
> > On Thu, 2018-08-30 at 07:36 +0000, Vabhav Sharma wrote:
> > > > -----Original Message-----
> > > > From: linux-kernel-owner at vger.kernel.org <linux-kernel-
> > > > owner at vger.kernel.org> On Behalf Of Scott Wood
> > > > Sent: Wednesday, August 29, 2018 5:49 AM
> > > > To: Vabhav Sharma <vabhav.sharma@nxp.com>; linux-
> > > > kernel at vger.kernel.org; devicetree at vger.kernel.org;
> > > > robh+dt at kernel.org; mark.rutland at arm.com;
> > > > linuxppc-dev at lists.ozlabs.org; linux-arm-
> > > > kernel at lists.infradead.org; mturquette at baylibre.com;
> > > > sboyd at kernel.org; rjw at rjwysocki.net; viresh.kumar at linaro.org;
> > > > linux-clk at vger.kernel.org; linux-pm at vger.kernel.org;
> > > > linux-kernel-owner at vger.kernel.org;
> > > > catalin.marinas at arm.com; will.deacon at arm.com;
> > > > gregkh at linuxfoundation.org; arnd at arndb.de;
> > > > kstewart at linuxfoundation.org; yamada.masahiro at socionext.com
> > > > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Andy
> Tang
> > > > <andy.tang@nxp.com>; Udit Kumar <udit.kumar@nxp.com>;
> > > > linux at armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>
> > > > Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support
> > > > for lx2160a
> > > >
> > > > On Mon, 2018-08-20 at 12:17 +0530, Vabhav Sharma wrote:
> > > > > From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > > >
> > > > > Add clockgen support for lx2160a.
> > > > > Added entry for compat 'fsl,lx2160a-clockgen'.
> > > > > As LX2160A is 16 core, so modified value for NUM_CMUX
> > > > >
> > > > > Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> > > > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > > > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > > > ---
> > > > >  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
> > > > >  drivers/cpufreq/qoriq-cpufreq.c |  1 +
> > > > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> > > > > index
> > > > > 3a1812f..fc6e308 100644
> > > > > --- a/drivers/clk/clk-qoriq.c
> > > > > +++ b/drivers/clk/clk-qoriq.c
> > > > > @@ -60,7 +60,7 @@ struct clockgen_muxinfo {  };
> > > > >
> > > > >  #define NUM_HWACCEL	5
> > > > > -#define NUM_CMUX	8
> > > > > +#define NUM_CMUX	16
> > > > >
> > > > >  struct clockgen;
> > > > >
> > > > > @@ -570,6 +570,17 @@ static const struct clockgen_chipinfo
> > > > > chipinfo[] = {
> > > > >  		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
> > > > >  	},
> > > > >  	{
> > > > > +		.compat = "fsl,lx2160a-clockgen",
> > > > > +		.cmux_groups = {
> > > > > +			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
> > > > > +		},
> > > > > +		.cmux_to_group = {
> > > > > +			0, 0, 0, 0, 1, 1, 1, 1, -1
> > > > > +		},
> > > > > +		.pll_mask = 0x37,
> > > > > +		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
> > > > > +	},
> > > >
> > > > Why are you increasing NUM_CMUX beyond 8 for a chip that only
> has
> > > > 8 entries in cmux_to_group?
> > >
> > > Configuration is 16 cores,8 cluster with 2 cores in each cluster
> >
> > So?  This is about cmuxes, not cores.  You're increasing the array
> > without ever using the new size.
> 
> Oh, and you also broke p4080 which has 8 cmuxes but no -1 terminator,
> because the array was of length 8.  Probably the array should be changed
> to NUM_CMUX+1 so every array can be -1 terminated.
> 
[Andy] How about we add -1 terminator to p4080 and increase NUM_CMUX to 16?
We don't want to increase NUM_CMUX each time new soc with more cmuxes added.

BR,
Andy Tang

> -Scott
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=02
> %7C01%7Candy.tang%40nxp.com%7C963d0cdf49964539ea4408d60ea06
> 63b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63671247
> 9414561101&amp;sdata=rZY%2F5JP0TBZRLr%2Bp6qaG4oSQd8fsNviz92AY
> 3IoLTOw%3D&amp;reserved=0
