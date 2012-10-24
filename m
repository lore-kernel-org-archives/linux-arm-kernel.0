From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Oct 2012 10:57:00 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <5086F8D6.5050605@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1210241013310.1481-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2012, Rob Herring wrote:

> On 10/23/2012 02:33 PM, Alan Stern wrote:
> > On Tue, 23 Oct 2012, Stephen Warren wrote:
> > 
> >>> Nothing intrinsically distinguishes this class of hardware.  The only
> >>> thing these devices have in common is that they can be managed by
> >>> Linux's ehci-platform driver.
> >>
> >> I don't agree. They're all EHCI USB controllers (or all EHCI USB
> >> controllers that don't require custom drivers due to quirks), which is a
> >> much more general statement than anything related to which driver Linux
> >> uses for them.
> > 
> > That's true, but it doesn't distinguish these devices.  There are other
> > EHCI controllers with no quirks that nevertheless can't be handled by
> > ehci-platform because they have requirements (_not_ quirks) that
> > ehci-platform is unable to deal with currently -- clocks or power
> > supplies or special register settings or PHYs or etc.
> 
> But what if the h/w has quirks you haven't yet discovered? You need the
> compatible property to be specific now, so if there are any future
> driver changes needed the DT does not have to change (as it may be in
> firmware which you can't change).

That argument applies always, doesn't it?  There's always a chance that 
you might discover a new quirk in a device for which the DT board file 
has already been written and committed to firmware.  The board file 
could declare that the device is compatible with something older, but 
the new quirk might ruin that compatibility.

> > Okay, fine.  But then what should the binding documentation specify for
> > the compatible value?  A list of all the HW models that the driver
> > currently supports?
> 
> The binding docs should be independent of the driver. There may be
> fields the driver ignores. So you need to document all defined
> compatible strings. It is fine if the driver only has "usb-ehci", but it
> is not fine for the DT to only have that.

Under the circumstances, do we really need a new binding document for 
the ehci-platform driver?  We should be able to use the existing 
usb-ehci binding, perhaps with some new properties added:

	has-synopsys-hc-bug
	no-io-watchdog
	has-tt

We probably can omit has-synopsys-hc-bug, as that is specific to one
type of MIPS ATH79 controller.  The driver can check for it explicitly,
if necessary.

In fact, it's not clear that these new properties need to be added now.  
They can be added over time as needed, as existing drivers are
converted over to DT.  Or is it preferable to document these things
now, preemptively as it were?

The one that matters most and is most clearly a property of the HW is
"has-tt".  IMO it should be added right away, even though there may
already be DT board files that could specify it but don't.  Right now,
for example, the ehci-xilinx-of driver checks instead for the
"support-usb-fs" property, as defined in
Documentation/devicetree/bindings/xilinx.txt.

Alan Stern
