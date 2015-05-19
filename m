From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 May 2015 22:53:43 +0200
Subject: [PATCH 3/8] clk: sunxi: Add a driver for the PLL2
In-Reply-To: <CAGb2v67DguLiPKrg_LEo-Fwmfoh8nvv4iPV_4X30RBD-NFHcvg@mail.gmail.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64jVksA5rapnAPn9yefEeXnfFw5FwdnXPP0G9FvzWnVBg@mail.gmail.com>
 <20150515074520.GR4004@lukather>
 <CAGb2v64gbY1n4kVBc55hm=jwC3N-eKjWXCgEJr-+J6tYsD7sQA@mail.gmail.com>
 <20150515144439.GZ4004@lukather>
 <CAGb2v67DguLiPKrg_LEo-Fwmfoh8nvv4iPV_4X30RBD-NFHcvg@mail.gmail.com>
Message-ID: <20150519205343.GZ4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 03:58:09PM +0800, Chen-Yu Tsai wrote:
> >> >> > +#define SUN4I_PLL2_PRE_DIV_VALUE       4
> >> >> > +
> >> >> > +#define SUN4I_PLL2_OUTPUTS             4
> >> >> > +
> >> >> > +static void sun4i_a10_get_pll2_base_factors(u32 *freq, u32 parent_rate,
> >> >> > +                                           u8 *n, u8 *k, u8 *m, u8 *p)
> >> >> > +{
> >> >> > +       /*
> >> >> > +        * Normalize the frequency to a multiple of (24 MHz / Fixed
> >> >> > +        * PRE-DIV)
> >> >> > +        */
> >> >> > +       *freq = round_down(*freq, parent_rate / SUN4I_PLL2_PRE_DIV_VALUE);
> >> >> > +
> >> >> > +       /* We were called to round the frequency, we can return */
> >> >> > +       if (!n)
> >> >> > +               return;
> >> >> > +
> >> >> > +       *n = *freq * SUN4I_PLL2_PRE_DIV_VALUE / parent_rate;
> >> >> > +
> >> >> > +       /*
> >> >> > +        * Even though the pre-divider can be changed, we don't really
> >> >> > +        * care and we can just fix it to 4.
> >> >> > +        */
> >> >> > +       *m = SUN4I_PLL2_PRE_DIV_VALUE;
> >> >> > +}
> >> >> > +
> >> >> > +static struct clk_factors_config sun4i_a10_pll2_base_config = {
> >> >> > +       .mshift = SUN4I_PLL2_PRE_DIV,
> >> >> > +       .mwidth = 5,
> >> >> > +       .nshift = SUN4I_PLL2_N,
> >> >> > +       .nwidth = 7,
> >> >> > +
> >> >> > +       .m_zero = 1,
> >> >> > +       .n_zero = 1,
> >> >> > +};
> >> >> > +
> >> >> > +static const struct factors_data sun4i_a10_pll2_base_data __initconst = {
> >> >> > +       .enable = SUN4I_PLL2_ENABLE,
> >> >> > +       .table = &sun4i_a10_pll2_base_config,
> >> >> > +       .getter = sun4i_a10_get_pll2_base_factors,
> >> >> > +       .name = "pll2-base",
> >> >> > +};
> >> >> > +
> >> >> > +static DEFINE_SPINLOCK(sun4i_a10_pll2_lock);
> >> >> > +
> >> >> > +static void __init sun4i_pll2_setup(struct device_node *node)
> >> >> > +{
> >> >> > +       const char *clk_name = node->name, *parent;
> >> >> > +       struct clk_onecell_data *clk_data;
> >> >> > +       struct clk **clks, *base_clk;
> >> >> > +       void __iomem *reg;
> >> >> > +       u32 val;
> >> >> > +
> >> >> > +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> >> >> > +       if (IS_ERR(reg))
> >> >> > +               return;
> >> >> > +
> >> >> > +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> >> >> > +       if (!clk_data)
> >> >> > +               goto err_unmap;
> >> >> > +
> >> >> > +       clks = kcalloc(SUN4I_PLL2_OUTPUTS, sizeof(struct clk *), GFP_KERNEL);
> >> >> > +       if (!clks)
> >> >> > +               goto err_free_data;
> >> >> > +
> >> >> > +       base_clk = sunxi_factors_register(node, &sun4i_a10_pll2_base_data,
> >> >> > +                                         &sun4i_a10_pll2_lock, reg);
> >> >>
> >> >> Why aren't you using divs_clk for this? It seems right for the job.
> >> >
> >> > As far as I know, divs_clk can only handle a single divider, and not
> >> > two subsequent dividers like this one uses.
> >>
> >> I thought we were setting the post divider to 4 so the outputs match
> >> the names? Maybe we could get it in as is (with the above comment
> >> addressed), and refactor it later. I'm still stuck on factors_clk
> >> stuff....
> >
> > We are, but the pre-div is considered as the M factor, and the N
> > factor as N, so we can't really consider it as a single divider.
> 
> Isn't pre-div used by all the clocks?
> 
> The manual lists:
> 
> 1X = 48*N / pre-div / post-div / 2
> 2X = 48*N / pre-div / 4
> 4X = 48*N / pre-div / 2
> 8X = 48*N / pre-div
> 
> So couldn't you have a base factor clock as 24*N / pre-div,
> and the outputs as follows?
> 
> 1X = base / post-div
> 2X = base / 2
> 4X = base
> 8X = base * 2

Good thing that it's what was done in this patch then :)

> > Thinking a bit more about this, what we could do though, is splitting
> > the pll2-base clock in half, one that would expose a single divider
> > using clk-divider for the pre-divider, then a factor clock for the N
> > factor, and then multiple dividers for the post-divider and other
> > outputs.
> >
> > I wonder if that could not even be made that way for all the factors
> > clock. That would reduce the needed logic in the drivers a lot.
> 
> Taking apart what should be an integrated clock into separate parts
> kind of makes the clock tree ugly. :(

But it would remove the amount of code that we maintain, extend and
debug by our own in favor of common, well-tested and factored code.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/d1a3d2a0/attachment.sig>
