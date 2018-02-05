From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 5 Feb 2018 07:25:04 +0000
Subject: [RFC/RFT usb-next v1 5/6] usb: chipidea: do not set the "phy"
 field in struct usb_hcd
In-Reply-To: <CAFBinCC_GN7UKQZseLdyVcOsfCMfsvcdC92tRx=jBe68HO+B+w@mail.gmail.com>
References: <20180125001639.14681-1-martin.blumenstingl@googlemail.com>
 <20180125001639.14681-6-martin.blumenstingl@googlemail.com>
 <HE1PR04MB145071FCFAF041E0A9252FF08BE00@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <CAFBinCCzghJxHe-1Jzwa1ohHYYytn53QAsXYue229dVu7tB7UQ@mail.gmail.com>
 <HE1PR04MB14504462F7C7A247E1CF9F308BE50@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <CAFBinCC_GN7UKQZseLdyVcOsfCMfsvcdC92tRx=jBe68HO+B+w@mail.gmail.com>
Message-ID: <HE1PR04MB14507B90AB9331F1D682CBD48BFE0@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > Martin, you design has no problem for most of cases, but some hardware
> > needs special sequence for phy control. I will give an example below.
> great to hear that this should work for most devices!
> 
> >> it would be great if you could explain the issue behind this (and
> >> thereby answer the
> >> question: why we would not want the HCD core to manage the PHY states)!
> >>
> >>
> > Eg, taking Qualcomm USB2 controller as an example, it even does not
> > allow chipidea core to manage its power operation, see
> > CI_HDRC_OVERRIDE_PHY_CONTROL at chipidea driver (usb/chipidea/core.c).
> Its phy_power_on is called after ehci controller reset has finished.
> > (usb/chipidea/ci_hdrc_msm.c).
> I see, thank you for explaining this!
> 
> what do you think about replacing the two following fields from struct usb_hcd:
>   struct usb_phy *usb_phy;
>   struct phy *phy;
> with:
>   /*
>    * do not manage the PHY state in the HCD core, instead let the driver handle
>    * this (for example if the PHY can only be turned on after a specific event)
>    */
>   bool skip_phy_initialization;
> 
> maybe I should also do this together with my other series which adds the PHY
> wrapper to the HCD core (or even as a separate series, which would be merged
> before this and the PHY wrapper series). what do you think?
> 
> 
 
Hi Martin,

I think it is better to do this in one series.

Peter
