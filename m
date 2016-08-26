From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 26 Aug 2016 16:54:57 +0000
Subject: [PATCH 0/3] drm/tilcdc: Some fixes for LCDC rev1
In-Reply-To: <e659bff8-7c8e-35ed-e834-1e00d5c32931@ti.com>
References: <20160823125701.25700-1-kbeldan@baylibre.com>
 <e659bff8-7c8e-35ed-e834-1e00d5c32931@ti.com>
Message-ID: <20160826165457.GA20752@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 23, 2016 at 07:24:42PM +0300, Jyri Sarha wrote:
> Thanks a lot!
> This is very helpful as I do not have LCDC rev1 HW my self, but only
> am335x based boards.
> 
> On 08/23/16 15:56, Karl Beldan wrote:
> > Hi,
> > 
> > I found some missing bits for rev1 of the LCDC and here are some of the
> > changes I am using to use the DRM driver on an LCDCK (which has a rev1).
> > 1/3 seems required by rev1 of the IP and without it my the LCDC on my
> > LCDK keeps can't sync, 2/3 is required by the driver logic, while 3/3
> > is less of a requirement.
> 
> I'll drop 3/3, because my recent patches should take care of that:
> http://www.spinics.net/lists/devicetree/msg138885.html
> 

They do indeed.

> However, there will be v2 round of those patches. Only the DT binding
> and its default value should change.
> 
> > Although 1,2/3 would have fitted drm-fixes I based them on drm-next as
> > 2/3 would conflict with the recent changes in drm-next.
> > 
> 
> I'll pick these two up for my next pull request. Thanks!
> 
> > Another thing which is also an absolute requirement for the rev1 but 
> > with which rev2 seems to cope fine is the palette loading (even if the DRM
> > uses >= 16bpp formats), dixit the TRM:
> > "12-, 16-, and 24-BPP modes do not need a palette; i.e., the pixel data is
> > the desired RGB value. However, the first 32 bytes are still considered a
> > palette. The first entry should be 4000h (bit 14 is 1) while the remaining
> > entries must be filled with 0.".
> > ATM I am using a local crude way of loading the palette to verify the
> > missing bits to get the DRM driver properly working on the LCDK (as I
> > haven't seen how things work in the DRM subsystem I can't post any proper
> > change for that).
> > 
> 
> I see. Reading from the TRM, that should be done for rev2 too. I'll try
> to come up with a patch for that at some point, unless you send me one
> first.
> 

That would be nice. I didn't look at how to integrate my local changes
but instead I tried to see what prevented modetest to work, (with the
posted changes and the palette loading the framebuffer was operational
but not modetest). It appears that when modetesting the LCDC loses its
sync, and I guess that's because the framebuffer addresses are changed
while the raster is still on, which seems inappropriate. Since the v2s
seem to cope with framebuffer ceiling boundaries that are off, my first
guess would be they don't use it and directly use the raster timings
and the bpp format for the boundary and sees the framebuffer addresses
changes (base + ceiling) as atomic. My local changes try to cope with
that by handling the sync loss irq and it gives me a working modetest,
however it is not enough to get modetest -v (ie. with vsynced page
flipping) working.
My impression would be that to work with v1, the following would be in
order (in addition to the palette):
- make changes to the controller with the raster disabled
- handle FRAME_DONE and SYNC_LOST with v1 as well (the driver assumes it
  is only valid for v2, which is false)

> > The posted changes and the above mentioned palette loading missing bit 
> > are specific to the DRM driver.
> > 
> > However there are other shortcomings to the proper functioning of the 
> > LCDC on some platforms (I am currently focusing on the LCDK but I guess 
> > it should be true for all da850 based systems), which are not inherent to
> > the DRM driver driver but which strongly relate to it:
> > 
> > - The pixel clock rate setting (eg. currently the davinci clk can't cope
> > properly with the DRM driver way of setting the clock and doesn't use
> > the common clock framework)
> > - The memory bandwidth/latency requirements for the LCDC are not met 
> > with the default priority settings (apparently there is a fix in
> > da850_lcd_hw_init of: http://arago-project.org/git/projects/linux-davinci.git?p=projects/linux-davinci.git;a=blob;f=arch/arm/mach-davinci/board-omapl138-lcdk.c;h=689b4f304011e09e262782cf8c4b96eba00ac28b;hb=HEAD).
> > Of course this one affects both the DRM and framebuffer systems.
> > 
> 
> There is also memory bandwidth issues on am335x and we are still looking
> for a proper system level fix.
> 
> > Hence to test the LCDK my crude local changes include (ie. on top of the
> > posted changes and some dts or sync_lost recovery bits):
> > - palette loading
> > - tweak of the pixel clock to cope with davinci clk
> 
> If you have proper a fixes for these, please send a patch. The palette
> loading is something I can probably do myself too, but the clock thing
> is something that I at least can not test.
> 

Why not behave as da8xx-fb ? It doesn't touch the fck clock rate but
only adjusts the clkdiv of the LCDC for pixel clock, plus it seems to
fit well with cpufreq.

> > - adjustment of the memory master priorities
> > 
> 
> That would be a system level fix and I can not say whether or not to
> take such a fix.
> 
> > 
> > BTW, with the recent changes of tilcdc from drm-next, I see this warning
> > when loading the module:
> > "drm:drm_helper_disable_unused_functions [drm_kms_helper]] *ERROR* Called for atomic driver, this is not what you want."
> > 
> 
> That is also fixed in my latest patch series above.
> 

Ok, I checked that out, I am currently using your latest series, thanks.

Best regards, 
Karl




> Best regards,
> Jyri
> 
> > 
> > Regards, 
> > Karl
> > 
> > 
> > Karl Beldan (3):
> >   drm/tilcdc: Adjust the FB_CEILING address
> >   drm/tilcdc: Enable EOF interrupts for v1 LCDC
> >   drm/tilcdc: Advertise the DRM_FORMATs according to the IP revision
> > 
> >  drivers/gpu/drm/tilcdc/tilcdc_crtc.c  | 4 +++-
> >  drivers/gpu/drm/tilcdc/tilcdc_plane.c | 7 ++++++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> 
