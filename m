From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Sep 2014 23:53:28 -0500
Subject: [PATCH v6 4/4] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <CAFp+6iHRJ5oAA+K1Y0Y2uadPhsR6wmrd13DM39dqiL4jj+swHg@mail.gmail.com>
References: <CAFp+6iEyqmbwMLFrBKD7NVLDAC=b+h1hPKFS=BG4k9D69hn_dg@mail.gmail.com>
 <20140903144225.GD31855@saruman.home>
 <CAFp+6iETPJCWMMkjHrpDcdCv=K0PbefYLa4eBOwN=aUY2=EHLA@mail.gmail.com>
 <20140905175651.GK24449@saruman.home>
 <CAFp+6iGU86yL8Ry3ArJJjBy2Cs0Em2B49yssH3BK5fJwyaZbtA@mail.gmail.com>
 <20140908134454.GK22409@saruman.home>
 <CAFp+6iG+gmD_JseytYuVQcRK9ErOqQrUEWJoU1KUU7PqMd=aRw@mail.gmail.com>
 <20140909144225.GF6151@saruman.home>
 <CAFp+6iHJKmeothDM67WW60Sqqj8BQroBCzZ8zecKwM_GcYL8HA@mail.gmail.com>
 <CAFp+6iHRJ5oAA+K1Y0Y2uadPhsR6wmrd13DM39dqiL4jj+swHg@mail.gmail.com>
Message-ID: <20140910045328.GA32475@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 09:09:57AM +0530, Vivek Gautam wrote:
> On Wed, Sep 10, 2014 at 9:07 AM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> > adding Julius here,
> 
> i think i had missed adding Julius for this entire series :-(
> I should be more careful with the CC list in future.
> Added his chromium id, since that seems to be more active.
> 
> >
> >
> > On Tue, Sep 9, 2014 at 8:12 PM, Felipe Balbi <balbi@ti.com> wrote:
> >> On Tue, Sep 09, 2014 at 07:19:50AM +0530, Vivek Gautam wrote:
> >>> Hi,
> >>>
> >>>
> >>> On Mon, Sep 8, 2014 at 7:14 PM, Felipe Balbi <balbi@ti.com> wrote:
> >>> > Hi,
> >>> >
> >>> > On Mon, Sep 08, 2014 at 09:53:09AM +0530, Vivek Gautam wrote:
> >>> >> On Fri, Sep 5, 2014 at 11:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> >>> >> > On Thu, Sep 04, 2014 at 12:01:19PM +0530, Vivek Gautam wrote:
> >>> >> >> > Don't we have phy_power_on()
> >>> >> >> > for that ? It looks like you could just as well do this from
> >>> >> >> > phy_power_on() ?
> >>> >> >>
> >>> >> >> No, unfortunately keeping these calibration settings in phy_power_on()
> >>> >> >> doesn't help, since we need to do this after XHCI reset has happened.
> >>> >> >
> >>> >> > teach xHCI about PHYs ?
> >>> >>
> >>> >> sorry i couldn't understand you here.
> >>> >> Aren't we trying to do the same with Heikki's patch about dwc3 :
> >>> >> [PATCH 6/6] usb: dwc3: host: convey the PHYs to xhci
> >>> >>
> >>> >> and the 2nd patch in this series :
> >>> >> [PATCH v6 2/4] usb: host: xhci-plat: Get PHYs for xhci's hcds
> >>> >>
> >>> >> Is there something else that is expected ?
> >>> >
> >>> > right, use that to call phy_init() at the right time, then you need to
> >>> > add a new ->calibrate() method which, likely, will only be used by you
> >>> > ;-)
> >>>
> >>> so you mean, the xhci should itself call phy_init() at a time suitable,
> >>> so that ->calibrate() is not required at all ?
> >>>
> >>> i think you meant there - "then you __do not__ need to
> >>
> >> right :-)
> >
> > alright, i will prepare a patch for the suggested change.
> >
> > But AFAI remember we had discussion for this patch in earlier
> > version, and Julius suggested to use a generic approach for such
> > change wherein other users in future may be able to use the
> > facility.

right, and what's more generic than adding the support for PHYs straight
into xHCI ?

What I fear is that we end up opening the doors for every odd
platform-specific operation to be added to the framework without really
considering what needs to be done. That would defeat the idea of having
a generic framework altogether.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/9d71f7f9/attachment-0001.sig>
