From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 19 Aug 2014 08:14:23 +0800
Subject: [PATCH RESEND v2 0/7] vf610: Add USB support
In-Reply-To: <cover.1408391385.git.stefan@agner.ch>
References: <cover.1408391385.git.stefan@agner.ch>
Message-ID: <20140819001422.GB2928@peterchendt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:07:10PM +0200, Stefan Agner wrote:
> This patchset adds USB support for Vybrid VF610 SoC. It extends the
> clock framework to support the USB PHY cocks, extends the device
> tree files and adds support for the non-core registers in the
> usbmisc_imx driver.
> 
> This patchset needs the eSDHC registers length fix available in
> Shawn's for-next branch, since that overlapped by chance the USB
> areas.
> 
> The whole patchset proved to be working on a Colibri VF61 and
> Freescale Tower VF65GS10. The first USB controller runs in
> peripheral mode. I could successfully use RNDIS, however with some
> stability issues: Suddenly the other side was not reachable anymore
> and the interface needed to brought down and back up again. I'm
> still investigating this.
> 
> The second USB controller, running in USB host mode, showed errors
> when connecting devices behind a USB hub:
> 
> [  215.163507] usb usb1-port1: cannot reset (err = -32)
> [  215.170498] usb usb1-port1: cannot reset (err = -32)
> [  215.185120] usb usb1-port1: cannot reset (err = -32)
> [  215.191345] usb usb1-port1: cannot reset (err = -32)
> [  215.202487] usb usb1-port1: cannot reset (err = -32)
> [  215.207718] usb usb1-port1: Cannot enable. Maybe the USB cable is bad?
> [  215.219317] usb usb1-port1: unable to enumerate USB device
> 
> By extending the PHY driver with the MXS_PHY_NEED_IP_FIX flag, this
> issue is resolved.
> 
> Resend, also added Felipe Balbi this time, sorry about that. I think
> I only miss the Ack/Review from you here and then things should be
> fine.
> 
> Changes in v2:
> - Extended usbmisc_imx to support multiple instances
> - Update DT documentation and compatible strings where necessary
> - Add USB PHY flag MXS_PHY_NEED_IP_FIX
> - Added patches to enable USB on Tower
> 
> Stefan Agner (7):
>   ARM: dts: vf610: Add USB PHY and controller
>   ARM: imx: clk-vf610: Add USBPHY clocks
>   usb: phy: mxs: Add VF610 USB PHY support
>   ARM: dts: vf610: Add usbmisc for non-core registers
>   chipidea: usbmisc_imx: Add USB support for VF610 SoCs

This driver change is already at my tree, but it is too late
for 3.17-rc1 when you sent, so I sent it to greg for v3.18.

Peter

>   ARM: dts: vf610-colibri: Add USB support
>   ARM: dts: vf610-twr: Add USB support
> 
>  Documentation/devicetree/bindings/usb/mxs-phy.txt  |  1 +
>  .../devicetree/bindings/usb/usbmisc-imx.txt        |  1 +
>  arch/arm/boot/dts/vf610-colibri.dts                | 10 ++++
>  arch/arm/boot/dts/vf610-twr.dts                    | 10 ++++
>  arch/arm/boot/dts/vf610.dtsi                       | 60 ++++++++++++++++++++--
>  arch/arm/mach-imx/clk-vf610.c                      | 12 ++++-
>  drivers/usb/chipidea/ci_hdrc_imx.c                 |  8 +++
>  drivers/usb/chipidea/ci_hdrc_imx.h                 |  1 +
>  drivers/usb/chipidea/usbmisc_imx.c                 | 52 +++++++++++++++----
>  drivers/usb/phy/phy-mxs-usb.c                      |  6 +++
>  include/dt-bindings/clock/vf610-clock.h            |  5 +-
>  11 files changed, 149 insertions(+), 17 deletions(-)
> 
> -- 
> 2.0.4
> 

-- 
Best Regards,
Peter Chen
