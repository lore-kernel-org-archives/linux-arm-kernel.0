From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Apr 2016 11:52:50 +0200
Subject: [PATCH v3 01/19] clk: composite: Add unregister function
In-Reply-To: <20160415222856.GQ14441@codeaurora.org>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160415222856.GQ14441@codeaurora.org>
Message-ID: <20160419095250.GA26050@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 15, 2016 at 03:28:56PM -0700, Stephen Boyd wrote:
> On 03/23, Maxime Ripard wrote:
> > The composite clock didn't have any unregistration function, which forced
> > us to use clk_unregister directly on it.
> > 
> > While it was already not great from an API point of view, it also meant
> > that we were leaking the clk_composite structure allocated in
> > clk_register_composite.
> > 
> > Add a clk_unregister_composite function to fix this.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> 
> I'm currently attempting to change the way clks are registered so
> that we don't return clk pointers from clk_register and have
> users add OF clk providers that return clk_hw pointers instead of
> clk pointers. Just a note, that this whole thing should be
> deleted in the next cycle if I can convert everything!

Ok.

> 
> >  drivers/clk/clk-composite.c  | 15 +++++++++++++++
> >  include/linux/clk-provider.h |  1 +
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> > index 1f903e1f86a2..b0f3b84ebd13 100644
> > --- a/drivers/clk/clk-composite.c
> > +++ b/drivers/clk/clk-composite.c
> > @@ -286,3 +286,18 @@ err:
> >  	kfree(composite);
> >  	return clk;
> >  }
> > +
> > +void clk_unregister_composite(struct clk *clk)
> > +{
> > +	struct clk_composite *composite;
> > +	struct clk_hw *hw;
> > +
> > +	hw = __clk_get_hw(clk);
> > +	if (!hw)
> > +		return;
> > +
> > +	composite = to_clk_composite(hw);
> > +
> > +	clk_unregister(clk);
> > +	kfree(composite);
> > +}
> 
> EXPORT_SYMBOL_GPL?

The register function is not registered, so I don't think that's
necessary.

> Do I need to pick this up?

I have a bunch of other clock patches that need this, so I guess it
would be easier if applied it directly with your acked-by, or if you
could apply it and give a stable branch I can base my future PR on.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/851f3306/attachment-0001.sig>
