From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Sep 2014 10:24:21 +0200
Subject: [PATCH v3 03/12] clk: Add a function to retrieve phase
In-Reply-To: <20140928001732.19023.2496@quantum>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140928001732.19023.2496@quantum>
Message-ID: <20140929082421.GA4388@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sat, Sep 27, 2014 at 05:17:32PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-09-11 13:18:17)
> > The current phase API doesn't look into the actual hardware to get the phase
> > value, but will rather get it from a variable only set by the set_phase
> > function.
> > 
> > This will cause issue when the client driver will never call the set_phase
> > function, where we can end up having a reported phase that will not match what
> > the hardware has been programmed to by the bootloader or what phase is
> > programmed out of reset.
> > 
> > Add a new get_phase function for the drivers to implement so that we can get
> > this value.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/clk.c            | 10 ++++++++++
> >  include/linux/clk-provider.h |  5 +++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index d87661af0c72..113d75db371d 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1934,6 +1934,16 @@ int __clk_init(struct device *dev, struct clk *clk)
> >                 clk->accuracy = 0;
> >  
> >         /*
> > +        * Set clk's phase.
> > +        * Since a phase is by definition relative to its parent, just
> > +        * query the current clock phase, or just assume it's in phase.
> > +        */
> > +       if (clk->ops->get_phase)
> > +               clk->phase = clk->ops->get_phase(clk->hw);
> > +       else
> > +               clk->phase = 0;
> 
> I probably wasn't paying enough attention to this. Based on the
> coverletter I thought that v3 would introduce something like
> CLK_GET_PHASE_NOCACHE and stuff that logic into a __clk_get_phase
> function? Looks like this version of the series doesn't handle phases
> that can be changed by hardware (e.g. coming out of idle).
> 
> Correct me if I am wrong, but it looks like we retrieve the phase only
> once at init and then never again? The rest of the time we rely on
> clk->phase to always be accurate...

Yeah, I didn't have any use for it at the moment, and thought that if
someone ever needed it, it would be trivial to add, so I left it out.

If you want me to still do it, I can send an additional patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/fa5f33c9/attachment.sig>
