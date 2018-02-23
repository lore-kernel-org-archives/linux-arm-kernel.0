From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 23 Feb 2018 13:35:36 +0100
Subject: [PATCH 2/3] arm64: dts: rockchip: add rk3328 display nodes
In-Reply-To: <318d8cd4-7da5-929a-fc01-41558aa12040@arm.com>
References: <20180216223817.2821-1-heiko@sntech.de>
 <51423eea-c127-4922-bd90-5b05bb5aef48@arm.com>
 <318d8cd4-7da5-929a-fc01-41558aa12040@arm.com>
Message-ID: <4622499.nYCCa0LjWm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Am Freitag, 23. Februar 2018, 13:27:55 CET schrieb Robin Murphy:
> On 22/02/18 13:01, Robin Murphy wrote:
> > On 21/02/18 21:57, Heiko Stuebner wrote:
> > [...]
> >>> I guess it might just be a case of the VOP and/or HDMI clocks struggling
> >>> to attain an appropriate pixel clock, but the failure mode is really
> >>> non-obvious - if the monitor is plugged in at boot I get 4 or 5 of the
> >>> DRM_WARNs at various points, about 160 VOP interrupts somewhere along
> >>> the line, and HDMI interrupts at a constant rate of around two per
> >>> second; plugging it in after boot, however, just seems to silently do
> >>> nothing (IIRC hotplugging the TV similarly did work as expected). If I
> >>> find the time I might go back and try forcing a 60Hz mode to narrow
> >>> things down a bit more.
> >>
> >> As I only have a standard 1080p display it's hard to check those edge 
> >> cases,
> >> but the struggle for display frequencies follows us for quite some time
> >> already.
> >>
> >> The current default is to source the display clock from the hdmi-phy
> >> which contains its own pll, so I guess first order of business should
> >> probably be to determine which rate gets requested for your display
> >> and which rate gets set - as I'm guessing that we're missing rates.
> >>
> >> DRM_WARNS would be interesting I guess, can you post them?
> >> As for your hdmi-interrupts, from the dw-hdmi or the hdmi-phy?
> > 
> > Oops, my mistake, it's just a regular WARN() at 
> > drivers/gpu/drm/drm_atomic_helper.c:1348 - the IRQs I'm 99% sure were 
> > from dw-hdmi (I really should stop doing this way past bedtime then 
> > trying to remember the details days later...)
> > 
> > I'll turn on all the debug options and do some more digging over the 
> > weekend (and actually save some logs this time!)
> 
> OK, I found time to do some quick testing last night (verbose log 
> attached) - it does indeed look like pretty much all the modes are being 
> rejected. Of all the various overrides I tried, "video=800x600 at 60" does 
> actually work, but it's the only one (not even plain old 640x480 VGA!)
> 
> Interestingly, the vblank timeouts only happen for 1280x1024 modes - 
> lower resolutions (e.g. 1024x768) still don't produce an output signal, 
> but don't provoke the warning either.
> 
> FWIW, the above behaviours also seem reproducible with 
> "drm.edid_firmware=edid/{1024x768,1280x1024}.bin" if that helps with 
> testing. Otherwise, let me know where to start hacking on drivers ;)

I'm in the middle of the Netherlands right now on vacation, so I'm
probably not doing any display hacking till the middle of next week.

So depending on your spare time, I'd guess it might be interesting to
also activate the debug output in the hdmiphy driver itself to see
requested and actually set rates for the pll inside the hdmiphy.

Because that is my current theory of where the issue might sit.

Heiko
