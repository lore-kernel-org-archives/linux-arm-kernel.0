From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 18 Jan 2017 09:44:37 +0000
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <20170116163124.c5gusyd3j3goivnf@lukather>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
 <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
 <20170105224210.wfinfucbpkkd44om@lukather>
 <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
 <20170116163124.c5gusyd3j3goivnf@lukather>
Message-ID: <87a535d3-1170-c388-ce7d-4921e69f4cab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/01/17 16:31, Maxime Ripard wrote:
> On Mon, Jan 09, 2017 at 12:16:00AM +0000, Andr? Przywara wrote:
>> On 05/01/17 22:42, Maxime Ripard wrote:
>>> On Fri, Dec 30, 2016 at 01:55:44PM +0100, Linus Walleij wrote:
>>>> On Mon, Dec 26, 2016 at 3:33 PM, Andr? Przywara <andre.przywara@arm.com> wrote:
>>>>
>>>>> So while this patch technically looks correct, I was wondering if we
>>>>> should really explore the possibility of making the whole of sunxi
>>>>> pinctrl DT controlled.
>>>>> I brought this up a while ago, but people weren't overly enthusiastic
>>>>> about it, though their argument weren't really convincing to me[1].
>>>>>
>>>>> So:
>>>>> As this "driver" here is basically a table linking GPIO bit settings
>>>>> (the actual mux value) to names and every pin we care about needs to be
>>>>> enumerated in the DT anyway, why not just add something like:
>>>>> allwinner,pinmux = <4>;
>>>>> to each pin(group) in the DT and get rid of this "driver" file here
>>>>> entirely?
>>>>
>>>> I'm open to that if you can use pinctrl-single which is in the kernel
>>>> for this purpose only, and is used with both OMAPs and HiSilicon.
>>>
>>> I'm not open to that, and I'm getting tired of discussing it over and
>>> over again. Andre, if you want to be convinced again, please read the
>>> last discussion we had on this topic.
>>
>> As I said: It didn't convince me back then. And frankly we didn't really
>> discuss it back then, I just refrained from entering a discussion
>> against _two_ maintainers at this time, since my capacity on this kind
>> of email threads is really very limited - especially for something that
>> is a hobby to me.
> 
> This is also (mostly) a hobby to me, which is exactly why I prefer to
> work on something actually useful, rather than just discussing this
> over and over again. Just like I don't want (myself, or anyone,
> really, since we're all in the same boat) to have to maintain two
> separate pinctrl drivers.
> 
> We're having a documented, simple, pinctrl binding, using the generic
> bindings now (that almost everyone else is using now, or is very close
> to), and we can leverage as much documentation and code from that. Why
> would we want to create and maintain a new driver with a new binding,
> that will need to be documented again, learned by everyone, and will
> lead only to confusion across the people who just want to have their
> board supported?

I agree, and thus was proposing a _slightly changed_ pinctrl driver
which actually *reduces* the maintenance burden in the kernel.
In the moment we need to add _both_ a pinctrl .dtsi node _and_ a kernel
"driver" file, which is really boilerplate code plus a table.
Also we need to make sure that both these files match.
If a new SoC is really 99% similar to an existing one, atm we still need
explicit kernel support if only one pin is changed (see the H5).

So my idea was to basically add the mux value as a DT property, thus
making the kernel pinctrl-sun[x]i-a[yz].c files obsolete and greatly
_reduce_ the maintenance burden. Ideally there wouldn't be any pinctrl
code changes in the kernel for future SoCs anymore - at least if
Allwinner sticks with their current pace of releasing copy&pasted SoC
designs. Changes beyond that would require a driver change anyway, even
with the current model.

I gave Linus' proposal to use the pinctrl-single binding a quick look
and don't think it's a match for Allwinner SoC. So my idea was to
basically just add a new compatible and the muxsel property to the
existing driver and binding. It would basically look the same, apart
from one or two additions (to cover interrupts, for instance).
Any future SoCs could then just use that compatible and would describe
the SoC details in the DT, like it's meant to be and like we do already,
but extended by putting the mux value in there as well.
So the only kernel contribution would then be the DT, really, which
technically could be delivered on some device storage as well, but
that's a different discussion ...

> And imagine the kind of mess we would be in if everyone getting a bit
> involved in the support of one platform at one point wanted to trash
> one big part of its infrastructure and start all over again because he
> likes it better this way.

Like I said above, I didn't mean to trash the current pinctrl binding,
just make it a bit more generic and simplify future kernel support.

> I'm sorry, but this is also our jobs as maintainers to prevent all
> these kind of issues, and to maintain consistency. Switching to one
> binding to another breaks that consistency on many level,

Yet we did it for the clocks. The very same argumentation that you gave
above applies there as well (two different bindings, two sets of drivers
in the kernel, new learnings for people, etc.)
One difference would be that the new pinctrl binding wouldn't be
fundamentally different to the old one, up to the point where the old
driver could possibly use the very same DT nodes (but that would need to
be worked out).

Cheers,
Andre.

> both in
> pinctrl and in the platform support itself. So sorry, but that's not
> going to happen.
> 
> Maxime
> 
