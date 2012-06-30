From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 30 Jun 2012 09:19:08 +0800
Subject: [PATCH v2 3/4] usb: chipidea: ci13xxx-imx: add "dr_mode"
 property to device tree bindings
In-Reply-To: <4FEDCF15.9040000@wwwdotorg.org>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
 <20120629014352.GA28923@b20223-02.ap.freescale.net>
 <4FED5D77.3050009@pengutronix.de>
 <20120629084509.GB28923@b20223-02.ap.freescale.net>
 <4FEDCF15.9040000@wwwdotorg.org>
Message-ID: <20120630011906.GA2489@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 09:51:49AM -0600, Stephen Warren wrote:
> On 06/29/2012 02:45 AM, Richard Zhao wrote:
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
> >
> > I'm not sure about your case, but generally, it's not about ports.
> > It's about ID pin. If ID pin is not connect correctly, we may need to
> > force it to host or device working mode. The 'force" here means it
> > won't follow the capability registers and ID pin.
> >>
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
> >
> > I'm not sure they mean the same things, because the default value is
> > different. Event if they're same, why not make them all with sensible
> > name?
> 
> I'm not quite sure what the question is I'm being asked here.
> 
> I certainly think that new bindings should follow existing precedent
> where possible for representing the same data. dr_mode is that precedent
> for a USB host's operating mode. Tegra chose to use that because of
> precedent in fsl-usb.txt IIRC.
For imx, in most cases, we don't use dr_mode. The role is decided by
CAP_DCCPARAMS and ID pin. For tegra and fsl-usb, it looks like the role
is totally decided by dt property. So I suggested use force-xxx to let
everyone know it does not follow the default action. I don't quite
insist on the naming, because dr_mode is similar (not same).

Thanks
Richard

> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
