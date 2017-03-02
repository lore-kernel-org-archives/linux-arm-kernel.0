From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 02 Mar 2017 12:28:02 +0100
Subject: [PATCH v2 2/3] clk: meson-gxbb: Add MALI clocks
In-Reply-To: <6cd2e42d-6169-a2f0-db33-e13ca1619a41@baylibre.com>
References: <1488365164-22861-1-git-send-email-narmstrong@baylibre.com>
 <1488365164-22861-3-git-send-email-narmstrong@baylibre.com>
 <20170301191119.GR25384@codeaurora.org>
 <6cd2e42d-6169-a2f0-db33-e13ca1619a41@baylibre.com>
Message-ID: <1488454082.2420.3.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-03-02 at 12:07 +0100, Neil Armstrong wrote:
> Hi Stephen,
> 
> On 03/01/2017 08:11 PM, Stephen Boyd wrote:
> > On 03/01, Neil Armstrong wrote:
> > > diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> > > index a52063f..31f6090 100644
> > > --- a/drivers/clk/meson/gxbb.c
> > > +++ b/drivers/clk/meson/gxbb.c
> > > @@ -634,6 +634,131 @@
> > > ?	},
> > > ?};
> > > ?
> > > +/*
> > > + * The MALI IP is clocked by two identical clocks (mali_0 and
> > > mali_1)
> > > + * muxed by a glitch-free switch.
> > > + */
> > > +
> > > +static u32 mux_table_mali_0_1[] = {0, 1, 2, 3, 4, 5, 6, 7};
> > > +const char *gxbb_mali_0_1_parent_names[] = {
> > 
> > static?
> 
> Will do !
> 
> > 
> > > +	"xtal", "gp0_pll", "mpll2", "mpll1", "fclk_div7",
> > > +	"fclk_div4", "fclk_div3", "fclk_div5"
> > > +};
> > > +
> > 
> > [..]
> > > +	.reg = (void *)HHI_MALI_CLK_CNTL,
> > > +	.bit_idx = 24,
> > > +	.lock = &clk_lock,
> > > +	.hw.init = &(struct clk_init_data){
> > > +		.name = "mali_1",
> > > +		.ops = &clk_gate_ops,
> > > +		.parent_names = (const char *[]){ "mali_1_div"
> > > },
> > > +		.num_parents = 1,
> > > +		.flags = (CLK_SET_RATE_PARENT |
> > > CLK_IGNORE_UNUSED),
> > > +	},
> > > +};
> > > +
> > > +static u32 mux_table_mali[] = {0, 1};
> > > +const char *gxbb_mali_parent_names[] = {
> > 
> > static?
> > 
> > > +	"mali_0", "mali_1"
> > > +};
> > 
> > [...]
> > > ?static struct clk_mux *gxbb_clk_muxes[] = {
> > > ?	&gxbb_mpeg_clk_sel,
> > > ?	&gxbb_sar_adc_clk_sel,
> > > +	&gxbb_mali_0_sel,
> > > +	&gxbb_mali_1_sel,
> > > +	&gxbb_mali,
> > > ?};
> > > ?
> > > ?static struct clk_divider *gxbb_clk_dividers[] = {
> > 
> > Can these arrays be const? If so, please do that in a separate
> > patch.
> 
> Hmm, these were introduced by jerome, he should update them
> accordingly.
> 

Will do

> > > ?	&gxbb_mpeg_clk_div,
> > > ?	&gxbb_sar_adc_clk_div,
> > > +	&gxbb_mali_0_div,
> > > +	&gxbb_mali_1_div,
> > > ?};
> 
> 
> Thanks,
> Neil
