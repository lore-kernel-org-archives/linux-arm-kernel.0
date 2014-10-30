From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 14:45:20 +0100
Subject: [PATCH RESEND V4 4/9] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <CAL1qeaF53VUEcn6OruxjufEXnPxyoqp4=sLUuhvJcrpGH=707A@mail.gmail.com>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-5-git-send-email-abrestic@chromium.org>
 <20141029122738.GE28356@ulmo.nvidia.com>
 <CAL1qeaF53VUEcn6OruxjufEXnPxyoqp4=sLUuhvJcrpGH=707A@mail.gmail.com>
Message-ID: <20141030134517.GB19802@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 12:43:36PM -0700, Andrew Bresticker wrote:
> >> diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c b/drivers/pinctrl/pinctrl-tegra-xusb.c
[...]
> >> +
> >> +     for (i = 0; i < TEGRA_XUSB_USB3_PHYS; i++) {
> >> +             if (phy == padctl->phys[TEGRA_XUSB_PADCTL_USB3_P0 + i])
> >> +                     break;
> >
> > You could simply return i here and then BUG_ON unconditionally.
> >
> >> +     }
> >> +     BUG_ON(i == TEGRA_XUSB_USB3_PHYS);
> >> +
> >> +     return i;
> >> +}
> >
> > Actually, thinking about it some more, perhaps making this a WARN_ON()
> > and returning an error so that we can continue and propagate the error
> > would be more useful. BUG_ON() will completely hang the kernel with no
> > way out but rebooting. WARN_ON() will give a hint about something being
> > wrong and returning an error will allow the kernel to continue to run,
> > which might be the only way to diagnose and fix the problem, even if it
> > means that USB 3.0 support will be disabled.
> 
> I felt like BUG_ON is more appropriate here.  Hitting this case means
> there's a bug in the PHY core or a driver has passed a bogus pointer
> and the stack dump produced by the BUG_ON should make it obvious as to
> what the issue is.  I don't feel too strongly about it though.

The problem with BUG_ON() is that you won't be able to go any further.
So if this were to happen on a device with no serial you might not even
get to a point where you actually see an error message. Handling this
more gracefully by propagating the error code and failing .probe() does
not seem overly complicated and the WARN_ON() output will hopefully
still be noticed (it probably will be after the user can't get USB to
work).

Consider for example the case where a user has only one device to test
and report bugs on. If we crash the device using BUG_ON() they may not
be able to report a bug at all (or recover by reverting to some known
good kernel version). A WARN_ON() will hopefully be enough to get
noticed and unless users rely on XUSB for the root filesystem they'd
still be able to open up a web browser and file a bug report with the
oops attached.

> >> +     u32 value, offset;
> >> +
> >> +     padctl->usb3_ports[port].context_saved = true;
> >
> > What's the purpose of saving the context here? This seems to be
> > triggered by a request from XUSB, but it's then restored when the PHY is
> > powered on. How does that even happen? Won't the PHY stay powered all
> > the time? Or shouldn't the context be saved when powering off the PHY?
> 
> Right, context is saved when requested by the XUSB controller and
> restored on power on.  This is used during runtime power-gating or LP0
> where the PHYs are powered off and on and this context is lost.
> Neither of these are currently implemented by the host driver,
> however.
> 
> As far as why the context is saved upon request and not at power off,
> I'm not sure.  I've observed that these messages come in when a USB3.0
> device is enumerated.  Perhaps the XUSB controller is doing some sort
> of tuning.

I see. Perhaps these values are calibrated by the firmware? In that case
I guess it could redo the calibration. I'll see if I can find out why it
is necessary to store this.

> 
> >> @@ -936,6 +2098,18 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
> >>               goto unregister;
> >>       }
> >>
> >> +     INIT_WORK(&padctl->mbox_req_work, tegra_xusb_phy_mbox_work);
> >> +     padctl->mbox_client.dev = &pdev->dev;
> >> +     padctl->mbox_client.tx_block = true;
> >> +     padctl->mbox_client.tx_tout = 0;
> >> +     padctl->mbox_client.rx_callback = tegra_xusb_phy_mbox_rx;
> >> +     padctl->mbox_chan = mbox_request_channel(&padctl->mbox_client, 0);
> >> +     if (IS_ERR(padctl->mbox_chan)) {
> >> +             err = PTR_ERR(padctl->mbox_chan);
> >> +             dev_err(&pdev->dev, "failed to request mailbox: %d\n", err);
> >> +             goto unregister;
> >> +     }
> >
> > I think this should be done before the registering the PHY provider so
> > that we don't expose one (even for only a very short time) before we
> > haven't made sure that it can be used.
> >
> > Also, this effectively makes the mailbox mandatory, which means that the
> > above code is going to break on older DTBs. So I think we have no choice
> > but to make mailbox (and hence XUSB) support optional.
> 
> I understand the need for binding stability, but it's not like these
> bindings have been around for very long (a release or two?) and this
> series has existed for almost the same amount of time.  Are there
> really any DTBs out there that are going to break because of this?

Every DTB created from a kernel version that has the original binding
but not the one modified as part of this series is going to break. Last
time I checked there weren't any exceptions to this rule. Note, though,
that the rule is that existing functionality must not break. That is,
SATA and PCIe should remain functional, so it should be fine if you just
don't register any of the USB PHYs when the request for a mailbox
channel fails. Something along these lines should do it:

	padctl->mbox_chan = mbox_request_channel(...);
	if (!IS_ERR(padctl->mbox_chan)) {
		err = tegra_xusb_padctl_setup_usb(...);
		...
	}

> >> diff --git a/include/soc/tegra/xusb.h b/include/soc/tegra/xusb.h
> >> index cfe211d..149434f 100644
> >> --- a/include/soc/tegra/xusb.h
> >> +++ b/include/soc/tegra/xusb.h
> >> @@ -10,6 +10,13 @@
> >>  #ifndef __SOC_TEGRA_XUSB_H__
> >>  #define __SOC_TEGRA_XUSB_H__
> >>
> >> +#define TEGRA_XUSB_USB3_PHYS 2
> >> +#define TEGRA_XUSB_UTMI_PHYS 3
> >> +#define TEGRA_XUSB_HSIC_PHYS 2
> >> +#define TEGRA_XUSB_NUM_USB_PHYS (TEGRA_XUSB_USB3_PHYS + TEGRA_XUSB_UTMI_PHYS + \
> >> +                              TEGRA_XUSB_HSIC_PHYS)
> >> +#define TEGRA_XUSB_NUM_PHYS (TEGRA_XUSB_NUM_USB_PHYS + 2) /* + SATA & PCIe */
> >
> > These are really XUSB pad controller specific defines, why does anyone
> > else need to know this?
> 
> They're not pad controller specific.  They're also used in the xHCI host driver.

I keep thinking that there should be a way around this. Of course if
both the XHCI and mailbox drivers were merged, then there'd be no need
to expose this publicly at all.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/8ed6cc29/attachment.sig>
