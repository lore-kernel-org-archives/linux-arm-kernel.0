From: cdall@kernel.org (Christoffer Dall)
Date: Sun, 11 Mar 2018 01:51:56 +0000
Subject: [PATCH 1/2] KVM: arm/arm64: vgic: Don't populate multiple LRs
 with the same vintid
In-Reply-To: <86ina4av88.wl-marc.zyngier@arm.com>
References: <20180307124055.13800-1-marc.zyngier@arm.com>
 <20180307124055.13800-2-marc.zyngier@arm.com>
 <CAEDV+gJoamQJX_hcwCNBo1gc7-NUT+m-N9n=00wCJ=_TD82EkQ@mail.gmail.com>
 <8e873168-110f-6781-506c-4ca89b7a4e0d@arm.com> <20180308160242.GA1917@lvm>
 <86tvtqbis9.wl-marc.zyngier@arm.com> <86o9jybeef.wl-marc.zyngier@arm.com>
 <20180309213931.GE1917@lvm> <86ina4av88.wl-marc.zyngier@arm.com>
Message-ID: <CAEDV+gJsDtCSJrtWVe+sLUY=doH2X38ggfjswnurP3jDhqJ15A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2018 at 1:57 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Christoffer,
>
> On Fri, 09 Mar 2018 21:39:31 +0000,
> Christoffer Dall wrote:
>>
>> On Thu, Mar 08, 2018 at 06:39:20PM +0000, Marc Zyngier wrote:
>> > Thinking of it a bit more: MI on EOI doesn't offer much more guarantee
>> > in the way of priority ordering. Taking your example above: Even if
>> > you generate a MI when EOIing the SGI, there is no guarantee that
>> > you'll take the MI before you've acked the SPI.
>>
>> There's no guarantee, but at least you're attempting at processing the
>> SGIs in first.  It's the best we can do, but not completely correct,
>> kinda thing...
>>
>> >
>> > If you really want to offer that absolute guarantee that all the
>> > multi-source SGIs of higher priority are delivered before anything
>> > else, then you must make sure that only the SGIs are present in the
>> > LRs, excluding any other interrupt on lower priority until you've
>> > queued them all.
>>
>> Yes, that sucks!  Might not be too hard to implement, it's basically an
>> early out of the loop traversing the AP list, but just an annoying
>> complication.
>
> Yeah, it is a bit gross. The way I implemented it is by forcing the AP
> list to be sorted if there is any multi-SGI in the pipeline, and early
> out as soon as we see an interrupt of a lower priority than the first
> multi-SGI. That way, we only have an overhead in the case that
> combines multi-SGI and lower priority interrupts.
>

yes, that's what I had in mind as well.

>> > At that stage, I wonder if there is a point in doing anything at
>> > all. The GICv2 architecture is too rubbish for words.
>> >
>>
>> The case we do need to worry about is the guest processing all its
>> interrupts and not exiting while there is actually still an SGI pending.
>> At that point, we can either do it with the "no interrupts pending
>> maintenance interrupt" or with the "EOI maintenance interrupt", and I
>> think the latter at least gets us slightly closer to the architecture
>> for a non-virtualized system.
>
> I think that this is where we disagree.

I don't think we disagree, I must have expressed myself poorly...

> I don't see anything in the
> architecture that mandates that we should present the SGIs before
> anything else.

Neither do I.

> All we need to do is to ensure that interrupts of
> higher priority are presented before anything else.

Agreed.

> It is perfectly
> acceptable for an implementation to deliver SGI0, then SPI3, and SGI0
> (from another CPU) after that, as long as SPI3 isn't of lesser
> priority than SGI0.

Yes, but what we cannot do is let the guest deliver SGI0, then SPI3,
and then loop forever without delivering SGI0 from another CPU.
That's why I said "the guest processing all its interrupts and not
exiting while there is actually still an SGI pending" and said that we
could use either the EOI or the NPIE trick.

>
> Another thing I dislike about using EOI for that is forces us to
> propagate the knowledge of the multi-SGI horror further down the
> stack, down to both implementations of vgic_populate_lr. NPIE allows
> us to keep that knowledge local. But that's an orthogonal issue, and
> we can further argue/bikeshed about the respective merits of both
> solutions once we have something that fits the sorry state of the
> GICv2 architecture ;-).
>

Yeah, I don't care deeply.  If NPIE is prettier in the
implementations, let's do that.

Thanks,
-Christoffer
