From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Aug 2015 15:22:23 -0700
Subject: [PATCH v5] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <CAL_JsqKu6B1Q1q38GFSkdAT+Gxg3=87uk8ZOGPH96Eni0cer_g@mail.gmail.com>
References: <1438618000-1091-1-git-send-email-ian.campbell@citrix.com>
 <1439287646.9747.212.camel@citrix.com>
 <CAL_JsqKv2aOEM-U7JNZnaHomA6HFBSFhSLZ-zhp7c20s6gQBaQ@mail.gmail.com>
 <CAOesGMj46mvbdya1OQnZzL8VrxVwxAV3KoZZRtk3c0CTVx7d5w@mail.gmail.com>
 <CAL_Jsq+tUmRfvKE6vf+za6TsG_fhMWn5M2DDDLcCfkDt=KJGVg@mail.gmail.com>
 <CAOesGMigmaEviCDBAncomkq+uowr18B5FTOmOyBHsNz4p6F6Dw@mail.gmail.com>
 <CAL_JsqKu6B1Q1q38GFSkdAT+Gxg3=87uk8ZOGPH96Eni0cer_g@mail.gmail.com>
Message-ID: <CAOesGMhj50wg5WyByC7kHp3joo-ahfYWWDLLudp=kyKMpxauhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 24, 2015 at 1:58 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Sun, Aug 23, 2015 at 6:52 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Sun, Aug 23, 2015 at 4:42 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> On Sun, Aug 23, 2015 at 6:13 PM, Olof Johansson <olof@lixom.net> wrote:
>>>> On Fri, Aug 14, 2015 at 2:21 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>>> +arm-soc
>>>>>
>>>>> On Tue, Aug 11, 2015 at 5:07 AM, Ian Campbell <ian.campbell@citrix.com> wrote:
>>>>>> On Mon, 2015-08-03 at 17:06 +0100, Ian Campbell wrote:
>>>>>>> Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
>>>>>>> LogicTile Express 20MG") added a new dts file to arch/arm64 which
>>>>>>> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
>>>>>>> .dtsi supplied by arch/arm.
>>>>>>>
>>>>>>> Unfortunately this causes some issues for the split device tree
>>>>>>> repository[0], since things get moved around there. In that context
>>>>>>> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
>>>>>>> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
>>>>>>
>>>>>> Hi Grant,
>>>>>>
>>>>>> Do you think there is any chance of getting this into 4.2-rc$NEXT or shall
>>>>>> we wait until 4.3? I'm assuming this should go via the DT tree, but maybe
>>>>>> it should go via an ARM tree?
>>>>>
>>>>> I was assuming this would go thru the arm-soc tree which is why I
>>>>> acked it. It is getting a bit late for 4.2 at this point, but I guess
>>>>> the standalone tree remains broken for these platforms until this is
>>>>> done. Probably not such a big deal in grand scheme of things.
>>>>
>>>> I'm cc:d in the far tail of a thread, so I'll just comment here
>>>> instead of further up:
>>>>
>>>> I'm not a fan at all of creating kernel/dts/<arch>/*, at least if
>>>> there's expected to be contents in there.
>>>>
>>>> We don't have include/linux/asm-<arch>/ in the common tree either.
>>>> Let's not create that for dts.
>>>
>>> I'd really like to move ALL dts files from arch/*. There's nothing
>>> really tied to the architecture. They may happen to use some bindings
>>> that only apply to an architecture, but fundamentally they don't
>>> depend on the arch. Also, I'd like to be able to do "make all-dtbs"
>>> and build every dtb in the tree.
>>
>> The main benefit of keeping it per architecture and platform is that
>> it partitions the maintainer and review space a bit.
>
> Except we have a fire hose and a bunch of dripping faucets.
>
>> Right now it's not possible to do even per-arch "all-dtbs" since only
>> the currently configured platforms will get their dtbs compiled.
>
> I know. It's been on my todo list for a while. Having that per arch at
> least would be an improvement. Having it arch independent would mean I
> don't even need a cross-compiler (probably).

Yeah, seems like something that should work quite well in the scope of
Ian's tree if nothing else.

Maybe we should build both dtb-y and dtb-n when COMPILE_TEST is set? :)

>>> That said, I'm not crazy enough to propose this re-org in the kernel
>>> tree, but would like to do that if/when we moved dts files out of the
>>> kernel.
>>
>> I believe this is currently still quite firmly in the "if" stage. :(
>
> There's some renewed discussion around it recently, but still no one
> to step up and do it.

And I believe there are still major concerns from platform maintainers
that it will make development much more complicated.

>>>> So, while I'm all for a prefix-based sharing of DTSI files, I don't
>>>> want them to go in a common kernel/dts directory.
>>>>
>>>> Besides sharing some snippets between arm and arm64, what else is
>>>> expected to need to go into such a shared location today?
>>>
>>> Overlays. You easily have the same sharing of common boards. There are
>>> also usecases of overlays on architectures that don't generally use DT
>>> (x86).
>>
>> Ok, overlays might make sense if they can be made to work generically
>> enough and not be tied to expectations of the base board platform.
>
> That's the goal at least.
>
>> Still, even then I don't see dts as a core kernel feature (kernel/*),
>> lib/* might make more sense. And I don't want to see things like
>> vexpress stuff in there.
>
> How's it any different than vexpress board stuff under drivers/.

I'm not sure how to interpret this argument. We don't have vexpress
board stuff under kernel/boards/, so we shouldn't have the
corresponding DT contents under kernel/dts.

> The original suggestion was under include/dt-bindings/. Not sure if
> you saw or like that?

We don't store driver code in include/, so I don't see why we should
store machine descriptions there.

Something like lib/ seems more appropriate. Or drivers/..., but I
suspect that could cause further confusion on the expected separation
of binding/hardware description and the consuming drivers.

>>> We could also see sharing between PPC and ARM on FSL networking parts,
>>> but I've not heard if they actually have that problem.
>>
>> Yeah, there could potentially be some sharing between MIPS and
>> ARM{,64} too, but I don't know if we'll actually see it done.
>
> Yep, hard to say.
>
> Rob
