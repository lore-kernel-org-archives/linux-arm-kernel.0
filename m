From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Mar 2015 14:54:31 +0100
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <20150317094738.GF4927@pengutronix.de>
References: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
 <1426485311-31428-4-git-send-email-s.hauer@pengutronix.de>
 <20150316070339.GA25487@pengutronix.de>
 <20150317094738.GF4927@pengutronix.de>
Message-ID: <20150317135431.GH10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

On Tue, Mar 17, 2015 at 10:47:38AM +0100, Sascha Hauer wrote:
> On Mon, Mar 16, 2015 at 08:03:39AM +0100, Uwe Kleine-K?nig wrote:
> > On Mon, Mar 16, 2015 at 06:55:09AM +0100, Sascha Hauer wrote:
> > > +static const char *axi_parents[] __initconst = {
> > > +	"clk26m",
> > > +	"syspll_d3",
> > > +	"syspll_d4",
> > > +	"syspll_d6",
> > > +	"univpll_d5",
> > > +	"univpll2_d2",
> > > +	"syspll_d3p5"
> > > +};
> > __initconst should only be used for const data, but this array isn't
> > const. Only the strings the pointer in this array point to are constant.
> 
> That may be true, but the way it's currently done compiles through
> without warnings with CONFIG_DEBUG_SECTION_MISMATCH enabled.
CONFIG_DEBUG_SECTION_MISMATCH doesn't catch this type of error.

> 
> > 
> > So you have to use either
> > 
> > 	static const char *axi_parents[] __initdata = {
> 
> This results in:
> 
> drivers/clk/mediatek/clk-mt8173.c:515:20: error: i2s3_b_ck_parents causes a section type conflict with infra_clks
>  static const char *i2s3_b_ck_parents[] __initdata = {
The compiler catches if a single section contains both modifiable and
constant data. The linker doesn't seem to check anything here. So you
have to do it consistently per compilation unit. (I'm not aware of any
problems if you do it consistently wrong in a compilation unit, but
better do it consistently right :-)
I'm sure getting it right isn't that hard, so IMHO this should be fixed
before your patch is applied.

> which can be avoided with static const char * const axi_parents[] __initdata
This should be __initconst (to do it consistently right).

> > or
> > 
> > 	static const char * const axi_parents[] __initconst = {
> 
> Which results in:
> 
> drivers/clk/mediatek/clk-mt8173.c:568:2: warning: initialization discards 'const' qualifier from pointer target type
>   MUX_GATE(TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents, 0x00d0, 16, 2, 23),
> 
> With the following patch this can also be resolved. Until this is merged
> (or I have the OK from Mike to add this in front of this series) I
> prefer to keep it like it is at the moment.
I remember trying something like that some time ago, but without
success. I didn't modify clk-composite.c but still I would be surprised
if it were that easy.

(The result were commits like 4a043d79dc2d and 145047de9940.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
