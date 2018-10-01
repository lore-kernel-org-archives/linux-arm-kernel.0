From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 1 Oct 2018 01:52:56 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <CAGb2v65bY3wnJLY802f-qD3aRjWqgONVEOWqKyXrKRdsK5HHPw@mail.gmail.com>
References: <20180917152857.162662-1-andre.przywara@arm.com>
 <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
 <20180921153522.0413c280@donnerap.Emea.Arm.com>
 <CAGb2v65bY3wnJLY802f-qD3aRjWqgONVEOWqKyXrKRdsK5HHPw@mail.gmail.com>
Message-ID: <a4999422-894e-66c9-d875-b1c907220488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/18 3:57 PM, Chen-Yu Tsai wrote:

Hi,

> On Fri, Sep 21, 2018 at 10:35 PM Andre Przywara <andre.przywara@arm.com> wrote:
>>
>> On Fri, 21 Sep 2018 17:47:50 +0800
>> Chen-Yu Tsai <wens@csie.org> wrote:
>>
>> Hi,
>>
>> (sorry if I steer the discussion in the wrong direction, I am not quite
>> sure if you dismiss the idea of staying compatible in general or if you
>> just point to an issue with my particular solution. Trying to reason
>> on both below.)
>>
>>> On Mon, Sep 17, 2018 at 11:29 PM Andre Przywara
>>> <andre.przywara@arm.com> wrote:
>>>>
>>>> Commit 1f1f5183981d ("arm64: dts: allwinner: a64: add SRAM
>>>> controller device tree node") changed the (so far unused)
>>>> compatible name of the sytem controller node, to match a specific
>>>> SRAM controller driver instead of relying on the generic syscon
>>>> driver. The Ethernet driver needs a register in there, so it got
>>>> amended to use the new driver instead of the generic syscon
>>>> approach. Consequently the "syscon" compatible has been dropped, as
>>>> it's not needed anymore and would compete with the new SRAM driver.
>>>>
>>>> However this breaks existing DT consumers like older kernels, which
>>>> expect the node pointed to by the syscon property to contain the
>>>> string "syscon" somewhere in the compatible list. When such a DT is
>>>> given to an older kernel (<4.19, for instance one on a distro
>>>> installer image), the Ethernet will not probe successfully:
>>>> ----------
>>>> dwmac-sun8i 1c30000.ethernet: PTP uses main clock
>>>> dwmac-sun8i 1c30000.ethernet: Linked as a consumer to regulator.6
>>>> dwmac-sun8i 1c30000.ethernet: Unable to map syscon: -22
>>>> dwmac-sun8i 1c30000.ethernet: Dropping the link to regulator.6
>>>> dwmac-sun8i: probe of 1c30000.ethernet failed with error -22
>>>> ----------
>>>>
>>>> To avoid this problem, (re-)add the "syscon" string to the
>>>> compatible list of the sytem controller. This should make both
>>>> older and newer kernels happy:
>>>> - A newer kernel will try to find an existing *device* offering the
>>>> regmap first. The "syscon" string itself will not trigger a driver
>>>> probe on its own, the node must be explicitly referenced by another
>>>> driver, wanting to use the regmap. Newer kernels won't do it this
>>>> way and will use the regmap offered by the SRAM driver.
>>>> - An older kernel will try the syscon way, and the system
>>>> controller / SRAM driver DT node is still fully syscon compatible.
>>>>
>>>> So by adding "syscon" we make everyone happy: Newer kernels will
>>>> ignore it (knowing a better way), and older kernels will still work.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>> Hi,
>>>>
>>>> I think we need to amend the Ethernet driver now to not too easily
>>>> use syscon as a fallback, in case dwmac-sun8i probed earlier than
>>>> the SRAM driver. Will try this later tonight, but just wanted to
>>>> start the discussion.
>>>
>>> There is a good reason for removing the syscon compatible. It signals
>>> that the block is a "generic" collection of random registers, which in
>>> this case is not. This is the main reason. A supplimental one follows.
>>
>> But syscon would only be the fallback, following the DT compatible
>> string semantics: If a kernel doesn't have a specific driver, it could
>> use "syscon" to get at least some basic functionality.
> 
> Unfortunately that is not how syscon actually works. See below.

I think I understand that syscon is different (doesn't probe triggered
by its compatible string). And in this case it's the responsibility of
the "consuming" driver to ensure the DT semantics (see below).

>> In this case I would expect the SRAM driver to be coupled with the DE2
>> driver requiring it, so we have the SRAM with it and don't need it
>> without it. So syscon is a reasonable fallback for older kernels.
>>
>> I understand that from a "designer's" point of view syscon is not really
>> applicable (see the end of the first paragraph of the commit message).
>> The problem is: we broke compatibility with older kernels. I missed that
>> point back when the change was posted, because I thought older kernels
>> would just follow the syscon phandle. I missed that they require a
>> "syscon" compatible string in there.
>> So I am looking for a simple solution to have all the new features but
>> keep the new DT compatible with older kernels.
>> (If the reason for staying compatible in this direction is not clear,
>> see below.)
>>
>>> Implementations follow this "generic" concept and offer unrestricted,
>>> concurrent access to the syscon region. Linux and one of the BSDs
>>> AFAIK are the same in that syscon is just an API and not a full-blown
>>> device. Thus the other sram controller driver that we bind to it has
>>> no way of knowing about other accesses happening under its nose.
>>> U-boot, IIRC, makes syscon an actual device driver, so you can't even
>>> have both drivers bind to the same node.
>>
>> I don't think that the drivers would conflict on the hardware level,
>> would they? Even if both would match: A kernel would check the
>> compatible strings in order: If it matches on the specific string, the
>> new driver initialises and claims the MMIO region. Any attempts from
>> other drivers (including syscon) after this point would just fail, on
>> the ioremap() in Linux for instance. Similar on the other hand: If
>> syscon is the first getting probed, its ioremap() wins and the specific
>> driver would fail on probing. But DT's compatible string list semantics
>> would ensure the proper order. With that slightly awkward behavior for
>> syscon, which we can fix.
>>
>> So we won't have the issue of two drivers competing for the same
>> hardware. I believe this is true for every halfway sane implementation.
> 
> Actually, no. syscon is not a "device driver" and does not follow the
> driver model. Not in Linux at least. syscons are registered on first use.
> When a consumer looks up a syscon phandle, if the phandle is valid and
> the node pointed to has a "syscon" compatible, and its syscon has not
> been registered, the syscon framework just goes ahead and creates an
> MMIO regmap. There is no exclusion.
> 
> Recap: syscon does not follow the driver model or compatible string list
> parsing semantics.

I understand that, but the consuming driver currently follows the
semantics: I checks for a regmap offered by a proper device first, so
anything offered by a non-syscon driver. Then it only reverts to the
syscon method otherwise - to keep backwards compatibility.

> Besides, ioremap doesn't guarantee the region is only used by one consumer.
> Requesting the region does. (IIRC there are ways around it, like being a
> sub-device of the one that first requested it, but that's off topic.)

OK, that seems to be true. ioremap doesn't seem to check for existing
users at all (that' probably due to the "re" in its name). But I don't
think the matters here:
- Either the kernel has support for the proper driver - then the device
should always get the regmap from there and will never try syscon.
- If the kernel does not have this driver, syscon will do the trick.
Without any proper driver there is also no concurrent user of the area
covered by syscon.
- If there is a consuming driver using syscon and another consumer
requiring the specific driver, that should be considered a DT bug. Or we
don't care, if both consumers don't conflict in their MMIO accesses.

So where would be the problem? I don't see a valid case with two
ioremaps on the same region.
I don't think we need to care about anyone adding a random syscon user
to the DT, which conflicts with the SRAM driver. This would be just wrong.

Cheers,
Andre.

>>> Yes these are implementation issues, but other drivers might depend
>>> on it. The syscon driver is simple and nice to use, until it isn't.
>>
>> I see that and I understand that it probably should have been a
>> specific driver from the beginning, but that this is always easy to say
>> at hindsight ;-) And since I don't have a time machine, we need to fix
>> it somehow differently.
>>
>> So the practical problem at hand: I can't reasonably push this DT into
>> U-Boot anymore, so that it gets passed on to EFI apps (grub) and on from
>> there to kernels: Anyone wanting to boot a kernel <4.19 (Ubuntu 18.04
>> installer) or some FreeBSD, for instance, will now no longer
>> have Ethernet. Which worked before, the 4.18 DTs we have in U-Boot
>> boot >=4.15 kernels just fine. I could keep the 4.18 DTs in U-Boot, but
>> will loose all the new features and can't update anymore easily.
> 
> I see your point, and I can't offer any good solutions right now.
> 
> ChenYu
> 
>> I see that for the traditional embedded Linux use case this isn't an
>> issue, but I believe all those SBC boards are beyond that and users
>> want to boot of the shelf distros (installers) with them. Which they
>> can right now, but can't anymore with this new DT.
>>
>> Cheers,
>> Andre.
>>
>>>>
>>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
>>>> d3daf90a8715..8f2dad7e5d06 100644 ---
>>>> a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi +++
>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi @@ -197,7 +197,8 @@
>>>>                 };
>>>>
>>>>                 syscon: syscon at 1c00000 {
>>>> -                       compatible =
>>>> "allwinner,sun50i-a64-system-control";
>>>> +                       compatible =
>>>> "allwinner,sun50i-a64-system-control",
>>>> +                                    "syscon";
>>>>                         reg = <0x01c00000 0x1000>;
>>>>                         #address-cells = <1>;
>>>>                         #size-cells = <1>;
>>>> --
>>>> 2.17.1
>>>>
>>
