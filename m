From: ping.bai@nxp.com (Jacky Bai)
Date: Sat, 24 Feb 2018 06:05:39 +0000
Subject: [PATCH v3 2/4] driver: clk: imx: add new gate/gate2 wrapper
 funtion
In-Reply-To: <20180224031232.GW3217@dragon>
References: <1517968819-12869-1-git-send-email-ping.bai@nxp.com>
 <1517968819-12869-2-git-send-email-ping.bai@nxp.com>
 <20180224031232.GW3217@dragon>
Message-ID: <HE1PR04MB311339152F018DB7D54CDD5B87C30@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v3 2/4] driver: clk: imx: add new gate/gate2 wrapper
> funtion
> 
> + Lucas
> 
> On Wed, Feb 07, 2018 at 10:00:17AM +0800, Bai Ping wrote:
> > Add new gate/gate2 wrapper function to register clocks with optional flags.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > ---
> >  drivers/clk/imx/clk.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> > d69c4bb..8076ec0 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -123,6 +123,13 @@ static inline struct clk *imx_clk_gate(const char
> *name, const char *parent,
> >  			shift, 0, &imx_ccm_lock);
> >  }
> >
> > +static inline struct clk *imx_clk_gate_flags(const char *name, const char
> *parent,
> > +		void __iomem *reg, u8 shift, unsigned long flags) {
> > +	return clk_register_gate(NULL, name, parent, flags |
> CLK_SET_RATE_PARENT, reg,
> > +			shift, 0, &imx_ccm_lock);
> > +}
> > +
> >  static inline struct clk *imx_clk_gate_dis(const char *name, const char
> *parent,
> >  		void __iomem *reg, u8 shift)
> >  {
> > @@ -137,6 +144,13 @@ static inline struct clk *imx_clk_gate2(const char
> *name, const char *parent,
> >  			shift, 0x3, 0, &imx_ccm_lock, NULL);  }
> >
> > +static inline struct clk *imx_clk_gate2_flags(const char *name, const char
> *parent,
> > +		void __iomem *reg, u8 shift, unsigned long flags) {
> > +	return clk_register_gate2(NULL, name, parent, flags |
> CLK_SET_RATE_PARENT, reg,
> > +			shift, 0x3, 0, &imx_ccm_lock, NULL); }
> > +
> 
> Lucas' patch 'clk: imx: add clock driver for i.MX8MQ CCM' [1] adds an
> imx_clk_gate2_flags() as well, but with different implementation.  Can you
> guys talk to each other to sort it out?
> 

For gate type clks, CLK_SET_RATE_PARENT flag should be a necessary flag, I think it is better to add this flag by default
for imx_clk_gate2_flags implementation. Lucas, agree?

BR
Jacky bai

> Shawn
> 
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.kernel.org%2Fpatch%2F10195759%2F&data=02%7C01%7Cping.bai%40nx
> p.com%7C95acb8b895a1428e00ab08d57b347bb7%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C636550387753283006&sdata=oLeHGXgDfDa88UV
> oRt4p35AaxTo8KTVjh0L32ONk1yI%3D&reserved=0
> 
> >  static inline struct clk *imx_clk_gate2_shared(const char *name,
> >  		const char *parent, void __iomem *reg, u8 shift,
> >  		unsigned int *share_count)
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=02%7C01%7
> >
> Cping.bai%40nxp.com%7C95acb8b895a1428e00ab08d57b347bb7%7C686ea1d
> 3bc2b4
> >
> c6fa92cd99c5c301635%7C0%7C0%7C636550387753283006&sdata=JCVrNx3A
> %2FynAF
> > twiNCsH2sekWwgvYyKgfcZmEiXdjss%3D&reserved=0
