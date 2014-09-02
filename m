From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Sep 2014 11:34:28 +0200
Subject: [PATCH v2 03/12] clk: Add a function to retrieve phase
In-Reply-To: <20140901190054.5251.56409@quantum>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140901190054.5251.56409@quantum>
Message-ID: <20140902093428.GS15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 01, 2014 at 12:00:54PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-08-30 13:03:02)
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
> >  drivers/clk/clk.c            | 17 ++++++++++++++---
> >  include/linux/clk-provider.h |  5 +++++
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index d87661af0c72..7dbceca694f1 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1797,8 +1797,8 @@ out:
> >   * clk_get_phase - return the phase shift of a clock signal
> >   * @clk: clock signal source
> >   *
> > - * Returns the phase shift of a clock node in degrees, otherwise returns
> > - * -EERROR.
> > + * Returns the phase shift of a clock node in degrees. Any negative
> > + * values are errors.
> >   */
> >  int clk_get_phase(struct clk *clk)
> >  {
> > @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
> >                 goto out;
> >  
> >         clk_prepare_lock();
> > -       ret = clk->phase;
> > +
> > +       if (clk->phase) {
> 
> So if a phase is zero, then we fall through and query the hardware?
> Seems like this case might be hit a lot for clocks that implement
> .get_phase but never have their phase shifted, and accesses to the
> registers may be much slower than to memory.

Yep, which is exactly why I'm not that proud of it :)

> Do you expect the phase to be changed behind our backs? E.g. firmware
> changes it, or coming in and out of idle state, etc. If not then we can
> store the phase at clock registration time and use a cached value.

This is exactly what happens in our case. Since in order to use the
MMC, you have to change the phase of the output and sample clocks,
every time the firmware will have to use the MMC, it will change these
clocks phase. Which happens pretty much all the time.

> See how the CLK_GET_RATE_NOCACHE and CLK_GET_ACCURACY_NOCACHE flags are
> used for details on how we can handle the case where the phase might
> change behind our back.

Ah, yes, of course. Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/a528d5ca/attachment.sig>
