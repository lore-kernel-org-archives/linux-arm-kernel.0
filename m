From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 30 Jun 2012 09:40:04 +0800
Subject: [PATCH v2 3/4] usb: chipidea: ci13xxx-imx: add "dr_mode"
 property to device tree bindings
In-Reply-To: <4FED755F.6080302@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
 <20120629014352.GA28923@b20223-02.ap.freescale.net>
 <4FED5D77.3050009@pengutronix.de>
 <20120629084509.GB28923@b20223-02.ap.freescale.net>
 <4FED755F.6080302@pengutronix.de>
Message-ID: <20120630014002.GC2489@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 11:29:03AM +0200, Marc Kleine-Budde wrote:
> On 06/29/2012 10:45 AM, Richard Zhao wrote:
> > On Fri, Jun 29, 2012 at 09:47:03AM +0200, Marc Kleine-Budde wrote:
> >>
> >> Cc'ed Devicetree Discussions
> >>
> >> On 06/29/2012 03:43 AM, Richard Zhao wrote:
> >>> On Thu, Jun 28, 2012 at 03:53:48PM +0200, Marc Kleine-Budde wrote:
> >>>> This patch allows the device tree to limit the chipidea to host or
> >>>> peripheral mode only.
> >>>>
> >>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >>>> ---
> >>>>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    3 ++
> >>>>  drivers/usb/chipidea/ci13xxx_imx.c                 |    3 ++
> >>>>  drivers/usb/chipidea/core.c                        |   41 +++++++++++++++++---
> >>>>  include/linux/usb/chipidea.h                       |    9 +++++
> >>>>  4 files changed, 50 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >>>> index 5a0ad66..67f97f56 100644
> >>>> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >>>> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >>>> @@ -4,6 +4,8 @@ Required properties:
> >>>>  - compatible: Should be "fsl,imx27-usb"
> >>>>  - reg: Should contain registers location and length
> >>>>  - interrupts: Should contain controller interrupt
> >>>> +- dr_mode: indicates the working mode for compatible controllers. Can
> >>>> +  be "host", "peripheral", or "otg". Defaults to "otg" if not defined.
> >>
> >>> By default, it should be decided by capability registers. Only bad hw
> >>> design needs such settings. So, why not name it as force-xxx? If it's
> >>> not specific to imx, it doesn't needs to has prefix "fsl,".
> >>
> >> It's not a bad hardware design if you don't route or enable all ports a
> >> soc offers. In modern socs you cannot enable all ports anyway.
> > I'm not sure about your case, but generally, it's not about ports.
> > It's about ID pin. If ID pin is not connect correctly, we may need to
> > force it to host or device working mode. The 'force" here means it
> > won't follow the capability registers and ID pin.
> 
> The device tree is used to describe the hardware. How would you describe
> a system, which has just a USB device connector? And the hardware guys
> used the not needed id-pin for a LED?
I see your case. Ideally, hw should pull-up or pull-down id pin. We may
not take it as a common case. As I mentioned in another mail, we may
interpret property in imx driver.

Thanks
Richard
> 
> >> The property isn't prefixed with "fsl,", it's just "dr_mode".
> >>
> >> Why not "force-xxx"? I had a look at Documentation/devicetree/bindings/usb:
> >>
> >> tegra-usb.txt:
> >>>   - dr_mode : dual role mode. Indicates the working mode for
> >>>    nvidia,tegra20-ehci compatible controllers.  Can be "host", "peripheral",
> >>>    or "otg".  Default to "host" if not defined for backward compatibility.
> >>>       host means this is a host controller
> >>>       peripheral means it is device controller
> >>>       otg means it can operate as either ("on the go")
> >>
> >> fsl-usb.txt:
> >>>  - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
> >>>    controllers.  Can be "host", "peripheral", or "otg".  Default to
> >>>    "host" if not defined for backward compatibility.
> >>>
> >>
> >> So why invent something new, if there seems to be a pattern?
> > I'm not sure they mean the same things, because the default value is
> > different. Event if they're same, why not make them all with sensible
> > name?
> 
> Sensible name sounds good. Devicetree Discussions, we need an official
> name for the property and its values :)
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
