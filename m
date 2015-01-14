From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 14 Jan 2015 09:11:39 +0100
Subject: [linux-sunxi] Re: Including empty regulator nodes in axp209.dtsi
 is a BAD idea
In-Reply-To: <54B61DD3.6010105@redhat.com>
References: <54B4E7B5.6060304@redhat.com> <20150113164606.GA4891@lukather>
 <54B61DD3.6010105@redhat.com>
Message-ID: <CAOMqctT_WpAy1-PafVmo46GhugO4pG1ueyGFhT2PLYMSXxSRLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 14 January 2015 at 08:42, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 13-01-15 17:46, Maxime Ripard wrote:
>>
>> On Tue, Jan 13, 2015 at 10:39:01AM +0100, Hans de Goede wrote:
>>>
>>> Hi ChenYu, Maxime,
>>>
>>> During the review of a few dts files for new boards Maxime asked me to
>>> use
>>> axp209.dtsi to avoid the standard axp209 "boilerplate" present in most
>>> boards using the axp209 pmic.
>>>
>>> But axp209.dtsi includes empty regulator nodes, e.g. :
>>>
>>>                  reg_dcdc3: dcdc3 {
>>>                          regulator-name = "dcdc3";
>>>                  };
>>>
>>> This is a BAD idea, the presence of these empty nodes causes the
>>> axp20x-regulator driver to actually register regulators for them,
>>> and then on late_init the regulator subsys turns them off, since
>>> they have absolutely no constraints set (nor users registered)
>>> and the regulator subsys assumes that when devicetree is used their
>>> is always a compete set of constraints and that thus turning them
>>> off is safe.
>>>
>>> So when I switched to using axp209.dtsi for the bananapro.dts,
>>> and booted the bananapro this is the last message I got from the
>>> kernel while booting:
>>>
>>> [    2.314014] dcdc3: disabling
>>>
>>> And away went our DRAM power-supply, oops.
>>>
>>> So for dcdc2 (CPU) and dcdc3 (DRAM), the boilerplate
>>> should contain reasonable constraints (eg the operating range
>>> from the datasheet)
>>
>>
>> Indeed.
>>
>>> and an always-on property.
>>
>>
>> I disagree. The regulator disabling is a feature, and how the board is
>> wired is, well, up to the board.
>
>
> And here I was thinking you wanted to reduce the amount of boilerplate
> in our dts files ..
>
> IOW I disagree with your disagreeing all boards we know of have dcdc2
> wired to Vcpu and dcdc3 wired to Vddr, so not having this in the dtsi
> will lead to a lot of extra boilerplate in each dts file. We're not
> talking about our main dtsi file here, if we ever encounter a board
> which is wired in a different way, then its dts can simply not use
> axp209.dtsi and instead define the nodes itself, it needs to do that
> anyways if we do include the standard CPU and DDR constrains in the
> dtsi since those will not make sense either in that case.
>

We don't really have a CPU and DDR driver so what will mark these
regulators as used when not always on?

There is cpufreq that modifies the voltage but that's optional.
Suspend may even turn off Vddr but that's quite special.

Cpufreq should work within the CPU and memory voltage constraints but
these may vary per SoC and even per board due to trace design. If it's
not possible to override the constraints per-board then setting them
in the include file is counter-productive.

The other regulators, sure. If you have analog audio you have a driver
for it and it should power on the analog part. If it does not do it
now it's a bug and it should be fixed.

Thanks

Michal
