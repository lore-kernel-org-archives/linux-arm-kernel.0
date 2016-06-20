From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jun 2016 10:54:58 +0200
Subject: [PATCH 01/20] clk: fixed-factor: Pass clk rates change to the
 parent
In-Reply-To: <20160617230533.27203.82622@quark.deferred.io>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160617230533.27203.82622@quark.deferred.io>
Message-ID: <20160620085458.GI26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 04:05:33PM -0700, Michael Turquette wrote:
> Quoting Maxime Ripard (2016-05-16 05:47:01)
> > A fixed factor clock, if it needs to change its rate, by definition do not
> > have any choice but to modify its parent rate.
> 
> Logically it makes sense to always propagate the rate-change request up
> to the parent for a fixed-factor clock if we desire to change its rate.
> However, I wonder if doing this for all users of fixed-factor-clock in
> DT is safe? Some users may be counting on it not changing.
> 
> There are 397 instances of fixed-factor-clock in .dts[i] today, so this
> change worries me a bit.

Understood.

> 
> > 
> > Add the CLK_SET_RATE_PARENT flag to that clock so that it can happen
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/clk-fixed-factor.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> > index 75cd6c792cb8..3363abd9b4ae 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -167,7 +167,8 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
> >         of_property_read_string(node, "clock-output-names", &clk_name);
> >         parent_name = of_clk_get_parent_name(node, 0);
> >  
> > -       clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
> > +       clk = clk_register_fixed_factor(NULL, clk_name, parent_name,
> > +                                       CLK_SET_RATE_PARENT,
> 
> An alternative would be to pass in the flags you want, somehow. For the
> clock you are trying to fix, is it inside of the SoC or external? If it
> is internal, and part of a larger clock controller driver, is this for
> the legacy style allwinner clock drivers that put everything in DT?

It is :(

What we could do, is have an extra compatible for that clock (like
"allwinner,sun4i-a10-pll3-x2" in that case), and set the flag only for
that compatible.

Would that work for you?

> If not, it would better to initialize it statically and shove this
> flag into the struct clk_init_data storage.

Hopefully, yes, that should be addressed by the new framework, but I
need reviews to get it merged ;)

Thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/b3e1e565/attachment-0001.sig>
