From: robherring2@gmail.com (Rob Herring)
Date: Sun, 23 Aug 2015 18:42:23 -0500
Subject: [PATCH v5] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <CAOesGMj46mvbdya1OQnZzL8VrxVwxAV3KoZZRtk3c0CTVx7d5w@mail.gmail.com>
References: <1438618000-1091-1-git-send-email-ian.campbell@citrix.com>
 <1439287646.9747.212.camel@citrix.com>
 <CAL_JsqKv2aOEM-U7JNZnaHomA6HFBSFhSLZ-zhp7c20s6gQBaQ@mail.gmail.com>
 <CAOesGMj46mvbdya1OQnZzL8VrxVwxAV3KoZZRtk3c0CTVx7d5w@mail.gmail.com>
Message-ID: <CAL_Jsq+tUmRfvKE6vf+za6TsG_fhMWn5M2DDDLcCfkDt=KJGVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2015 at 6:13 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Aug 14, 2015 at 2:21 PM, Rob Herring <robherring2@gmail.com> wrote:
>> +arm-soc
>>
>> On Tue, Aug 11, 2015 at 5:07 AM, Ian Campbell <ian.campbell@citrix.com> wrote:
>>> On Mon, 2015-08-03 at 17:06 +0100, Ian Campbell wrote:
>>>> Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
>>>> LogicTile Express 20MG") added a new dts file to arch/arm64 which
>>>> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
>>>> .dtsi supplied by arch/arm.
>>>>
>>>> Unfortunately this causes some issues for the split device tree
>>>> repository[0], since things get moved around there. In that context
>>>> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
>>>> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
>>>
>>> Hi Grant,
>>>
>>> Do you think there is any chance of getting this into 4.2-rc$NEXT or shall
>>> we wait until 4.3? I'm assuming this should go via the DT tree, but maybe
>>> it should go via an ARM tree?
>>
>> I was assuming this would go thru the arm-soc tree which is why I
>> acked it. It is getting a bit late for 4.2 at this point, but I guess
>> the standalone tree remains broken for these platforms until this is
>> done. Probably not such a big deal in grand scheme of things.
>
> I'm cc:d in the far tail of a thread, so I'll just comment here
> instead of further up:
>
> I'm not a fan at all of creating kernel/dts/<arch>/*, at least if
> there's expected to be contents in there.
>
> We don't have include/linux/asm-<arch>/ in the common tree either.
> Let's not create that for dts.

I'd really like to move ALL dts files from arch/*. There's nothing
really tied to the architecture. They may happen to use some bindings
that only apply to an architecture, but fundamentally they don't
depend on the arch. Also, I'd like to be able to do "make all-dtbs"
and build every dtb in the tree.

That said, I'm not crazy enough to propose this re-org in the kernel
tree, but would like to do that if/when we moved dts files out of the
kernel.

> So, while I'm all for a prefix-based sharing of DTSI files, I don't
> want them to go in a common kernel/dts directory.
>
> Besides sharing some snippets between arm and arm64, what else is
> expected to need to go into such a shared location today?

Overlays. You easily have the same sharing of common boards. There are
also usecases of overlays on architectures that don't generally use DT
(x86).

We could also see sharing between PPC and ARM on FSL networking parts,
but I've not heard if they actually have that problem.

Rob
