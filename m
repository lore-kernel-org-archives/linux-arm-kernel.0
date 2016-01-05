From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 5 Jan 2016 12:24:35 +0000
Subject: [linux-sunxi] reason for Allwinner SoC specific pinctrl drivers?
In-Reply-To: <CAGRGNgUVNGoOUNqyySjYzkL4KfEWK8orYH-AMxoCX-9N0R80-A@mail.gmail.com>
References: <568A514D.7070102@arm.com>
 <CAGRGNgUVNGoOUNqyySjYzkL4KfEWK8orYH-AMxoCX-9N0R80-A@mail.gmail.com>
Message-ID: <568BB603.4030904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

On 04/01/16 22:04, Julian Calaby wrote:
> Hi Andre,
> 
> On Mon, Jan 4, 2016 at 10:02 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> Hi,
>>
>> while looking at the Allwinner A64 SoC support, I was wondering why we
>> would actually need a pinctrl driver (file) for each and every Allwinner
>> SoC that we support.
>> Looking at both the A20 and the A64 doc I don't see any differences in
>> the port controller implementation apart from the actual
>> muxval <-> subsystem assignment, which is just data, right?
>> Comparing the code files in drivers/pinctrl/sunxi seems to support this,
>> as those drivers only consist of the table and some boilerplate code.
>>
>> Now I was wondering whether we could get away with one generic Allwinner
>> pinctrl driver and put the SoC specific pin assignments in DT instead.
>> It looks like adding an "allwinner,muxval" property in addition to the
>> existing "allwinner,function" in the SoC's .dtsi would give us all the
>> information we need. This could look like:
>>
>>         uart0_pins_a: uart0 at 0 {
>>                 allwinner,pins =   "PB22", "PB23";
>> +               allwinner,muxval = <0x02    0x02>;
>>                 allwinner,function = "uart0";
>>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>         };
>>
>> Would it make sense that I sit down and prototype such a driver?
>>
>> We should keep compatibility with older DTs by keeping the existing
>> drivers in (or maybe emulating the current behaviour by providing just
>> those tables as a fallback) , but newer SoCs (like the A64?) would not
>> need a SoC specific driver, but just go with that generic driver and
>> appropriate DT properties.
>>
>> I appreciate any comments on this, especially if I missed something
>> which would render this approach impossible or tedious.
> 
> I think that, as Michal said, merging the drivers might be possible,
> however there's another three functions the drivers serve:
> 
> 1. they're good documentation of how it's all configured. I'm not sure
> your device tree based approach will be as user friendly in this
> regard.
> 
> 2. they list stuff we don't have a driver / hardware for yet
> 
> 3. the policy on device-tree is to only include stuff we know is
> working, which means we have a driver and hardware for that particular
> thing. Device tree files for boards or SoCs have been rejected because
> they list stuff that isn't used yet.

Those are good points, thanks for bringing them up.
Hopefully they are no show stoppers... I will try to come up with some
kind of workaround for 2. and 3.
We could find a way to document the stuff somewhere, I guess the sunxi
wiki would be a good start.
But actually we should just reference to publicly available docs, say
the Allwinner documentation github repo. I know, I know ... ;-)
Is there any known wrong or missing information for the port controller
and mux settings in Allwinner's doc?

Cheers,
Andre.
