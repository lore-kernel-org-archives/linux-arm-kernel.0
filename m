From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Feb 2016 11:02:17 +0100
Subject: [PATCH 1/3] clk: sunxi: improve mux_clk error handling and
 reporting
In-Reply-To: <56C2EFD5.5080604@arm.com>
References: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
 <1455289913-29514-2-git-send-email-andre.przywara@arm.com>
 <CAGb2v65hxNiY8XAL=yBbV4qazscJd+six432CKWAm+GfM6bd2Q@mail.gmail.com>
 <56C2EFD5.5080604@arm.com>
Message-ID: <20160216100217.GK4344@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 09:45:57AM +0000, Andre Przywara wrote:
> Hi Chen-Yu,
> 
> On 13/02/16 02:44, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Fri, Feb 12, 2016 at 11:11 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> >> We now catch and report a failing ioremap, also a failure in the final
> >> step of the clock registration is now handled and reported.
> >> Also warnings are turned into errors.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  drivers/clk/sunxi/clk-sunxi.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> >> index 49ce283..361f396 100644
> >> --- a/drivers/clk/sunxi/clk-sunxi.c
> >> +++ b/drivers/clk/sunxi/clk-sunxi.c
> >> @@ -690,11 +690,15 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
> >>         int i;
> >>
> >>         reg = of_iomap(node, 0);
> >> +       if (!reg) {
> >> +               pr_err("Could not map registers for mux-clk: %s\n", node->name);
> > 
> > of_node_full_name(node->name) is better. node->name is almost always "clk",
> > which is useless. (Unless someone goes through the dts files to replace all
> > of them.)
> 
> Good point. I both fixed the code here as well as amended the node names
> in the A64 DT.

I'm not sure what there is to amend in the DTSI. The node name is
defined as the class or function of the device, so all clocks should
be called clk@<something>.

This doesn't work for clocks that don't have a meaningful unit address
(like the oscillators), but it should be the exception, rather than
the norm.

> 
> > 
> >> +               return NULL;
> >> +       }
> >>
> >>         i = of_clk_parent_fill(node, parents, SUNXI_MAX_PARENTS);
> >>         if (of_property_read_string(node, "clock-output-names", &clk_name)) {
> >> -               pr_warn("%s: could not read clock-output-names for \"%s\"\n",
> >> -                       __func__, clk_name);
> >> +               pr_err("%s: could not read clock-output-names for \"%s\"\n",
> >> +                      __func__, clk_name);
> > 
> > Same here. clk_name defaults to node->name. If you could, please replace it.
> 
> Really? Isn't clk_name directly from the DT clock-output-names strings here?

Only if there is a clock-output-names property in the node. If not,
the string will not be modified by of_property_read_string, and you'll
default to the initial value of clk_name, in this case node->name or
node->full_name.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/bda9826e/attachment.sig>
