From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 May 2015 09:53:01 +0200
Subject: [PATCH v2 02/10] clk: sunxi: Add support for multiple parents to
 gates
In-Reply-To: <5559ACC6.6050202@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-3-git-send-email-jenskuske@gmail.com>
 <20150517125014.GB4004@lukather> <5559ACC6.6050202@gmail.com>
Message-ID: <20150519075301.GT4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:11:34AM +0200, Jens Kuske wrote:
> Hi,
> 
> On 05/17/15 14:50, Maxime Ripard wrote:
> > Hi Jens,
> > 
> > On Fri, May 15, 2015 at 06:38:52PM +0200, Jens Kuske wrote:
> >> Some newer sunxi SoCs (A83T, H3) don't have individual registers for
> >> AHB1, APB1 and APB2 gates anymore, but one big bus gates area where each
> >> gate can have a different parent.
> >>
> >> The current clock driver sets the same parent for all gates in a group.
> >> This commit adds a new parents field to the gates_data structure, which
> >> allows us to specify an array of parent indices for every single gate.
> >>
> >> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> >> ---
> >>  drivers/clk/sunxi/clk-sunxi.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> >> index 9a82f17..17cba4d 100644
> >> --- a/drivers/clk/sunxi/clk-sunxi.c
> >> +++ b/drivers/clk/sunxi/clk-sunxi.c
> >> @@ -898,6 +898,8 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
> >>  
> >>  struct gates_data {
> >>  	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
> >> +	/* If used, ARRAY_SIZE(parents) has to be >= bitmap_weight(mask) */
> >> +	const u8 *parents;
> >>  };
> >>  
> >>  static const struct gates_data sun4i_axi_gates_data __initconst = {
> >> @@ -1000,16 +1002,21 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
> >>  					 struct gates_data *data)
> >>  {
> >>  	struct clk_onecell_data *clk_data;
> >> +	const char *parents[SUNXI_MAX_PARENTS];
> >>  	const char *clk_parent;
> >>  	const char *clk_name;
> >>  	void __iomem *reg;
> >> +	int npar = 0;
> >>  	int qty;
> >>  	int i = 0;
> >>  	int j = 0;
> >>  
> >>  	reg = of_iomap(node, 0);
> >>  
> >> -	clk_parent = of_clk_get_parent_name(node, 0);
> >> +	while (npar < SUNXI_MAX_PARENTS &&
> >> +	       (parents[npar] = of_clk_get_parent_name(node, npar)) != NULL)
> >> +		npar++;
> >> +	clk_parent = parents[0];
> >>  
> >>  	/* Worst-case size approximation and memory allocation */
> >>  	qty = find_last_bit(data->mask, SUNXI_GATES_MAX_SIZE);
> >> @@ -1026,6 +1033,9 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
> >>  		of_property_read_string_index(node, "clock-output-names",
> >>  					      j, &clk_name);
> >>  
> >> +		if (data->parents && !WARN_ON(data->parents[j] >= npar))
> >> +			clk_parent = parents[data->parents[j]];
> >> +
> > 
> > I'm currently removing that code, so I was more expecting a new
> > standalone driver for that clock.
> 
> How do you want to replace that code? To me this looks like a good way
> to set up all the different gates sunxi has.

By using clock-indices and moving all this gate stuff out of clk-sunxi
and into a new driver.

It's done already, I just need to make sure everything works at it
used to on all the SoCs.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/41783623/attachment.sig>
