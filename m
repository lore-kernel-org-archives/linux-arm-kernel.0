From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 28 Feb 2018 09:13:21 -0600
Subject: [SPAM]Re: [PATCH v3 4/5] dt-bindings: clock: mediatek: update
 audsys documentation to adapt MFD device
In-Reply-To: <1519272878.1907.87.camel@mtkswgap22>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
 <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
 <CAL_JsqJgo0pKJjrs2fdw+q=DJYwht0X5L3Bomz8gf98mEN7hkg@mail.gmail.com>
 <1519193048.18794.42.camel@mtkswgap22>
 <CAL_JsqLjcMpS=bLzAV0arLJY143O1XefjSR0djM73E8uC4oJHg@mail.gmail.com>
 <1519272878.1907.87.camel@mtkswgap22>
Message-ID: <CAL_Jsq+NK-sUY-qOZ2Xv1ZfWVm-vG0tyAgN_auKeaQxMq58vkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 10:14 PM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Wed, 2018-02-21 at 08:10 -0600, Rob Herring wrote:
>> On Wed, Feb 21, 2018 at 12:04 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> > On Mon, 2018-02-19 at 12:29 -0600, Rob Herring wrote:
>> >> On Mon, Feb 12, 2018 at 5:28 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> >> > The MediaTek audio hardware block that exposes functionalities that are
>> >> > handled by separate subsystems in the kernel.  These functions are all
>> >> > mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
>> >> > up with other functions within the same registers.
>> >>
>> >> I still don't think this change is necessary.
>> >>
>> >> Just because a hardware block in DT maps to different subsystems in a
>> >> particular OS doesn't mean you need a DT node for each OS subsystem.
>> >> What we have subsystems for changes over time and DT shouldn't really
>> >> be changing based on that. And DT is not the only way to instantiate
>> >> drivers.
>> >>
>> >
>> > Apart right now we have the definition of both functions. The other
>> > location is here:../sonud/mt2701-afe-pcm.txt. The ways I could come up
>> > with are:
>>
>> There are several problems you need to fix. First,
>> "mediatek,mt2701-audsys" is not documented. It is only used in the
>> example. Second, bindings/arm/mediatek/mediatek,audsys.txt should move
>> to bindings/sound/ if it is only audio related functions. Or perhaps
>> just combine the 2 documents because it is all inconsistent currently.
>
> Because the series crossed subsystems but didn't apply at the same time.
>
>> The 2 documents are inconsistent as to what is the relationship of
>> -audsys and -audio (afe) nodes. mt2701-afe-pcm.txt shows that the AFE
>> is already a child of -audsys. The -audsys node should have
>> #clock-cells. It should also not be a simple-mfd (another
>> inconsistency in the binding) because it needs to probe first to
>> provide clocks to child nodes, and then trigger probing the child
>> nodes.
>
> This is the 1st version I sent before, and the clock parts still under
> review :( .  But yes, the 2 inconsistent documents should be fixed -
> this may depend on what we end up doing with the DT appearance.
>
> IMHO, apart from overlapping regions with other functions I didn't see
> any difference between audsys and other clock drivers (providers).
>
> For the sake of uniformity, I make the 2 sub-devices parallel and move
> "simple-mfd" to the top, and the sequences should actually be handled
> through "probe deferral mechanism" - that would make this kind of
> situations much easier to manage.

If a child node has a dependency on the parent, probe deferral is not
the correct solution. The parent should probe first and control
probing of the chlidren. "simple-mfd" is intended for cases where
there is no dependency on the parent node.

> BTW, I could make the AFE driver be instantiated/probed from the clock
> driver but this seems superfluous to me.  Just make sure is this what
> you want?

I would think it would be the other way around. The AFE driver creates
some clocks. Whether that's a separate driver or a single driver is a
kernel issue that has nothing to do with the binding. IIRC, there's
several examples in display controllers and camera interfaces where
those drivers are also clock providers.

Rob
