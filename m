From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 29 Jan 2018 03:30:41 +0000
Subject: [RFC/RFT usb-next v1 5/6] usb: chipidea: do not set the "phy"
 field in struct usb_hcd
In-Reply-To: <CAFBinCCzghJxHe-1Jzwa1ohHYYytn53QAsXYue229dVu7tB7UQ@mail.gmail.com>
References: <20180125001639.14681-1-martin.blumenstingl@googlemail.com>
 <20180125001639.14681-6-martin.blumenstingl@googlemail.com>
 <HE1PR04MB145071FCFAF041E0A9252FF08BE00@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <CAFBinCCzghJxHe-1Jzwa1ohHYYytn53QAsXYue229dVu7tB7UQ@mail.gmail.com>
Message-ID: <HE1PR04MB14504462F7C7A247E1CF9F308BE50@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> >>
> >> Now that usb_add_hcd parses all generic PHYs anyways the code which
> >> skips initialization of a single PHY will go away.
> >> Remove the code which sets struct usb_hcd's phy field from the
> >> chipidea driver as this field will go away soon.
> >>
> >> Signed-off-by: Martin Blumenstingl
> >> <martin.blumenstingl@googlemail.com>
> >> ---
> >>  drivers/usb/chipidea/host.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/usb/chipidea/host.c
> >> b/drivers/usb/chipidea/host.c index 19d60ed7e41f..fc324767cb0f 100644
> >> --- a/drivers/usb/chipidea/host.c
> >> +++ b/drivers/usb/chipidea/host.c
> >> @@ -124,9 +124,7 @@ static int host_start(struct ci_hdrc *ci)
> >>
> >>       hcd->power_budget = ci->platdata->power_budget;
> >>       hcd->tpl_support = ci->platdata->tpl_support;
> >> -     if (ci->phy)
> >> -             hcd->phy = ci->phy;
> >> -     else
> >> +     if (!ci->phy)
> >>               hcd->usb_phy = ci->usb_phy;
> >>
> >
> > The reason hcd->phy is initialized by chipidea core is we do not need
> > HCD core to touch PHY, and PHY operation is shared for both device and host
> mode for chipidea.
> Chunfeng wanted me to drop the mtu3 patch because I forgot about device mode in
> the mtu3 driver.
> however, the chipidea driver seems to be different because I'm not dropping the
> whole phy_{init,power_on,power_off,exit} code from it, but only a "flag" that tells the
> HCD core to skip managing the USB PHY
> 
> > If I understand correct, your HCD core PHY wrapper patch set will do
> > PHY operation if there is a "phy" node under controller's? If it is
> > correct, you may supply one way to let the HCD core bypass phy operations for
> some USB controllers, eg dual-role controllers.
> > Thanks.
> could you please explain why the HCD core should not manage the the PHYs when
> the chipidea driver is used?
> 
> my understanding is that all phy_{init,power_on,power_off,exit}
> operations are ref-counted internally in the PHY framework this means that if the
> chipidea driver calls phy_{init,power_on} first then the same functions called from
> within the HCD core are no-ops (except for the ref-counting) so I think it should not
> change anything - however, I have no hardware to actually prove that.

Martin, you design has no problem for most of cases, but some hardware needs special
sequence for phy control. I will give an example below.

> it would be great if you could explain the issue behind this (and thereby answer the
> question: why we would not want the HCD core to manage the PHY states)!
> 
> 
Eg, taking Qualcomm USB2 controller as an example, it even does not allow chipidea core
to manage its power operation, see CI_HDRC_OVERRIDE_PHY_CONTROL at chipidea driver
(usb/chipidea/core.c). Its phy_power_on is called after ehci controller reset has finished. 
(usb/chipidea/ci_hdrc_msm.c).

Peter
