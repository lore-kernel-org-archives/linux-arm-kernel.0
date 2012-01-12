From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 12 Jan 2012 12:56:52 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <7FE21149F4667147B645348EC605788508E7B0@039-SN2MPN1-013.039d.mgd.msft.net>
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
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508E7B0@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D1DD6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng wrote at Thursday, January 12, 2012 1:36 AM:
> Stephen Warren wrote at Thursday, January 12, 2012 4:18 AM:
> > Dong Aisheng wrote at Tuesday, January 10, 2012 1:21 AM:
> > > Stephen Warren wrote at Saturday, January 07, 2012 2:03 AM:
...
> > Personally, I think I'd be OK with the sysfs pinctrl map file only containing
> > the map entries for devices that had used the pinctrl API, and hence only
> > parsing the pinmux properties in pinmux_get().
>
> Actually I already did it like that in the patch I sent:
> https://lkml.org/lkml/2012/1/5/153
> 
> Originally I'd like to do like that but I found an inconsistent issue that
> the sysfs pinctrl map file will behave differently between dt and non-dt
> Platform. For non-dt, it means showing all exist map entries. For dt, it means
> Only used pinmux map entries.
> 
> And in current design when device calls pinmux_get, it will search a predefined
> pinmux_maps array to find which function and group it is binded to.
> If switch to the new way, we only dynamically create pinmux map and dynamically
> register it when pinmux_get is called, first we need to change the code path in
> pinmux_get in a totally different way, second for support that we may also better
> to change pinmux_maps array to a list.
> But after changing the pinmux_maps to a list, what about using in non-dt?
> 
> So without any strong reason i still think it would be better to keep consistency
> With the non-dt pinctrl subsystem.
> And the effort would be minimum since besides constructing the map by parsing
> Device tree, everyting is the same as before in pinmux map and we could re-use
> the current code.

OK. I think this can work out pretty easily with a bus notifier as I
mentioned before.

But, one thought on doing this in pinmux_get(). I'd simply implement a
Function that read a DT node's pinmux property/node, converted it to a
pinmux mapping table, and registered it with the pinctrl core. Then,
pinmux_get() could simply call this before doing anything else at all.
I don't think you'd need to modify how pinmux_get() worked at all.

-- 
nvpublic
