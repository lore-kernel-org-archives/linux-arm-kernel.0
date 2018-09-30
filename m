From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 30 Sep 2018 03:08:05 +0000
Subject: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
In-Reply-To: <20180930030611.GJ26692@dragon>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
 <1537337088-28819-2-git-send-email-Anson.Huang@nxp.com>
 <20180928084452.GH26692@dragon>
 <DB3PR0402MB3916515873BCC9673AE9E05AF5EC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20180930030611.GJ26692@dragon>
Message-ID: <DB3PR0402MB3916A3EAD0AB84103EBE1020F5EE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Sunday, September 30, 2018 11:06 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; s.hauer at pengutronix.de;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux at armlinux.org.uk; mturquette at baylibre.com; sboyd at kernel.org; Jacky
> Bai <ping.bai@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-clk at vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
> 
> On Fri, Sep 28, 2018 at 09:07:28AM +0000, Anson Huang wrote:
> > Hi, Shawn
> >
> > Anson Huang
> > Best Regards!
> >
> >
> > > -----Original Message-----
> > > From: Shawn Guo <shawnguo@kernel.org>
> > > Sent: Friday, September 28, 2018 4:45 PM
> > > To: Anson Huang <anson.huang@nxp.com>
> > > Cc: robh+dt at kernel.org; mark.rutland at arm.com;
> > > s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> > > <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> > > mturquette at baylibre.com; sboyd at kernel.org; Jacky Bai
> > > <ping.bai@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> > > devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org; linux-clk at vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
> > >
> > > On Wed, Sep 19, 2018 at 02:04:45PM +0800, Anson Huang wrote:
> > > > The i.MX 6ULZ processor is a high-performance, ultra
> > > > cost-efficient consumer Linux processor featuring an advanced
> > > > implementation of a single Arm(r) Cortex(r)-A7 core, which operates at
> speeds up to 900 MHz.
> > > >
> > > > This patch adds basic MSL support for i.MX6ULZ, the i.MX6ULZ has
> > > > same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6] is to differentiate
> > > > i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and 1'b0 means
> i.MX6ULL.
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > >  arch/arm/mach-imx/anatop.c      | 20 ++++++++++++++++++++
> > > >  arch/arm/mach-imx/cpu.c         |  3 +++
> > > >  arch/arm/mach-imx/mach-imx6ul.c |  1 +
> > > >  arch/arm/mach-imx/mxc.h         |  7 +++++++
> > > >  arch/arm/mach-imx/pm-imx6.c     |  4 ++--
> > > >  5 files changed, 33 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-imx/anatop.c
> > > > b/arch/arm/mach-imx/anatop.c index 61f3d94..45d618a 100644
> > > > --- a/arch/arm/mach-imx/anatop.c
> > > > +++ b/arch/arm/mach-imx/anatop.c
> > > > @@ -31,6 +31,8 @@
> > > >  #define ANADIG_DIGPROG_IMX6SL	0x280
> > > >  #define ANADIG_DIGPROG_IMX7D	0x800
> > > >
> > > > +#define SRC_SBMR2		0x1c
> > > > +
> > > >  #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
> > > >  #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
> > > >  #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
> > > > @@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
> > > >  		major_part = (digprog >> 8) & 0xf;
> > > >  		minor_part = digprog & 0xf;
> > > >  		revision = ((major_part + 1) << 4) | minor_part;
> > > > +
> > > > +		if ((digprog >> 16) == MXC_CPU_IMX6ULL) {
> > > > +			void __iomem *src_base;
> > > > +			u32 sbmr2;
> > > > +
> > > > +			np = of_find_compatible_node(NULL, NULL,
> > > > +						     "fsl,imx6ul-src");
> > > > +			src_base = of_iomap(np, 0);
> > > > +			WARN_ON(!src_base);
> > > > +			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
> > > > +			iounmap(src_base);
> > > > +
> > > > +			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
> > > > +			if (sbmr2 & (1 << 6)) {
> > > > +				digprog &= ~(0xff << 16);
> > > > +				digprog |= (MXC_CPU_IMX6ULZ << 16);
> > > > +			}
> > > > +		}
> > > >  	}
> > > >
> > > >  	mxc_set_cpu_type(digprog >> 16 & 0xff); diff --git
> > > > a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c index
> > > > c6b1bf9..c73593e 100644
> > > > --- a/arch/arm/mach-imx/cpu.c
> > > > +++ b/arch/arm/mach-imx/cpu.c
> > > > @@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
> > > >  	case MXC_CPU_IMX6ULL:
> > > >  		soc_id = "i.MX6ULL";
> > > >  		break;
> > > > +	case MXC_CPU_IMX6ULZ:
> > > > +		soc_id = "i.MX6ULZ";
> > > > +		break;
> > > >  	case MXC_CPU_IMX6SLL:
> > > >  		soc_id = "i.MX6SLL";
> > > >  		break;
> > > > diff --git a/arch/arm/mach-imx/mach-imx6ul.c
> > > > b/arch/arm/mach-imx/mach-imx6ul.c index 6cb8a22..4ffe3c8 100644
> > > > --- a/arch/arm/mach-imx/mach-imx6ul.c
> > > > +++ b/arch/arm/mach-imx/mach-imx6ul.c
> > > > @@ -90,6 +90,7 @@ static void __init imx6ul_init_late(void)
> > > > static const char * const imx6ul_dt_compat[] __initconst = {
> > > >  	"fsl,imx6ul",
> > > >  	"fsl,imx6ull",
> > > > +	"fsl,imx6ulz",
> > >
> > > Can we have "fsl,imx6ull" on the DT compatible, so that we can save
> > > the changes on kernel side, like this and the clock driver update (patch #2)?
> > >
> > >   compatible = "fsl,imx6ull", "fsl,imx6ulz";
> > >
> > > I'm not sure if there is any problem with this approach.  But you
> > > can think about it.
> > >
> > > Shawn
> >
> > Using this approach will save the changes in clk-imx6ul.c and
> > mach-imx6ul.c, but other changes will be still needed, since it is
> > defined as a new SoC other than a i.MX6ULL with different fuse
> > settings. I can do the changes you suggested to save those 2 files
> > changes if you prefer this way, but current implementation should also
> > make sense if think about it from a new SoC perspective? What do you
> prefer?
> 
> I agree this is a different SoC, and other changes are reasonable.  I would just
> like to save some changes on kernel side with the help from device tree.
> 
> Shawn
 
OK, I will do changes to save those code on kernel and send out a V3 patch, thanks.

Anson.
