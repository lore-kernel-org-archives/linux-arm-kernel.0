From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Oct 2012 10:28:23 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210241013310.1481-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210241013310.1481-100000@iolanthe.rowland.org>
Message-ID: <50881727.10601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 08:57 AM, Alan Stern wrote:
> On Tue, 23 Oct 2012, Rob Herring wrote:
> 
>> On 10/23/2012 02:33 PM, Alan Stern wrote:
>>> On Tue, 23 Oct 2012, Stephen Warren wrote:
>>>
>>>>> Nothing intrinsically distinguishes this class of hardware.  The only
>>>>> thing these devices have in common is that they can be managed by
>>>>> Linux's ehci-platform driver.
>>>>
>>>> I don't agree. They're all EHCI USB controllers (or all EHCI USB
>>>> controllers that don't require custom drivers due to quirks), which is a
>>>> much more general statement than anything related to which driver Linux
>>>> uses for them.
>>>
>>> That's true, but it doesn't distinguish these devices.  There are other
>>> EHCI controllers with no quirks that nevertheless can't be handled by
>>> ehci-platform because they have requirements (_not_ quirks) that
>>> ehci-platform is unable to deal with currently -- clocks or power
>>> supplies or special register settings or PHYs or etc.
>>
>> But what if the h/w has quirks you haven't yet discovered? You need the
>> compatible property to be specific now, so if there are any future
>> driver changes needed the DT does not have to change (as it may be in
>> firmware which you can't change).
> 
> That argument applies always, doesn't it?  There's always a chance that 
> you might discover a new quirk in a device for which the DT board file 
> has already been written and committed to firmware.  The board file 
> could declare that the device is compatible with something older, but 
> the new quirk might ruin that compatibility.

If the board file /only/ declares that the device is compatible with the
older/most-generic thing, that would be a bug in the .dts file. As a
general rule, the device tree should be fixed, although there may be
reasons to work around some buggy device trees in the kernel we should
avoid it if possible.

Device tree files always need a completely specific value in the
compatible property, even when less-specific/more-generic values are
also present. So for example, the Linux driver might only care about the
following existing:

compatible = "usb-ehci".

However, any actual EHCI controller is always some specific model, so
the compatible value must define which specific model it is, e.g.:

compatible = "nvidia,tegra20-ehci", "usb-ehci".

Now lets say the Tegra30 EHCI controller is identical to the Tegra20
controller. That needs to be explicitly represented too:

compatible = "nvidia,tegra30-ehci", "nvidia,tegra20-ehci", "usb-ehci".

In that case, the driver might still only declare support for
"nvidia,tegra20-ehci", but "nvidia,tegra30-ehci" is added to be explicit
about the actual HW model.

This doesn't continue forever though; you typically only list the
specific HW model, the base specific model it's compatible with, and any
generic value needed. So, a hypothetical Tegra40 EHCI controller would be:

compatible = "nvidia,tegra40-ehci", "nvidia,tegra20-ehci", "usb-ehci".

Given that, there is always something to key any newly required quirk
off, so even if the need for a quirk is found later, the device tree
already contains the information needed to trigger it.

This is why quirks should always be keyed off compatible values, since
they're guaranteed to be there in a correctly written device tree.

Generic HW features (such as has-tt) don't need to be derived from the
compatible value (although they could be), since they are something
that's known up-front and hence should be present in any non-buggy
device tree from day one. That's why the binding needs to thought out
ahead of time, or if necessary (e.g. if expanded to support both EHCI
and XHCI and XYZHCI which might require extra standard properties)
evolved in a backwards-compatible fashion.
