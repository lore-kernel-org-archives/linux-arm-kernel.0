From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 30 Aug 2016 10:33:19 +0200
Subject: [RFC PATCH 0/3] ARm64: amlogic: Introduce common GX family dtsi
In-Reply-To: <ca513cb4-34d4-72f9-9e32-7908329243a6@suse.de>
References: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
 <CAOQ7t2YGbASh7v25wgDspKNWgFOcRsikJs_WZptn+LkVXmaHig@mail.gmail.com>
 <2983d731-82fd-63fc-7541-8c1d6a929416@suse.de>
 <20160829195030.GA10797@localhost>
 <ca513cb4-34d4-72f9-9e32-7908329243a6@suse.de>
Message-ID: <58294020-4c10-5e77-7d0a-b81de4497962@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2016 10:15 PM, Andreas F?rber wrote:
> Am 29.08.2016 um 21:50 schrieb Carlo Caione:
>> On 29/08/16 20:38, Andreas F?rber wrote:
>>> Am 29.08.2016 um 10:01 schrieb Carlo Caione:
>>>> On Mon, Aug 29, 2016 at 9:56 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>> Neil Armstrong (3):
>>>>>   ARM64: dts: amlogic: Add Meson GX Family common dtsi
>>>>>   ARM64: dts: amlogic: Switch Meson GXL dtsi to use common GX dtsi
>>>>>   ARM64: dts: amlogic: Switch Meson GXBB dtsi to use common GX dtsi
>>>
>>> Adding an unused .dtsi duplicating GXBB makes me uneasy.
>>
>> S905x (GXL) is different from S905 (GXBB), it's unused now but in the
>> future we can expect something different in the two DTSI.
> 
> Guess I need to be --verbose. ;)
> 
> I meant: After patch 1/3 there is a gx-common.dtsi that duplicates
> contents of gxbb.dtsi and is not yet #include'd anywhere, i.e., unused.
> 
>>> Any chance we can simplify this to at most two steps?
>>> 1) Move code from gxbb to gx (1/3 + 3/3)
>>> 2) Add gxl using gx ("Add basic support for Amlogic S905X" + 2/3)
>>
>> fine by me.

I can merge carlo's GXL support into this patchet.

>>
>>> Alternatively:
>>> 1) "Add basic support for Amlogic S905X"
>>> 2) Factor out common bits (1/3 + 2/3 + 3/3)
>>
>> how is this different from this patchset?
> 
> I'm suggesting we do "atomic" move operations, not copy and then remove.
> 
> The difference between my two suggestions is how many and which changes
> we squash - I do appreciate that it's easy for review as is but what I
> have in mind is that either we should get this refactoring applied asap
> (#1 1)) and rebase all pending patches on it, or we may need to rebase
> the refactoring onto any pending MMC, SDIO, etc. patches, which I feel
> is safer to do in one big patch (#2 2)) than split over multiple ones.
> It really depends on the merge order and roadmap you guys have in mind.

I'm not very convinced about the utility the reduce commits... having a dtsi alone won't arm anyone.
Nevertheless, I will squash the two commits.

> 
>>> As for bike-shedding, is there a GX family as well or could we drop
>>> -common? .dtsi is always something common - compare Exynos or i.MX.
>>> Since there are meson8b and meson8 I was anticipating that after gxbb
>>> would come gx, not gxl.
>>
>> AFAIK we have:
>> - GXBB
>> - GXL
>> - GXM
>> - GXTVBB
>>
>>> Do you know what the L in GXL is for? Should we consider renaming gxbb
>>> to gxb, and then also insert -s905 as suggested by Kevin, for symmetry?
>>
>> Yes, that make sense.

As Amlogic told us, we have at least two families :
 - GXBB with the S905
 - GXL with the S905D and S905X

The GXL and GXBB families will share a lot, except the clocks tree, pinctrl registers, USB IP versions and at least ethernet PHY handling.

But the two GXL SoCs will still share a lot, maybe everything, we are not sure for now.

In the Amlogic SDK kernel, we can see more families :
 - GXM seems to be the S912 since it has two clusters of 4xA53, but looks identical to GXL for pinctrl and clocks
 - GXTVBB looking at the Amlogic SDK it could be a GXBB variant with a different GPU (t83x instead of mali450), pinctrl and clocks

In their SDK, there is a single GXL pinctrl and clock driver for GXL and GXM.

Taking in account all the boards, families and SoCs, we should have the following:
meson-gx-common.dtsi
??? meson-gxbb-s905.dtsi
?   ??? meson-gxbb-s905-odroidc2.dts
?   ??? meson-gxbb-s905-p20x.dtsi
?       ??? meson-gxbb-s905-p200.dts
?       ??? meson-gxbb-s905-p201.dts
??? meson-gxl.dtsi
?   ??? meson-gxl-s905d.dtsi
?   ?   ??? meson-gxl-s905d-p23x.dts
?   ?       ??? meson-gxl-s905d-p230.dts
?   ?       ??? meson-gxl-s905d-p231.dts
?   ??? meson-gxl-s905x.dtsi
?       ??? meson-gxl-s905x-p212.dts
??? meson-gxm-s912.dtsi
    ??? meson-gxm-s912-q20x.dtsi
        ??? meson-gxm-s912-q200.dts
        ??? meson-gxm-s912-q201.dts

But since GXBB will only be S905, we can drop the S905 naming and keep what is already upstream,
then GXM won't happen until a certain time so I plan to push the following :

meson-gx-common.dtsi
??? meson-gxbb.dtsi
?   ??? meson-gxbb-odroidc2.dts
?   ??? meson-gxbb-p20x.dtsi
?       ??? meson-gxbb-p200.dts
?       ??? meson-gxbb-p201.dts
??? meson-gxl.dtsi
    ??? meson-gxl-s905d.dtsi
    ?   ??? meson-gxl-s905d-p23x.dts
    ?       ??? meson-gxl-s905d-p230.dts
    ?       ??? meson-gxl-s905d-p231.dts
    ??? meson-gxl-s905x.dtsi
        ??? meson-gxl-s905x-p212.dts

But the meson-gxl-s905d.dtsi, meson-gxl-s905x.dtsi and meson-gxl.dtsi will be empty until we push the pinctrl, clock, ethernet PHY and USB nodes for them.

> 
> Hm, GXTVB would still be longer than GXL then, not much point then.
> We could still do -gxbb-s905 though.
> 
> Cheers,
> Andreas
> 

Thanks,
Neil
