From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Jan 2015 00:54:58 +0800
Subject: Including empty regulator nodes in axp209.dtsi is a BAD idea
In-Reply-To: <54B61DD3.6010105@redhat.com>
References: <54B4E7B5.6060304@redhat.com> <20150113164606.GA4891@lukather>
 <54B61DD3.6010105@redhat.com>
Message-ID: <CAGb2v67uGV2HBKciRVGhf-vb7K=whruiaUvv8L7Lqz=8=kBnQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 14, 2015 at 3:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
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

I think Maxime is only disagreeing to the "always-on" part. And I
somewhat agree with him, but on a technical level. It doesn't seem
possible to negate at the board level the "always-on" set in the dtsi,
or it is not obvious to me how to do so. With properties with values
you just set a new value. How do you "unset" a boolean flag?

As for the constraints, I think we can agree that everyone will use
the reference design if they choose to include the PMIC on a board.

>> If an always-on property is needed, then it's in the DTS, not in the
>> AXP DTSI.
>>
>>> The ldo-s are trickier, since we simply do not know how those
>>> are used, I think ldo2 is used for Avcc on most boards, so it
>>> too should be always on, since almost any board will have some
>>> analog parts on it (be it the ir receiver, lradc, rtp, lvds, vga,
>>> or analog audio in/out). Assuming that we're willing to assume
>>> that ldo2 is used this way, we should give it matching constraints
>>> and always mark it always-on.
>>
>>
>> Ideally, all the drivers that have a analogic component should have a
>> reference to the regulator they use. But again, at the board
>> level. And more realistically, putting always-on should also happen at
>> the board level.
>>
>>> As for ldo3 - 5 I've no idea when / for what these are used, but
>>> if we do not know it is better to just leave them be then to turn
>>> them off IMHO, so we should remove the nodes for these from axp209.dtsi
>>>
>>> Anyways sorting this all out is going to take some time, so I'm
>>> not going to use axp209.dtsi in dts files for new boards for now.
>>
>>
>> I'm afraid it's an "all or nothing" situation.
>
>
> No it is not, the PMIC is a mfd, and we can use some of its functions
> fine without actually loading the regulator bits. This is already
> done on most boards with the axp209, even without touching the regulators
> it is nice to have the axp209 mfd driver loaded so that we get support
> for the powerbutton, and support for poweroff, esp. the latter is quite
> nice to have.

I agree that a) the PMIC is an mfd, and b) we can use other bits without
loading the regulator bits. But if adding the regulator bits results in
some sort of crash or issue, just because some regulator got turned off,
it seems to me that the dt is not accurately describing the hardware.

ChenYu
