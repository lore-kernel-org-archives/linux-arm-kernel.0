From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 27 Feb 2017 08:47:47 +0100
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <1487929872.6887.11.camel@pengutronix.de>
References: <20161124112231.4297-1-wens@csie.org>
 <20161206172911.z6sbjzgqv3vfcrfh@lukather>
 <CAGb2v65uTH_PD28KqAhhzkE5zhLt54GUb7xXNxxe0xHW0A+xjQ@mail.gmail.com>
 <7603150.D9x404uVey@avalon> <20170223155437.GA24066@art_vandelay>
 <1487929872.6887.11.camel@pengutronix.de>
Message-ID: <20170227074747.GE27415@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 10:51:12AM +0100, Lucas Stach wrote:
> +CC Thierry, as the drm_panel maintainer.
> 
> Am Donnerstag, den 23.02.2017, 10:54 -0500 schrieb Sean Paul:
> > On Wed, Dec 07, 2016 at 11:48:55AM +0200, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > On Wednesday 07 Dec 2016 10:26:25 Chen-Yu Tsai wrote:
> > > > On Wed, Dec 7, 2016 at 1:29 AM, Maxime Ripard wrote:
> > > > > On Thu, Nov 24, 2016 at 07:22:31PM +0800, Chen-Yu Tsai wrote:
> > > > >> The panels shipped with Allwinner devices are very "generic", i.e.
> > > > >> they do not have model numbers or reliable sources of information
> > > > >> for the timings (that we know of) other than the fex files shipped
> > > > >> on them. The dot clock frequency provided in the fex files have all
> > > > >> been rounded to the nearest MHz, as that is the unit used in them.
> > > > >> 
> > > > >> We were using the simple panel "urt,umsh-8596md-t" as a substitute
> > > > >> for the A13 Q8 tablets in the absence of a specific model for what
> > > > >> may be many different but otherwise timing compatible panels. This
> > > > >> was usable without any visual artifacts or side effects, until the
> > > > >> dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> > > > >> rgb: Validate the clock rate").
> > > > >> 
> > > > >> The reason this check fails is because the dotclock frequency for
> > > > >> this model is 33.26 MHz, which is not achievable with our dot clock
> > > > >> hardware, and the rate returned by clk_round_rate deviates slightly,
> > > > >> causing the driver to reject the display mode.
> > > > >> 
> > > > >> The LCD panels have some tolerance on the dot clock frequency, even
> > > > >> if it's not specified in their datasheets.
> > > > >> 
> > > > >> This patch adds a 5% tolerence to the dot clock check.
> > > > > 
> > > > > As we discussed already, I really believe this is just as arbitrary as
> > > > > the current behaviour.
> > > > 
> > > > Yes. I agree. This patch is mainly to give something that works for
> > > > people who don't care about the details, and to get some feedback
> > > > from people that do.
> > > > 
> > > > > Some panels require an exact frequency,
> > > 
> > > There's no such thing as an exact frequency, there will always be some 
> > > tolerance (and if your display controller can really generate an exact 
> > > frequency I'd be very interested in that hardware :-)).
> > 
> > There is such thing as exact frequency when you have to worry about panel
> > warranty. We are fortunate, since we can talk to the panel manufacturer and
> > discuss which frequencies are tolerable inside the warranty. We usually hand
> > pick a rate/mode within these constraints.
> > 
> > Also, even though things *look* ok on the panel at a certain clock rate, running
> > outside the specified clock could damage the hardware.
> > 
> > I don't think it's unreasonable to add tolerances to drm_panel, since they will
> > differ in what is acceptable. The tricky part is teasing out what the tolerances
> > are.
> 
> The drm_panel already allows to specify all panel timings in pairs of
> min/typical/max. Just use this instead of some arbitrary tolerance.
> 
> I know most panels currently only expose a fixed mode, but it's not hard
> to convert this into a display_timing if you can get hold of the display
> datasheet. A lot of the panel datasheets I had to deal with lately
> actually specify all the required information. Most of the time you need
> to sanity check things, as most vendors seem to produce them by "copy
> the last datasheet we made and change only necessary fields", but that
> really isn't a hard job.

Agreed. Back at the time support for min/typ/max timings was introduced
specifically to address such issues. Conversion to those timings from a
fixed mode is as simple as making min = max = typ, where typ is the DRM
display mode value.

There's a helper that will return a DRM display mode based on the
typical values for drivers that don't care (i.e. most) and drivers that
do care can simply use the timings directly and adjust as necessary. It
would be rather backwards to add tolerances to display drivers, because
that's not where the tolerances are defined. Panels impose the
restrictions, so it should be panel drivers that contain the data.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/7d408ba0/attachment.sig>
