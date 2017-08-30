From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 30 Aug 2017 13:45:57 -0700
Subject: [PATCH v2 3/3] arm64: dts: qcom: Collapse usb support into one
 node
In-Reply-To: <20170817064347.GA7608@dragon>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-4-stephen.boyd@linaro.org>
 <20170817064347.GA7608@dragon>
Message-ID: <150412595705.25571.14450869244494720536@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2017-08-16 23:43:49)
> Hi Stephen,
> 
> On Fri, Jul 14, 2017 at 02:40:05PM -0700, Stephen Boyd wrote:
> > We currently have three device nodes for the same USB hardware
> > block, as evident by the reuse of the same reg address multiple
> > times. Now that the chipidea driver fully supports OTG with the
> > MSM wrapper we can collapse all these nodes into one USB device
> > node, reflecting the true nature of the hardware.
> > 
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 38 ++++++++++---------
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi     | 62 +++++++++++++++----------------
> >  2 files changed, 50 insertions(+), 50 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index f326f4fb4d72..494560a1a6ef 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -213,24 +213,20 @@
> >               };
> >  
> >               usb at 78d9000 {
> > -                     extcon = <&usb_id>, <&usb_id>;
> > +                     extcon = <&usb_id>;
> 
> I'm trying to play the series on db410c, and it doesn't seem to work as
> expected.  Here is basically what I did:
> 
> - Revert ed75d6a96905, and apply the series.
> - Turn on the following options:
>         CONFIG_USB_CHIPIDEA_ULPI
>         CONFIG_USB_ULPI_BUS
>         CONFIG_PHY_QCOM_USB_HS
>         CONFIG_MUX_GPIO
> 
> The role switching doesn't happen when I connect/disconnect cable
> to/from micro-usb port.

Good. That's expected.

> But if I revert above extcon change (keep two
> usb_id phandle for extcon), the role switching happens.  However, host
> driver still fails to enumerate the usb mouse attached to Type-A port.
> 
> [   15.400074] ci_hdrc ci_hdrc.0: EHCI Host Controller
> [   15.400119] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
> [   15.419847] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> [   15.420700] hub 1-0:1.0: USB hub found
> [   15.425820] hub 1-0:1.0: 1 port detected
> [   15.759862] usb 1-1: new high-speed USB device number 2 using ci_hdrc
> [   31.943942] usb 1-1: device not accepting address 2, error -110
> [   32.063938] usb 1-1: new high-speed USB device number 3 using ci_hdrc
> [   48.071943] usb 1-1: device not accepting address 3, error -110
> [   48.191935] usb 1-1: new high-speed USB device number 4 using ci_hdrc
> [   58.823934] usb 1-1: device not accepting address 4, error -110
> [   58.943936] usb 1-1: new high-speed USB device number 5 using ci_hdrc
> [   69.575935] usb 1-1: device not accepting address 5, error -110
> [   69.576001] usb usb1-port1: unable to enumerate USB device
> 
> I must have missed something.  Can you please advice?  Thanks.

Yes. The role switch happens now by userspace writing different values
to the chipidea node sysfs file. For db410c it's located at
/sys/bus/platform/devices/ci_hdrc.0/role and by echoing 'host' or
'gadget' into that file you can change the role. Unplugging the cable
won't do anything anymore, because the micro-usb port is only indicating
vbus presence, and not the ID pin. At least that is my reading of the
schematic.

Obviously, this changes behavior from previous designs where
disconnecting the cable changed the role, but I don't know if we want to
support this method via the kernel alone. Instead, it seems simpler to
have userspace decide to change the role whenever it wants with some
policy. Do you have any suggestion on how this can be integrated into
userspace so we write this file at boot? That way, we can switch to host
mode by default on db410c and then users can decide to make a gadget if
they want to lose the host ports while the gadget is active. We could
probably have an extcon event handler in userspace as well to change the
role when the micro-usb cable is disconnected. That way, old behavior
could be maintained but it would be a pure policy decision in userspace.
