From: sf84@laposte.net (Sebastian Frias)
Date: Wed, 14 Sep 2016 10:32:19 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <20160913145126.GC23336@leverpostej>
References: <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
 <57D7CF17.2050905@laposte.net> <20160913131208.GA23336@leverpostej>
 <57D80B91.4020306@laposte.net> <20160913145126.GC23336@leverpostej>
Message-ID: <57D90B13.2020200@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/13/2016 04:51 PM, Mark Rutland wrote:
> Hi,
> 
> On Tue, Sep 13, 2016 at 04:22:09PM +0200, Sebastian Frias wrote:
>> On 09/13/2016 03:12 PM, Mark Rutland wrote:
> 
> [context was deleted, TL;DR: binding review is necessary, and takes
> effort, regardless of presence/absence of a driver]

Ok, I see you deleted the part where I was asking about the 'staging' folders.

$ find . -name 'stag*'
./Documentation/devicetree/bindings/staging
./drivers/staging
...

I don't know if that was intended (since you said you did not read it) but
I think it would be interesting for the discussion to give a little overview
on that.
My understanding is that there's a 'staging' area for bindings, couldn't the
nodes/properties from my example be put in there?

>>> Go and take a look at all the effort that went into sorting out generic
>>> IOMMU bindings, when driver support was written after a large amount of
>>> review to sort out fundamental concepts. We had to sort out fundamentals
>>> before prototype driver code could be written, and while we knew drivers
>>> were coming, an awful lot of review effort came first.
>>
>> Again, you are talking about drivers, but it is not the case at hand.
> 
> No, I am not. Please do not presume to put words in my mouth.

I'm sorry, that was not my intention.
I just assumed that because your paragraph mentioned the word "driver" and
appears to have been Linux-only effort geared towards writing drivers:
   "...We had to sort out fundamentals before prototype driver code could be
written, and while we knew drivers were coming..."

Maybe I miss some more context on that example.

> 
> I explicitly described a case where binding review took effort, and the
> presence or absence of drivers was irrelevant. We later had drivers,
> yes, but we had to understand the hardware to get the binding right
> first.

I see.
So if I understood correctly, it was a cleanup, or a way to unify some
bindings, so that drivers could be written easier?

I can see that taking time, but the underlying idea of this discussion is
that the DT could be divided in different sections.

I think this would allow and encourage SoC manufacturers to publish more
details, since they could use them internally as well.

Obviously, this is not strictly necessary, and I'm sure SoC manufacturers
could choose to just avoid having to deal with the open-source community
entirely by using forks.

However, that does not benefit the community and allows a "one-way" street,
with companies "profiting" from open-source software (in this example,
they would profit unwillingly, yet out of the necessity to avoid dealing
with outside 'restrictions' perceived as unnecessary).

It seems it is a similar case to that of allowing or not binary
drivers/blobs.
If they were not allowed, less companies would choose Linux.
I don't want to go into that discussion, but it seems similar enough to
this one for it to be worth mentioning.

> If there's data which has no consumer, it has no value being in the DT.
> Placing data with no consumer in the DT comes with a number of issues,
> e.g.
> 
> a) Some DTS authors will ignore it, and not place data according to it
>    in DTs. Hence there's no gain in consistency.

Ok, but in this case the DT author (SoC manufacturer) would have interest
in using it.

> 
> b) Though some accident (perhaps a typo, perhaps a misunderstanding of
>    the binding), a DT will come to have erroneous data, yet this will go
>    unnoticed, as there is no consumer. When later a consumer appears, it
>    can't trust existing DTs, and has to either ignore the binding
>    entirely, or bodge around each and every broken DT.
> 

I think it is likely this has already happened, even with the current
constraints on review.

> c) When a consumer eventually appears, it turned out we didn't capture
>    details of the hardware sufficiently, and the binding turns out to be
>    useless. At worst, this boils down to (b), at best, we require
>    additional properties. In this case absolutely nothing is gained.

Case c) could happen even when a driver is provided, for example if the
driver writer got incomplete documentation.

At any rate, since there was no user, even if the bindings need amending,
it should be easy to do, since there's no backwards compatibility to keep.

> In all cases, all we end up doing is enlarging DTBs, and risk causing
> even more work.
> 
> If there *is* going to be a consumer, and if information regarding that
> will be provided, then matters are different, and we can consider a
> binding on its own merit. We need a specific example for that.
> 
>> If the "user of the binding" is not Linux, under what circumstances
>> could "Linux" have the legitimacy of guaranteeing or enforcing any Linux-
>> specific commitment?
> 
> To at least the extent that if someone says they're not going to bother,
> we clearly have no reason to bother supporting them.

I have the impression that this basically means that DT is Linux only.
Did I misunderstood?

What legitimacy does Linux expects to have when dealing with bindings whose
users are not Linux? For example, FreeBSD, U-Boot or others.
In other words, why would Linux usage and policies regarding DT have to affect
other users of DT?

That essentially limits DT usage;
Of course, it can be forked, etc. like you state below, but that is not the
best outcome for everybody, because this basically forces the use of
undocumented binary DT overlays.

> Note that *nothing* stops you from using the DT container format for
> your own purposes, in violation of every binding and rule we have.
> However, for those cases we clearly won't document them as the standard
> mechanism.

Yes, I'm aware of that possibility, but in that case we would not be having
this conversation :-)

Basically, IMHO there is no reason for this thing to be black or white when
it could be gray and have a win-win situation, that's all.

> There are other things build atop of the DTB format, e.g. FIT, which
> aren't quite devicetree in the usual sense.
> 
>>> I understand that goal, and I've asked for a specific example, as this
>>> is not clear-cut. e.g. there has been work on describing secure devices
>>> for QEMU, but this isn't necessarily something we want to expose Linux
>>> to in general.
>>
>> Interesting, do you know where in QEMU's code should I look for that?
> 
> Documentation/devicetree/bindings/arm/secure.txt for the basics.
> 
> Generally, I'd expect that even if the secure OS were using DT in this
> fashion, the non-secure general purpose OS would be handed a DT
> containing only the non-secure world portions.
> 

I see that you did not comment on my example, was that intended?

>> IMHO, they apply only when there's a Linux driver, or any other public
>> user of such bindings. But if there's no user, it seems like an unnecessary
>> constraint.
> 
> If there's no user, there's no need for the binding.

But you said earlier that bindings for users different from Linux are considered.
Did I miss something?

> If there's some user somewhere, and that user wants the binding
> rubber-stamped as an "official" binding, they need to follow the usual
> rules for bindings.
> 
> If there is a user, and they don't want to follow the usual rules,
> there's no point trying to get the binding rubber-stamped.

I understand, but nothing prevents the creation of DT 'sections':
- a section using rubber-stamped "official" bindings
- a section using 'staging' bindings
right?
What technical issues would this have?

Best regards,

Sebastian
