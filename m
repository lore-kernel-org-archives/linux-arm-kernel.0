From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Oct 2012 10:16:31 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <20121024152652.GG4368@breakpoint.cc>
References: <5086F8D6.5050605@gmail.com>
 <Pine.LNX.4.44L0.1210241013310.1481-100000@iolanthe.rowland.org>
 <20121024152652.GG4368@breakpoint.cc>
Message-ID: <5088145F.1040504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 09:26 AM, Sebastian Andrzej Siewior wrote:
> On Wed, Oct 24, 2012 at 10:57:00AM -0400, Alan Stern wrote:
>> Under the circumstances, do we really need a new binding document for 
>> the ehci-platform driver?

It seems reasonable to add the new properties to usb-ehci.txt, since
they do describe the HW.

>> We should be able to use the existing 
>> usb-ehci binding, perhaps with some new properties added:
>>
>> 	has-synopsys-hc-bug
>> 	no-io-watchdog
>> 	has-tt

That sounds fine to me.

However, there is an implementation issue here. I believe the way Linux
searches for a driver for a particular node is:

for every driver that's registered
    if the driver's supported compatible list matches the device
        use the driver

(See drivers/base/platform.c:platform_match() which implements the if
statement above, and I assume the driver core implements the outer for
loop above)

That means that if the generic driver supports compatible="usb-ehci", it
may "steal" device nodes that have
compatible="something-custom","usb-ehci", even if there's a driver
specifically for "something-custom". We would need to re-arrange the
driver matching code to:

for each compatible value in the node:
    for each driver that's registered:
        if the driver supports the compatible value:
            use the driver.

> On the PCI side we have VID, PID which is used for quirks. Sometimes we have a
> revision ID which can be used to figure out if "this quirk" is still required.
> The PCI driver probes by class so the ehci driver does not have a large table
> of VID/PID for each controller out there. And the USB controller in two
> different Intel boards has a different PID so a quirk, if required, could be
> applied only to the specific mainboard.
> 
> Based on this we need atleast two compatible entries one "HW-Specific"
> followed by a generic one (similar to PCI class).
> Doing it the PCI way we would have to have table and figure out which
> HW-specific compatible entry sets the TT flag and which one does the
> no-io-watchdog. Having has-tt in compatible isn't right.

Yes, the driver could easily bind to anything compatible with
"usb-ehci", then use the HW-specific compatible value to index into a
quirk table in the same way that specific PCI IDs index into a quirk table.

I agree that having separate compatible values like usb-ehci and
usb-ehci-with-tt probably doesn't make sense here.

> I'm all with Alan here, to make a shortcut and allow Linux specific properties
> which describe a specific quirk in less code lines. Other OS can just ignore
> those and build their table based on the compatible entry if they want to.

We should absolutely avoid Linux-specific properties where possible.

That said, what Linux-specific properties are you talking about? The
properties discussed here (has-synopsys-hc-bug, no-io-watchdog, has-tt)
are all purely a description of HW, aren't they.

> So usb-ehci should be fine. It is a generic USB-EHCI controller after all.
> Quirks or no quirks, the register layout is the same, the functionality is the
> same. If you can't map memory >4GiB then you need a quirk for this but you may
> discover it way too late.
> If your platform driver requires extra code for the PHY then it is still an
> EHCI controller. The PHY wasn't setup by the bootloader / bios so Linux has to
> deal with it.
> 
>> We probably can omit has-synopsys-hc-bug, as that is specific to one
>> type of MIPS ATH79 controller.  The driver can check for it explicitly,
>> if necessary.
>>
>> In fact, it's not clear that these new properties need to be added now.  
>> They can be added over time as needed, as existing drivers are
>> converted over to DT.  Or is it preferable to document these things
>> now, preemptively as it were?

It's best to define the binding up-front so it doesn't churn, where
possible. This will also ensure that multiple people don't try to update
the binding document to add the same feature in different ways.

> I would add it only if required / has users.
