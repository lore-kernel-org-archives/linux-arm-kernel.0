From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 21 Feb 2018 08:10:37 -0600
Subject: [SPAM]Re: [PATCH v3 4/5] dt-bindings: clock: mediatek: update
 audsys documentation to adapt MFD device
In-Reply-To: <1519193048.18794.42.camel@mtkswgap22>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
 <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
 <CAL_JsqJgo0pKJjrs2fdw+q=DJYwht0X5L3Bomz8gf98mEN7hkg@mail.gmail.com>
 <1519193048.18794.42.camel@mtkswgap22>
Message-ID: <CAL_JsqLjcMpS=bLzAV0arLJY143O1XefjSR0djM73E8uC4oJHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 12:04 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Mon, 2018-02-19 at 12:29 -0600, Rob Herring wrote:
>> On Mon, Feb 12, 2018 at 5:28 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> > The MediaTek audio hardware block that exposes functionalities that are
>> > handled by separate subsystems in the kernel.  These functions are all
>> > mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
>> > up with other functions within the same registers.
>>
>> I still don't think this change is necessary.
>>
>> Just because a hardware block in DT maps to different subsystems in a
>> particular OS doesn't mean you need a DT node for each OS subsystem.
>> What we have subsystems for changes over time and DT shouldn't really
>> be changing based on that. And DT is not the only way to instantiate
>> drivers.
>>
>
> Apart right now we have the definition of both functions. The other
> location is here:../sonud/mt2701-afe-pcm.txt. The ways I could come up
> with are:

There are several problems you need to fix. First,
"mediatek,mt2701-audsys" is not documented. It is only used in the
example. Second, bindings/arm/mediatek/mediatek,audsys.txt should move
to bindings/sound/ if it is only audio related functions. Or perhaps
just combine the 2 documents because it is all inconsistent currently.

The 2 documents are inconsistent as to what is the relationship of
-audsys and -audio (afe) nodes. mt2701-afe-pcm.txt shows that the AFE
is already a child of -audsys. The -audsys node should have
#clock-cells. It should also not be a simple-mfd (another
inconsistency in the binding) because it needs to probe first to
provide clocks to child nodes, and then trigger probing the child
nodes.

Rob

>
> 1. Add a dummy MFD driver (need to think a new compatible or just use
> '*-audsys' which has already been picked by clock driver) to instantiate
> two sub-devices through id_table and mfd_cell.
>
> 2. For the sake of simplification - add a new compatible "simple-mfd".
>
> 3. The last thing - keep two nodes separated/independent. (x)
>
> I'm not sure which one is better.
>
>
>
> @Lee @Matthias: What do you suggest?
>
> Ryder.
>
>
