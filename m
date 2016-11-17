From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Nov 2016 16:39:07 +0000
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <2eaf84f9-ea00-d331-1875-56adafb62378@roeck-us.net>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
 <20161116184649.GF11228@leverpostej>
 <20161116221002.GA19925@roeck-us.net>
 <CAOMZO5Bd2X3pVqExBtBw_uHReDDkf6J2VdMXnAXynCAHxoX60A@mail.gmail.com>
 <20161116224024.GA11821@roeck-us.net>
 <20161117105513.GA12273@leverpostej>
 <198d764e-1612-81b4-5f4e-0c221a23c8e0@roeck-us.net>
 <20161117150551.GA21742@leverpostej>
 <2eaf84f9-ea00-d331-1875-56adafb62378@roeck-us.net>
Message-ID: <20161117163906.GB21742@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 08:17:00AM -0800, Guenter Roeck wrote:
> On 11/17/2016 07:05 AM, Mark Rutland wrote:
> >On Thu, Nov 17, 2016 at 06:44:55AM -0800, Guenter Roeck wrote:
> >>On 11/17/2016 02:55 AM, Mark Rutland wrote:
> >>>Memory nodes require this property per ePAPR and the devicetree.org
> >>>spec, so the bug is that we didn't add those when removing the
> >>>skeleton.dtsi include.
> >>
> >>The downside from qemu perspective is that the real hardware seems
> >>to add the property unconditionally, or the boot failure would have
> >>been seen there as well.
> >>
> >>I submitted https://patchwork.ozlabs.org/patch/695951/; we'll see how it goes.
> >
> >Sure, the firmare/bootlaoder you're using may add this automatically.
> >
> >My worry is that adding this to a generic file in QEMU only serves to
> >mask this class of bug for other boards (i.e. they'll work fine in QEMU,
> >but not on real HW using whatever bootlaoder happens ot be there).
> >
> Good point.
> 
> What would be the correct behavior for qemu ? Adding a chosen node if it does
> not exist is one detail we already established. Also, I think a check if
> /memory/device_type exists (and to bail out if it doesn't) would make sense.

We'd also need to check for /memory@<n> nodes, as they can validly have
unit-addresses (and many do).

Generally, the "correct" way to find them is to iterate over all ndoes
with device_type = "memory", so one could do that and give up if none
are found, ignoring the naming entirely.

> What about the memory node ? Does it have to exist, or should it be added
> (including the device_type property) if not ?

I'm not sure what QEMU does in this area. I suspect it may expect a node
in some cases, or may generate one in others.

There's no point generating one when we don't have the information to
hand, certainly.

Thanks,
Mark.
