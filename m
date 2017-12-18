From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 18 Dec 2017 13:10:09 +0200
Subject: [PATCH 0/4 v5] Support bridge timings
In-Reply-To: <33bc6bf1-1730-e02a-2a03-17a60f0e5c65@samsung.com>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
 <20171215155415.GT26573@phenom.ffwll.local>
 <33bc6bf1-1730-e02a-2a03-17a60f0e5c65@samsung.com>
Message-ID: <15607572.kv0b7FBjGH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On Monday, 18 December 2017 10:43:51 EET Andrzej Hajda wrote:
> On 15.12.2017 16:54, Daniel Vetter wrote:
> > On Fri, Dec 15, 2017 at 01:30:24PM +0100, Linus Walleij wrote:
> >> On Fri, Dec 15, 2017 at 1:10 PM, Linus Walleij <linus.walleij@linaro.org> 
wrote:
> >>> - The connector is apparently not the right abstraction to carry
> >>> 
> >>>   the detailed timings specification between DRI drivers and bridge
> >>>   drivers.
> >>> 
> >>> - Instead put detailed timing data into the bridge itself as an
> >>> 
> >>>   optional information pointer.
> >> 
> >> Notice that this is just my fumbling attempts to deal with the situation.
> >> 
> >> Laurent made me understand what the actual technical problem was,
> >> how come my pixels were flickering.
> >> 
> >> Both Laurent and DVetter mentioned that we may need to convey
> >> information between the bridge and the display engine in some
> >> way.
> >> 
> >> Alternatively I could go and hack on adding this to e.g. drm_display_info
> >> which was used in the previous patch sets by setting the negede flag
> >> in bus_formats.
> >> 
> >> I don't know. struct drm_display_info is getting a bit heavy as
> >> container of misc settings related to "some kind of display".
> >> The bridge isn't even a display itself, that is on the other side
> >> of it. So using the connector and treating a bridge as "some kind
> >> of display" seems wrong too.
> >> 
> >> Is there a third way?
> > 
> > If you don't plan to nest bridges too deeply, there is. Atm we have 2
> > modes in drm_crtc_state:
> > 
> > - mode, which is what userspace requested, and what it expects logically
> >   to be the actual real thing. I.e. timing, resolution and all that that
> >   userspace can observe (through plane positioning and vblank timestamps)
> >   should match this mode. For external screens this should also match
> >   what's physically going over the cable.
> > 
> > - adjusted_mode, which is something entirely undefined and to be used by
> >   drivers internally. Most drivers use it as the thing that's actually
> >   transported between the CRTC and the encoder.
> > 
> > There's a few common reasons for adjusted mode to be different:
> > - integrated panel, and your CRTC has a scaler. In that case the
> >   userspace-requested mode is what you feed into into the scaler, and the
> >   adjusted mode is what comes out of your scaler and then goes down the
> >   wire to the panel.
> > 
> > - your encoder is funky, and e.g. transcodes to the output mode itself,
> >   but expects that you program the input mode always the same. Usual
> >   reasons for this are transcoders that always want non-interlaced mode
> >   (and do the interlacing themselves), if the transcoder has some scaler
> >   itself (some TV-out transcoders had that), or if it has a strict
> >   expectation about signalling edges and stuff (and then transcodes the
> >   signal again). DACs are common doing that.
> > 
> > Anyway, sounds like your bridge is of the 2nd kind, so all you have to do
> > is
> > - in your bridge->mode_fixup function, adjust the adjusted_mode as needed
> > - in your pl111 driver, program the adjusted mode, not the originally
> > 
> >   requested mode
> > 
> > adjusted mode is set to be a copy of the requested mode by atomic helpers,
> > so this should keep working as-is on any other bridge driver.
> > 
> > No idea why I didn't tell you this right away, or maybe I'm missing
> > something this time around.
> 
> Using adjusted_mode will probably help here, fortunately the pipeline is
> short in this case and one adjusted_mode per pipeline should be enough.
> But there is more fundamental problem here - drm core does not provide a
> way to interact between adjacent components of the pipeline. So they are
> not able to negotiate/exchange parameters specific for the video link
> between them.
> adjusted_mode is one per pipeline and will note scale without hacks.
> Anyway I remember multiple attempts to somehow workaround this issue,
> for example:
> - passing DSI specific settings (currently performed via DSI control bus),
> - passing info about panel command mode parameters(by adding these
> properties to crtc node),
> - passing bus flags from panel to encoder/bridge (via drm_display_mode,
> nacked if I remember, I do not know if/how it is solved actually).
> 
> Another concern is that adjusted_mode used inside drm driver (ie.
> between encoder and crtc) is something private per drm driver. In this
> case we have bridge which theoretically should work with ANY video
> source with compatible video bus: encoder, or another bridge before it.
> So adjusted_mode is not private anymore, and will be problematic if two
> different bridges/encoders will use it differently.

I agree completely. I believe we'll need to introduce new bridge operations to 
report and negotiate timings along the pipeline. Ideally the same operations 
would also be implemented by panel drivers for easier handling of the 
pipeline, in which case we'll need a common data structure for both bridges 
and panels. We can however start with bridges and extend that to panels in a 
second step.

I'm currently reworking the bridge and panel code for the omapdrm driver, 
which uses omapdrm-specific drivers not based on the drm_bridge and drm_panel 
API. The goal is to replace them by standard bridge and panel drivers. As part 
of that work I plan to propose new operations for bridges as discussed above. 
I can't tell however when the first version will be ready, so if you want to 
give it a go, feel free to do so.

> >> I'm just a bit lost.
> > 
> > Once your un-lost, pls review the docs for drm_crtc_state and the various
> > mode_fixup functions, to make sure they're clear on how this is supposed
> > to work. Might need a new overview DOC: comment that ties it all together.

-- 
Regards,

Laurent Pinchart
