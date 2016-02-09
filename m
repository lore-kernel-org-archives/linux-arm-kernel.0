From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Feb 2016 10:42:47 +0000
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <CABM=7k=-Y+eFB2nUMfMjd3saTSNDsEyfHyYNf-ef8qQc5jCsxA@mail.gmail.com>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
 <56B8B45D.1020902@arm.com> <20160209085633.GA5388@kwain>
 <20160209090131.GB5388@kwain> <56B9ACE2.1060200@arm.com>
 <CABM=7knaepbyy4nw_GczVM7E_t6py7gG0ERs8ru_AYoVXvAQ+A@mail.gmail.com>
 <56B9B1B5.5070106@arm.com>
 <CABM=7k=-Y+eFB2nUMfMjd3saTSNDsEyfHyYNf-ef8qQc5jCsxA@mail.gmail.com>
Message-ID: <56B9C2A7.4040402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 10:13, Tsahee Zidenberg wrote:
> On 9 February 2016 at 11:30, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> On 09/02/16 09:14, Tsahee Zidenberg wrote:
>>>
>>>
>>> On 9 February 2016 at 11:09, Marc Zyngier <marc.zyngier@arm.com
>>> <mailto:marc.zyngier@arm.com>> wrote:
>>>
>>>     On 09/02/16 09:01, Antoine Tenart wrote:
>>>     > On Tue, Feb 09, 2016 at 09:56:33AM +0100, Antoine Tenart wrote:
>>>     >> Hi Marc,
>>>     >>
>>>     >> On Mon, Feb 08, 2016 at 03:29:33PM +0000, Marc Zyngier wrote:
>>>     >>> On 08/02/16 09:11, Antoine Tenart wrote:
>>>     >>>
>>>     >>>> +          gic: gic at f0100000 {
>>>     >>>> +                  compatible = "arm,gic-v3";
>>>     >>>> +                  reg = <0x0 0xf0200000 0x0 0x10000>,     /* GIC Dist */
>>>     >>>> +                        <0x0 0xf0280000 0x0 0x200000>,    /* GICR */
>>>     >>>> +                        <0x0 0xf0100000 0x0 0x2000>;      /* GICC */
>>>     >>>> +                  interrupt-controller;
>>>     >>>> +                  #interrupt-cells = <3>;
>>>     >>>> +          };
>>>     >>>
>>>     >>> Something is wrong here. Either you are missing GICH and GICV (assuming
>>>     >>> you have legacy support), or you have an extra GICC region (which
>>>     >>> doesn't make sense on its own).
>>>     >>
>>>     >> I'll add the missing regions.
>>>     >
>>>     > Hmm, in fact the GICC region shouldn't be there. I'll make some tests
>>>     > and remove it.
>>>
>>>     If you have a GICv3 with legacy support, you will probably have GICC,
>>>     GICH and GICV. Linux itself will only use GICD and GICR, but it needs at
>>>     least GICV to be able to virtualize GICv2 guests. And GICV is not
>>>     allowed to exist without GICC and GICH, so I really recommend that you
>>>     keep GICC around.
>>>
>>>
>>> We use the GIC without legacy support (we disable it in early boot
>>> stages), so I think removing the GICC region is the better solution.
>>
>> Disabling legacy support doesn't mean that:
>> - the HW isn't present
>> - the associated regions are not useful
>>
> By "disabling lecgacy support in early boot" I don't just mean that
> ARE bit will be set, but it will actually be RAO/WI. There will be no
> way for SW to enable it and use these registers (which, sadly, means
> that there will be no way to enable gicv2 virtualization). If you
> insist - I will dig up the supposed location of GICV and GICH - yet it
> will be both untested and entirely unusable.

That's quite sad indeed. You are pointlessly breaking existing software.
But hey, that's your choice. At that point, I can't be bothered to care.

> We will add an entry for the maintenance interrupt, as it really can
> be used by future configurations.

Well, at least you'll be able to run GICv3 guests, assuming everything
else is usable.

	M.
-- 
Jazz is not dead. It just smells funny...
