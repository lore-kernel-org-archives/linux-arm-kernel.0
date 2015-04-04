From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 4 Apr 2015 14:18:12 +0200
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150330222311.GY23664@lukather>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
Message-ID: <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Mark Brown and Stephen Warren to cc list]

Hello,

On Tue, Mar 31, 2015 at 12:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Mar 28, 2015 at 11:53:06AM +0000, Iain Paton wrote:
>> On 27/03/15 11:02, Hans de Goede wrote:
>> > Hi Iain,
>> >
>> > On 27-03-15 11:58, Iain Paton wrote:
>> >> add pmic regulator definitions matching the manufacturers 3.4.x fex
>> >> file.
>> >>
>> >> Signed-off-by: Iain Paton <ipaton0@gmail.com>
>> >> ---
>> >>
>> >> As this file belongs to Hans and he decided not to use axp209.dtsi in
>> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315612.html
>> >> then I won't add it here.
>> >
>> > That was because using it was breaking stuff, but now that we know better
>> > which regulators are used for what, and which one we most add an always-on;
>> > property too, I would greatly prefer you to acually use axp209.dtsi, see
>> > e.g. the sun5i-a13-utoo-p66.dts file where I'm using it.
>> >
>> > Can you please respin this patch using axp209.dtsi?
>> >
>> > Also please do not add nodes for unused regulators, like the ldo-s for the csi-s.
>>
>> You would prefer that the csi is broken on the lime then?
>
> CSI is not usable (no driver for it), neither it is actually used by
> default on the lime, so disabling the regulator is the right thing to
> do.
>
>> Unlike the cubieboards, ldo3 & ldo4 really are used on the olimex
>> boards. So it seems that as yet you still don't know enough about
>> which regulators are used, or you wouldn't be asking for that.
>
> They are not used. They are connected to something that is not usable
> in itself, so leaving them enabled is just useless.
>
>> That's the major disadvantage of axp209.dtsi, the regulator node
>> isn't describing the pmic at all. Instead it's describing the stuff
>> connected to the pmic outputs, which is undeniably board specific
>> and therefore totally unsuitable for a generic file. Leading to
>> every board needing to override everything regardless.
>
> No, it's defining which regulators are provided by the regulator, and
> the voltage boundaries they have. It doesn't make any assumption with
> regards to what is connected to what, and if a particular regulator is
> connected to something. That's something that the board DTS should
> describe as accurately as possible.
>
>> So no, I'm not going to respin the patch. I strongly believe using
>> axp209.dtsi is the wrong thing to do here.  If that means the patch
>> doesn't make it in, then so be it.
>
> Too bad.
>

I'm not familiar with the sunxi platform but just wanted to mention
that AFAIK Mark Brown thinks that generic PMIC .dtsi files describing
regulators is not a good idea. At least he nacked [0] when I tried to
do something similar to avoid having duplicated DTS fragments for the
tps65090 PMU used in the Exynos Chromebooks. But I've added him as cc
in case I misunderstood something.

Stephen Warren (cc'ed too) also said that those files are not very
useful [1] since are largely content free and the regulators
description would have to be duplicated in the DTS anyways since that
information is very board specific. Which is the point that Ian makes
for not using the axp209.dtsi.

The only two platforms that have included .dtsi for PMICs are sunxi
and omap (i.e: twl4030.dtsi) but Mark said that at least in the case
of the twl4030 pmic, the .dtsi is broken [0].

As I said, I'm not particularly interested in sunxi but I think it is
good to have consistency on how things are done across the different
platforms.

> Maxime

Best regards,
Javier

[0]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/278983.html
[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279265.html
