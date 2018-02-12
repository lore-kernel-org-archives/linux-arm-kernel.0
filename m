From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 12 Feb 2018 14:42:29 -0500 (EST)
Subject: [PATCH usb-next v9 2/8] usb: add a flag to skip PHY initialization
 to struct usb_hcd
In-Reply-To: <CAFBinCBnea-Nt73Lz6K+hKub++Upxa6ot8o857rG3GeuLugZYw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1802121441030.1411-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Feb 2018, Martin Blumenstingl wrote:

> Hi Alan,
> 
> On Mon, Feb 12, 2018 at 4:15 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sun, 11 Feb 2018, Martin Blumenstingl wrote:
> >
> >> The USB HCD core driver parses the device-tree node for "phys" and
> >> "usb-phys" properties. It also manages the power state of these PHYs
> >> automatically.
> >> However, drivers may opt-out of this behavior by setting "phy" or
> >> "usb_phy" in struct usb_hcd to a non-null value. An example where this
> >> is required is the "Qualcomm USB2 controller", implemented by the
> >> chipidea driver. The hardware requires that the PHY is only powered on
> >> after the "reset completed" event from the controller is received.
> >>
> >> A follow-up patch will allow the USB HCD core driver to manage more than
> >> one PHY. Add a new "bool skip_phy_initialization" field to struct
> >> usb_hcd so drivers can opt-out of any PHY management provided by the USB
> >> HCD core driver. The new field will be used in that patch as well.
> >>
> >> This also updates the existing drivers so they use the new flag if they
> >> want to opt out of the PHY management provided by the USB HCD core
> >> driver. This means that for these drivers the new "multiple PHY"
> >> handling (which will be added in a follow-up patch) will be disabled as
> >> well.
> >>
> >> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >> ---
> >
> >> --- a/include/linux/usb/hcd.h
> >> +++ b/include/linux/usb/hcd.h
> >> @@ -98,6 +98,12 @@ struct usb_hcd {
> >>        */
> >>       const struct hc_driver  *driver;        /* hw-specific hooks */
> >>
> >> +     /*
> >> +      * do not manage the PHY state in the HCD core, instead let the driver
> >> +      * handle this (for example if the PHY can only be turned on after a
> >> +      * specific event)
> >> +      */
> >> +     bool skip_phy_initialization;
> >
> > Instead of declaring this as a bool at some random location in the
> > structure, it would be better to make this a bitflag along with the
> > other ones that get set at registration.  For example, it could come
> > right after the remove_phy flag.
> I'll move it to the other bitflags as suggested - thanks for pointing this out!
> 
> just to save you from reviewing this over and over again:
> - I'll move the skip_phy_initialization field below remove_phy
> - it's new definition will be "unsigned skip_phy_initialization:1"
> - do you see any issues with the rest of the patch (the "concept" of
> using a flag to skip all kinds of PHY initialization)?

It's okay as far as I can tell.  But I haven't done any PHY
programming, so I'm not a good judge.

Alan Stern
