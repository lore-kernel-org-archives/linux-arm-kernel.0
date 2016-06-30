From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 09:26:52 +0800
Subject: [PATCH 08/21] usb: chipidea: Kick OTG state machine for AVVIS
 with vbus extcon
In-Reply-To: <146724959973.16253.818114721999543873@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-9-stephen.boyd@linaro.org>
 <20160629030913.GC25236@shlinux2>
 <146724959973.16253.818114721999543873@sboyd-linaro>
Message-ID: <20160630012652.GB19928@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 06:19:59PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-28 20:09:13)
> > On Sun, Jun 26, 2016 at 12:28:25AM -0700, Stephen Boyd wrote:
> > > Force the OTG state machine to go forward when we're using an
> > > extcon for vbus detection. In this case, the controller may never
> > > raise an interrupt for AVVIS, so we need to simulate the event by
> > > toggling the appropriate OTG fsm bits and kicking the state
> > > machine again.
> > > 
> > 
> > Well, I think you may misunderstand the OTG FSM and dual-role.
> > From my and Felipe's point, there are seldom users for USB FSM,
> > there are only OTG FSM spec and related OTG certification.
> 
> Probably yes.
> 
> > 
> > The OTG FSM needs related SoC support, the vbus will be off at
> > several states, and the SRP should be supported by SoC.
> > 
> > By default, the dts needs below properties for disabling it if you
> > choose otg fsm support at kernel configuration.
> > 
> > &usbotg1 {
> >         vbus-supply = <&reg_usb_otg1_vbus>;
> >         srp-disable;
> >         hnp-disable;
> >         adp-disable;
> >         status = "okay";
> > };
> > 
> > See Documentation/devicetree/bindings/usb/generic.txt.
> 
> Does this mean we should be setting all those properties if we're using
> an extcon for vbus and id?

It is not related to how we know vbus and id. If your controller is
otg-capable, and you don't want to enable OTG FSM (just want dual-role),
you should set them at dts since the zImage is multi-platforms, the
CONFIG_USB_OTG and CONFIG_USB_OTG_FSM may be chosen.

> I have noticed that vbus is powered off after
> some time when no device is connected and we're in A_HOST state because
> the timeout for a B device connection happens.

I think it is not you want, but it is OTG compliance.

-- 

Best Regards,
Peter Chen
