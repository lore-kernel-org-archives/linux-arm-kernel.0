From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Sep 2014 12:20:26 +0200
Subject: [PATCH v2 03/12] clk: Add a function to retrieve phase
In-Reply-To: <5402F5D6.4080100@redhat.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
 <5402F5D6.4080100@redhat.com>
Message-ID: <20140901102026.GL15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 31, 2014 at 12:15:50PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08/30/2014 10:03 PM, Maxime Ripard wrote:
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
> >  		goto out;
> >  
> >  	clk_prepare_lock();
> > -	ret = clk->phase;
> > +
> > +	if (clk->phase) {
> > +		ret = clk->phase;
> > +		goto out_unlock;
> > +	}
> 
> 0 is a valid phase, so this will cause the phase to
> be read from the hardware each time if the phase is 0.
> 
> Perhaps make clk->phase signed (if it is not already), init it
> to -1, and check for it not being -1 ?

Yeah, I'm not really proud of this code either, but yours would expose
this -1 into debugfs, so I'm not sure it's really better :) 

(with -1 being a valid phase too)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/c1ed9049/attachment-0001.sig>
