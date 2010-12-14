From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 14 Dec 2010 10:30:56 +0800
Subject: [RFC] i.MX clock support
In-Reply-To: <20101213102538.GB6017@pengutronix.de>
References: <20101213102538.GB6017@pengutronix.de>
Message-ID: <20101214023056.GA546@b20223-2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

On Mon, Dec 13, 2010 at 11:25:38AM +0100, Sascha Hauer wrote:
> Hi,
> 
> I played around with Jeremys common struct clk patches and I think they
> offer a great potential for cleaning up the i.MX51 (and i.MX in general)
> clock support.
> 
> Currently on i.MX we have clocks implementing varying sets of the clk
> functions and most of the time the functions are reimplemented for
> each clock. The i.MX51 clock support shows that this becomes
> unmaintainable. The following patch allows for a different approach.
> Instead of making each clock a full featured clock we split the clocks
> into their basic building blocks. Currently we have:
> 
> * multiplexer   Choose from a set of parent clocks (clk_[get|set]_parent)
> * divider       clock divider (clk_[get|set|round]_rate)
> * gates         clk_[en|dis]able
> * groups        Group together clocks which should be enabled at once.
> 
> Of course these are the building blocks on other architectures aswell,
> so we may move parts of the patch to a more generic place.
The building blocks  are reasonable. But your implementation is breaking clock
boundaries. One macro clock is divided to some sub clocks (gate, divider,
multiplexer and group). It makes things a little complicated. Why not just use:
struct mxc_clk {
	.multiplexer =
	.divider =
	.gates =
	.groups =
}
And there're many clk_parent_xxx. If it's calling its own macro clock set_rate
and dis/enable, it's ok. But if it's calling its macro clock's real parents,
it's not a correct way. 
And I'm not sure it's Jeremy's original intent to use comm clk struch in such way.
> 
> I made a experimental implementation for i.MX27 and i.MX51, find the
> patches here:
> 
> git://git.pengutronix.de/git/imx/linux-2.6.git clk-common-imx
> 
> The i.MX27 patches are boot tested, the i.MX51 patches are compile tested
> only and probably contain bugs preventing the tree from booting on an
> i.MX51.
> 
> I am not willing to accept patches for adding i.MX50 support in the mess
> we currently have. These patches offer a way to cleanup the clock support
> and the i.MX50 may be a good test bed for an implementation without
> old cruft to worry about. That said the following patch is not set in
> stone, it's a request for comments and I'm of course open to other
> suggestions, but it's clear that we have to do something.
correct.
> 
> Sascha
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/clock-common.c       |  406 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/clock.h |  234 ++++++++++++++++++-
>  2 files changed, 637 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/clock-common.c b/arch/arm/plat-mxc/clock-common.c
> index fbe1873..6f83c17 100644
> --- a/arch/arm/plat-mxc/clock-common.c
> +++ b/arch/arm/plat-mxc/clock-common.c
> @@ -166,6 +166,412 @@ struct clk_ops clk_mxc_ops = {
>         .set_parent     = clk_mxc_set_parent,
>  };
> 
> +static int clk_parent_enable(struct clk *clk)
> +{
> +       struct clk *parent = clk_get_parent(clk);
> +
> +       if (IS_ERR(parent))
> +               return -ENOSYS;
> +
> +       return clk_enable(parent);
> +}
> +
> +static void clk_parent_disable(struct clk *clk)
> +{
> +       struct clk *parent = clk_get_parent(clk);
> +
> +       if (IS_ERR(parent))
> +               return;
> +
> +       clk_disable(parent);
> +}
> +
> +static unsigned long clk_parent_get_rate(struct clk *clk)
> +{
> +       struct clk *parent = clk_get_parent(clk);
> +
> +       if (IS_ERR(parent))
> +               return 0;
> +
> +       return clk_get_rate(parent);
> +}
> +
> +static long clk_parent_round_rate(struct clk *clk, unsigned long rate)
> +{
> +       struct clk *parent = clk_get_parent(clk);
> +
> +       if (IS_ERR(parent))
> +               return -ENOSYS;
> +
> +       return clk_round_rate(parent, rate);
> +}
> +
> +static int clk_parent_set_rate(struct clk *clk, unsigned long rate)
> +{
> +       struct clk *parent = clk_get_parent(clk);
> +
> +       if (IS_ERR(parent))
> +               return -ENOSYS;
> +
> +       return clk_set_rate(parent, rate);
> +}
> +
> +/* clk gate support */
> +
> +#define to_clk_gate(clk) (container_of(clk, struct clk_gate, clk))
> +
> +static int clk_gate_enable(struct clk *clk)
> +{
> +       struct clk_gate *gate = to_clk_gate(clk);
> +       u32 val, mask;
> +
> +       if (gate->flags & CLK_GATE_TWO_BITS)
> +               mask = 3 << (gate->shift * 2);
I'm not sure whether it's always 3.
> +       else
> +               mask = 1 << (gate->shift);
> +
> +       val = readl(gate->reg);
> +       val |= mask;
> +       writel(val, gate->reg);
> +
> +       return 0;
> +}
> +
 
Thanks
Richard
