From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 15 Dec 2017 16:54:15 +0100
Subject: [PATCH 0/4 v5] Support bridge timings
In-Reply-To: <CACRpkdYjSy5t_73g1UejxcL1JXcFUVntA_oDHV2G4ro4zaHNVw@mail.gmail.com>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
 <CACRpkdYjSy5t_73g1UejxcL1JXcFUVntA_oDHV2G4ro4zaHNVw@mail.gmail.com>
Message-ID: <20171215155415.GT26573@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 01:30:24PM +0100, Linus Walleij wrote:
> On Fri, Dec 15, 2017 at 1:10 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > - The connector is apparently not the right abstraction to carry
> >   the detailed timings specification between DRI drivers and bridge
> >   drivers.
> >
> > - Instead put detailed timing data into the bridge itself as an
> >   optional information pointer.
> 
> Notice that this is just my fumbling attempts to deal with the situation.
> 
> Laurent made me understand what the actual technical problem was,
> how come my pixels were flickering.
> 
> Both Laurent and DVetter mentioned that we may need to convey
> information between the bridge and the display engine in some
> way.
> 
> Alternatively I could go and hack on adding this to e.g. drm_display_info
> which was used in the previous patch sets by setting the negede flag
> in bus_formats.
> 
> I don't know. struct drm_display_info is getting a bit heavy as
> container of misc settings related to "some kind of display".
> The bridge isn't even a display itself, that is on the other side
> of it. So using the connector and treating a bridge as "some kind
> of display" seems wrong too.
> 
> Is there a third way?

If you don't plan to nest bridges too deeply, there is. Atm we have 2
modes in drm_crtc_state:

- mode, which is what userspace requested, and what it expects logically
  to be the actual real thing. I.e. timing, resolution and all that that
  userspace can observe (through plane positioning and vblank timestamps)
  should match this mode. For external screens this should also match
  what's physically going over the cable.

- adjusted_mode, which is something entirely undefined and to be used by
  drivers internally. Most drivers use it as the thing that's actually
  transported between the CRTC and the encoder.

There's a few common reasons for adjusted mode to be different:
- integrated panel, and your CRTC has a scaler. In that case the
  userspace-requested mode is what you feed into into the scaler, and the
  adjusted mode is what comes out of your scaler and then goes down the
  wire to the panel.

- your encoder is funky, and e.g. transcodes to the output mode itself,
  but expects that you program the input mode always the same. Usual
  reasons for this are transcoders that always want non-interlaced mode
  (and do the interlacing themselves), if the transcoder has some scaler
  itself (some TV-out transcoders had that), or if it has a strict
  expectation about signalling edges and stuff (and then transcodes the
  signal again). DACs are common doing that.
 
Anyway, sounds like your bridge is of the 2nd kind, so all you have to do
is
- in your bridge->mode_fixup function, adjust the adjusted_mode as needed
- in your pl111 driver, program the adjusted mode, not the originally
  requested mode

adjusted mode is set to be a copy of the requested mode by atomic helpers,
so this should keep working as-is on any other bridge driver.

No idea why I didn't tell you this right away, or maybe I'm missing
something this time around.

> I'm just a bit lost.

Once your un-lost, pls review the docs for drm_crtc_state and the various
mode_fixup functions, to make sure they're clear on how this is supposed
to work. Might need a new overview DOC: comment that ties it all together.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
