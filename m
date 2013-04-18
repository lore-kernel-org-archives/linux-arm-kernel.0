From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Apr 2013 23:15:29 +0800
Subject: [PATCH V2] ARM: i.MX5: Allow DT clock providers
In-Reply-To: <516FB0A5.9050903@parkeon.com>
References: <20130415080741.20173.70704.stgit@localhost>
 <20130418063056.GA20566@S2101-09.ap.freescale.net>
 <516FB0A5.9050903@parkeon.com>
Message-ID: <20130418151527.GF2222@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 10:36:53AM +0200, Martin Fuzzey wrote:
> On 18/04/13 08:30, Shawn Guo wrote:
> >+static struct clk * __init mx5_obtain_fixed_clock_from_dt(const char *name)
> >+{
> >+#ifdef CONFIG_OF
> >We have selected USE_OF at the sub-architecture level, so the ifdef
> >plays nothing here.
> Ah ok so what happens on non DT platforms (looks like Babbage)
> Does this mean that there is an empty DT in that case?
> 
I think function of_find_* will return NULL for non-DT boot, so
ERR_PTR(-ENODEV) will just be returned from
mx5_obtain_fixed_clock_from_dt().

> I was going by the existing code which already has this #ifdef
> 
Right.  We just haven't got the chance to clean them up.

> >>+	struct of_phandle_args phandle = {0};
> >>+	struct clk *clk = ERR_PTR(-ENODEV);
> >>+	char *compatible;
> >>+
> >>+	compatible = kasprintf(GFP_KERNEL, "fsl,imx-%s", name);
> >What about finding the node by path as below?
> >
> >	path = kasprintf(GFP_KERNEL, "/clocks/%s", name);
> >	phandle.np = of_find_node_by_path(path);
> >
> >I have to admit that those imx custom compatibles for fixed-clock
> >shouldn't necessarily be there at all.  Let's stop spreading the use.
> I can't find anything in the DT binding documentation that says the
> clocks have to be
> under /clocks  (but then again the fsl,imx- compatible string isn't
> documented either).
> 
> My understanding of DT is that the absolute node path is generally
> unimportant with
> the exception of a few special nodes like /, /memory, /chosen
> 
I think the function of_find_node_by_path() is created not only for
finding these special nodes.

> But I don't have a strong opinion on this - if the consensus is that
> path based lookup
> is better I'll do that.
> 
We just want to save the custom compatible string which are there only
for finding a fixed-clock, while node name/path can be used for
searching.

Shawn
