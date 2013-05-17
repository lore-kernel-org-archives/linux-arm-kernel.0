From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 13:01:15 +0100
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517133345.7c1368f5@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
Message-ID: <20130517120115.GF18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 01:33:45PM +0200, Jean-Francois Moine wrote:
> Hi Russell,
> 
> I quickly compared your dove drm driver and ours (Sebastian and me):

I already said - I don't support DT.  I don't run any DT based ARM
devices, so I have no experience with DT.  What I care more about
is a working cubox platform, which afaik DT still can't offer yet.

> - CMA helper
> 
>   You don't use DRM_KMS_CMA_HELPER and DRM_GEM_CMA_HELPER which would
>   simplify some code.

Possibly, but the biggest win for me is having cacheable gem objects.
CMA will be a retrograde step for those.

> - device tree
> 
>   Our driver depends on the DT and, by this way, it may be used for
>   various boards (Cubox, DB-MV88AP510 Development Board, CompuLab
>   CM-A510 Board..). Especially, in the Cubox, only a HDMI screen may be
>   connected, while the display controller permits connection of a smart
>   panel (port A) and a VGA screen (port B). 

I only have a Cubox, so I can't test anything but HDMI.

Given that there's big questions about the polarity of signals coming
out of the Armada 510 (with the invert bits 0, are the syncs positive
or negative?) I wouldn't like to lead anyone up the path of thinking
that this driver supports anything but the tested HDMI scenario yet.

As that information is not in any of the Armada 510 TRMs, and can only
be discovered by physically probing the signals with a scope... that's
on my todo list when I feel like dismantling the Cubox and getting the
soldering iron out to separate the two boards so I can get access to
the signals.

I've already tried to explain this to Sebastian on IRC, and kept getting
nonsense back from him.  "You need to program the whole chain".  Yes,
but that makes no sense to the question I was asking.

The reason is this:
+-----------------------------+      +------------------------+
| Armada510                   |      |   TDA19988             |
| LCD controller ---> switch ---------> switch --> processing |
|   VSYNC/HSYNC               |      |                        |
+-----------------------------+      +------------------------+

The issue is that each 'switch' point is capable of inverting the sync
signal.  If you program both identically then you end up with inversion
following another inversion.  Which means no inversion.  That's why
I've found Sebastian's answers to be much less than helpful on this
point.

What I have found with the NXP TDA19988 driver is that you need to get
the input syncs to the TDA19988 set to the correct polarity for the
TDA19988, which _isn't_ what is advertised in the EDID.  The TDA19988
then has its own processing internally which places the appropriate
sync codes onto the output data stream.

In some cases, getting this wrong shifts the displayed image by a few
pixels/lines.  In other cases you get no output or invalid output which
isn't recognised by the connected device.

>   Also, the driver could be used for different chips as the Armada 160
>   which has quite the same LCD controller (but one LCD only and no
>   display controller - Sebastian's idea).

That's no problem - you just provide my driver with only one IO space
for the LCD controller, and it will only use one.  If you have more
than two, it will cope as well.

> - module loading (si5351, tda998x)
> 
>   As our driver is loaded by the Cubox DT, and as the auxilliary drivers
>   (external clock, HDMI transmitter) may also be modules, a
>   synchronization mechanism (inspired by the tegra drm driver) permits
>   the driver to start when all the other drivers are also started.

The lack of Si5351 already gets tested on every cubox boot I do.  That
causes probe deferal, which allows the driver to properly start when
it becomes ready.

Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 7) is a 16550A
console [ttyS0] enabled
serial8250.1: ttyS1 at MMIO 0xf1012100 (irq = 8) is a 16550A
[drm] Initialized drm 1.1.0 20060810
[drm:dove_drm_load] *ERROR* failed to get clock
platform dove-drm: Driver dove-drm requests probe deferral
...
si5351 0-0060: registered si5351 i2c client
si5351 0-0060: external clock setup : clkdev = d827f820
cubox_extclk_setup : add alias 'extclk/dovefb.0' to clkout0 w 0
external clock setup done
...
dove-drm dove-drm: found TDA19988
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
dove-drm dove-drm: failed to read EDID
Console: switching to colour frame buffer device 160x45
dove-drm dove-drm: fb0: dove-drmfb frame buffer device
dove-drm dove-drm: registered panic notifier
[drm] Initialized dove-drm 1.0.0 20120730 on minor 0

TDA998x is a different matter - I do need to propagate that error code,
and then make a decision in the tda19988 connector whether to return
-EPROBEDEFER.

(The failure to read EDID is caused by my HDMI switch, which at boot
doesn't have the cubox selected, and so doesn't provide EDID until
the cubox is selected.)

> - display controller
> 
>   I implemented output port cloning (LCD 0 to port B) but it is not
>   tested (I just have a Cubox and I think that Sebastian did not have
>   time enough yet to do it).

I didn't bother with this because - again - no access to port B on my
hardware.

> - LCD handling
> 
>   With our driver, the description of a smart panel (port A) may be
>   done by the DT.

That's simple enough to add - just another 'connector' even though it's
the same physical connection out of the Armada 510.

> - hardware cursor
> 
>   Our driver always proposes the HWC 32 (RGBA 64x64).

Hardware cursor support is pretty useless.

In RGBA mode, it's not 64x64 but you get the choice of either 64x32 or
32x64.  This is useless for Xorg's purposes, where it really wants a
64x64 cursor.  And the XF86 Xorg backend really wants RGBA for hardware
cursor, not 2bpp.  So my conclusion is that hardware cursor is not worth
any effort and I've a good mind to strip that out from my driver (which
will simplify a few places.)

I've played with the idea of reducing a RGBA cursor down to 2bpp mode
where we can fit the required size in, but that doesn't work very well.

Just because the hardware does something doesn't mean you should write
code for it! :)

> - LCD clocks
> 
>   Each LCD may use one clock amongst 4 (AXI, LCD PLL and 2 external
>   clocks). In our driver, the choice of the clock is done on each video
>   mode change (Sebastian's idea).

Yes, this could be added to mine, probably fairly simply too, but for
the purposes of the cubox...

> - interlaced modes
> 
>   While the code is there, I did not test the interlaced modes.
>   Your code may be better.

I know mine works... I've run it at 1080i with the NXP TDA19988 driver.

> - video overlay
> 
>   Same as above: the code is in our driver (overlay plane), but it is
>   not tested.

We as a family, have watched many hours of video on mine. :)

> - private ioctls
> 
>   It should be easy to add them in our driver and have an API
>   compatible with your X server module. 
> 
> - screen rotation (IRE)
> 
>   This feature is needed when the Dove SoC is used in a tablet and does
>   not exist in both drivers.
> 
> - VGA DAC
> 
>   This feature is needed to get the VGA screen parameters (mode,
>   dimensions) and does not exist in both drivers too.
> 
> Otherwise, there are some small differences in, for example,
> programming the LCD modes, or treating the vblank events.
> 
> What do you think about merging?

Yes, I think merging the two together would probably be sane. :)
