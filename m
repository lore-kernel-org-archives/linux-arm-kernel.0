From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 30 Oct 2015 15:52:17 +0100
Subject: [PATCH 00/19] drm: Add Allwinner A10 display engine support
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151030145217.GA16848@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 03:20:46PM +0100, Maxime Ripard wrote:
> Hi everyone,
> 
> The Allwinner SoCs (except for the very latest ones) all share the
> same set of controllers, loosely coupled together to form the display
> pipeline.
> 
> Depending on the SoC, the number of instances of the controller will
> change (2 instances of each in the A10, only one in the A13, for
> example), and the output availables will change too (HDMI, composite,
> VGA on the A20, none of them on the A13).
> 
> On most featured SoCs, it looks like that:
> 
>  +--------------------------------------------+
>  |                    RAM                     |
>  +--------------------------------------------+
>        |            |      |            |
>        v            |      |            v
>  +----------------+ |      | +----------------+
>  |    Frontend    | |      | |    Frontend    |
>  +----------------+ |      | +----------------+
>          |          |      |         |
>          v          |      |         v
>  +----------------+ |      | +----------------+
>  |    Backend     |<+      +>|    Backend     |
>  +----------------+          +----------------+
>          |                           |
>          v                           v
>  +----------------+          +----------------+---> LVDS
>  |      TCON      |          |      TCON      |---> RGB
>  +----------------+          +----------------+
>        |       +---+       +---+          |
>        |           |       |              |
>        v           v       v              v
>  +------------+  +------------+  +------------+---> VGA
>  | TV Encoder |  |    HDMI    |  | TV Encoder |---> Composite
>  +------------+  +------------+  +------------+
> 
> The current code only assumes that there is a single instance of all
> the controllers. It also supports only the RGB and Composite
> interfaces.
> 
> A few more things are missing though, and will be supported
> eventually:
>   - Overscan support
>   - Asynchronous page flip
>   - Multiple plane support
>   - Composite / VGA Hotplug detection
>   - More outputs
>   - Support for several videos pipelines
> 
> And there's one big gotcha: thhe code to parse the mode from the
> kernel commandline doesn't seem to support named modes. Since we
> expose the various TV standards through named modes, it means that
> there's no way to use a particular standard to display something
> during the kernel boot. The default will always be used, in other
> words, PAL.

Simply not done yet.

> A few more questions that are probably going to be raised during the
> review:
>   - How do you associate private data to a mode, for example to deal
>     with the non-generic, driver-specific settings required to deal
>     with the various TV standards? drm_display_mode seems to have a
>     private field, but it isn't always preserved.

Analog TV in general is a giant mess, and there's not really all that much
of a standardized solution. I also don't have much clue at all about what
needs to be tuned with analog TV. Probably the best would be to look at
existing drivers with TV-out support and what kind of properties they
support. Then standardize them (with relevant helper code in drm core) and
use that. Additional flags on the mode, especially using the private stuff
is kinda the deprecated non-atomic approach. If you need private data
beyond the mode and any additional properties on the crtc (for derived
state) then just subclass drm_crtc_state and put it there.

>   - How do you setup properties in the kernel command line? In order
>     to have a decent display during boot on relevant interfaces, you
>     probably want to setup the overscan beforehand. Overscan seems to
>     be handled through properties, and afaik, there's no way to set
>     that from the cmdline. Should we use a kernel parameter to set the
>     default value instead?

One idea tossed around is to expose them to DT somehow and then just load
a DT-blob to set them all. That would e.g. also allow to specify firmware
blob paths to e.g. load the boot splash image (if uboot or similar haven't
done that yet). I'm personally not sure how much use there is in exposing
a generic drm property cmdline option ...

What's needed for sure is some generic way to do one initial (atomic)
modeset to hammer all these settings into the driver. That would be really
useful to have, since currently that's tied to the fbdev emulation, which
means if you don't have that it will be simply lost.

Cheers, Daniel

> 
> Thanks!
> Maxime
> 
> Maxime Ripard (19):
>   clk: sunxi: Add display clock
>   clk: sunxi: Add PLL3 clock
>   clk: sunxi: Add TCON channel0 clock
>   clk: sunxi: Add TCON channel1 clock
>   clk: sunxi: add DRAM gates
>   clk: sunxi: Add Allwinner R8 AHB gates support
>   drm/panel: simple: Add timings for the Olimex LCD-OLinuXino-4.3TS
>   drm: Add Allwinner A10 Display Engine support
>   drm: sun4i: Add DT bindings documentation
>   drm: sun4i: Add RGB output
>   drm: sun4i: Add composite output
>   drm: sun4i: tv: Add PAL output standard
>   drm: sun4i: tv: Add NTSC output standard
>   ARM: sun5i: dt: Add pll3 and pll7 clocks
>   ARM: sun5i: dt: Add display and TCON clocks
>   ARM: sun5i: dt: Add DRAM gates
>   ARM: sun5i: dt: Add display blocks to the DTSI
>   ARM: sun5i: r8: Add AHB gates to the DTSI
>   ARM: sun5i: chip: Enable the TV Encoder
> 
>  .../devicetree/bindings/drm/sunxi/sun4i-drm.txt    | 122 ++++
>  arch/arm/boot/dts/sun5i-a10s.dtsi                  |   9 +-
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |   3 +-
>  arch/arm/boot/dts/sun5i-r8.dtsi                    |  46 +-
>  arch/arm/boot/dts/sun5i.dtsi                       | 137 +++++
>  drivers/clk/sunxi/Makefile                         |   4 +
>  drivers/clk/sunxi/clk-simple-gates.c               |   4 +
>  drivers/clk/sunxi/clk-sun4i-display.c              | 199 +++++++
>  drivers/clk/sunxi/clk-sun4i-pll3.c                 |  84 +++
>  drivers/clk/sunxi/clk-sun4i-tcon-ch0.c             | 173 ++++++
>  drivers/clk/sunxi/clk-sun4i-tcon-ch1.c             | 167 ++++++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   3 +-
>  drivers/gpu/drm/panel/panel-simple.c               |  26 +
>  drivers/gpu/drm/sun4i/Kconfig                      |  14 +
>  drivers/gpu/drm/sun4i/Makefile                     |  11 +
>  drivers/gpu/drm/sun4i/sun4i_backend.c              | 271 +++++++++
>  drivers/gpu/drm/sun4i/sun4i_backend.h              | 159 ++++++
>  drivers/gpu/drm/sun4i/sun4i_crtc.c                 | 117 ++++
>  drivers/gpu/drm/sun4i/sun4i_crtc.h                 |  31 ++
>  drivers/gpu/drm/sun4i/sun4i_drv.c                  | 296 ++++++++++
>  drivers/gpu/drm/sun4i/sun4i_drv.h                  |  30 +
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  54 ++
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |  19 +
>  drivers/gpu/drm/sun4i/sun4i_layer.c                | 111 ++++
>  drivers/gpu/drm/sun4i/sun4i_layer.h                |  30 +
>  drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 243 ++++++++
>  drivers/gpu/drm/sun4i/sun4i_rgb.h                  |  18 +
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 478 ++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h                 | 182 ++++++
>  drivers/gpu/drm/sun4i/sun4i_tv.c                   | 619 +++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tv.h                   |  18 +
>  32 files changed, 3673 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/drm/sunxi/sun4i-drm.txt
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-display.c
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-pll3.c
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch0.c
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
>  create mode 100644 drivers/gpu/drm/sun4i/Kconfig
>  create mode 100644 drivers/gpu/drm/sun4i/Makefile
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.h
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_tv.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_tv.h
> 
> -- 
> 2.6.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
