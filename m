From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 12:17:51 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng wrote at Tuesday, January 10, 2012 1:21 AM:
> Stephen Warren wrote at Saturday, January 07, 2012 2:03 AM:
...
> > Now in the board's .dts file, you need to specify for each device the list of
> > pinmux groups the device needs to use, and the function to select for each group.
> > Perhaps something like:
> >
> > board.dts:
> >
> > usdhc at 0219c000 { /* uSDHC4 */
> >         fsl,card-wired;
> >         status = "okay";
> >         pinmux = <&foogrp &uart3func &bazgrp &uart4func>; };
> >
> > I haven't convinced myself that's actually a good binding, but I think it does
> > represent the data required for muxing. Some potential issues as before:
>
> Here is what we should discuss exactly.
> Since 'pinmux' phandle will be parsed in pinctrl core, we should try to find and
> define a common and standardized pinmux property for all platforms.

Yes.

...
> To keep consistency as the currently design of pinctrl subsystem and also meet
> the dt design philosophy, we still do not introduce a pinmux map in dt.
> Instead, we choose to scan all the device node with a 'pinmux' phandle to construct
> a pinmux map table before register the pin controller device(here we may also scan
> the hog_on_boot node) and I guess it's easy to do that.
...
> (Without scan the device node to construct the pinmux map table, we can only get the map
> Information when we run the pinmux_get.
> See: https://lkml.org/lkml/2012/1/5/153
> So no pinmux map table exists and we surely do not want to see that the sysfs exporting
> pinmux map information works in dt but unwork in non-dt)

Hmmm. I'm not sure that the pinctrl code should actively scan all nodes
in the device tree for pin mux properties. That seems a little invasive;
how does pinctrl know which nodes it really should be looking at, and
which nodes are random internal parts of some device's custom binding?

Personally, I think I'd be OK with the sysfs pinctrl map file only
containing the map entries for devices that had used the pinctrl API,
and hence only parsing the pinmux properties in pinmux_get().

However, we could perhaps do better by registering a bus notifier, and
pro-actively parsing the top-level DT node (if there is one) for every
device that is created. That way, the mapping would be parsed as soon
as the device was created (or perhaps after probe?). The only case this
might not cover is DT nodes for which the kernel doesn't actually have
a driver, and hence no device is created.

> BTW it seems you want to support multi pin groups(foogrp and bazgrp) for one device,
> do we have such using case?
> I guess usually one pin group already contains all the pins of device.
> Anyway, just from flexibility view, it's good for me.

Yes.

Recall that I believe that pin group definitions should only exist where
the HW itself muxes pins on a per-group basis rather than a per-pin basis.
This may be a bit different to what you mean by a group. Anyway...

As an example on Tegra, we have:

* SD controller 4 HW block
* Pin group ATB contains two pins, which are the CLK and CMD signals
  when the SDIO4 function is muxed onto the group.
* Pin group GMA contains four pins, which are DATA[3:0] when the SDIO4
  function is muxed onto the group.
* Pin group GME contains four pins, which are DATA[7:4] when the SDIO4
  function is muxed onto the group.

Hence, a board that uses this SD controller in that configuration would
need 3 entries in its pinmux property/node.

In general, I think all SoCs are likely to be the same way, except that
you'd need n pins in the list instead of n groups, again recalling that
I'm talking about HW-level pins/groups, not entries in a "supported
configuration" list.

-- 
nvpublic
