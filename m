From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 28 May 2013 07:16:14 -0700
Subject: [PATCH v3 7/7] ARM: KVM: drop use of PAGE_S2_DEVICE
In-Reply-To: <51A482CE.1090509@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
 <1368529900-22572-8-git-send-email-marc.zyngier@arm.com>
 <CAEDV+gJeeQUOOLjFpkvoPk7e=csjmvvefhdp1miiWtosABwW6Q@mail.gmail.com>
 <51A482CE.1090509@arm.com>
Message-ID: <CAEDV+gJSM4EpGNV=fN+i6s2K9z6taMzmuNjVf_KyvTUvPaZAwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 3:11 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 27/05/13 21:01, Christoffer Dall wrote:
>> On Tue, May 14, 2013 at 4:11 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> At the moment, when mapping a device into Stage-2 for a guest,
>>> we override whatever the guest uses by forcing a device memory
>>> type in Stage-2.
>>>
>>> While this is not exactly wrong, this isn't really the "spirit" of
>>> the architecture. The hardware shouldn't have to cope for a broken
>>> guest mapping to a device as normal memory.
>>>
>>
>> So I'm trying to think of a scenario where this feature in the
>> architecture would actually be useful, and it sounds like from you
>> guys that it's only useful to properly run a broken guest.
>>
>> Are we 100% sure that a malicious guest can't leverage this to break
>> isolation? I'm thinking something along the lines of writing to a
>> device (for example the gic virtual cpu interface) with a cached
>> mapping. If such a write is in fact written back to cache, and not
>> evicted from the cache before a later time, where a different VM is
>> running, can't that adversely affect the other VM?
>>
>> Probably this can never happen, but I wasn't able to convince myself
>> of this from going through the ARM ARM...?
>
> I think you definitely have a point here, and I completely missed that
> case. A shared device (like the GIC virtual CPU interface) must be
> forced to a device memory type, otherwise we cannot ensure strict
> isolation of guests.
>
> I'll drop this patch from my series and add PAGE_S2_DEVICE back to the
> arm64 port.
>
We still need to get rid of the USER bit in the definition, and since
that's a purely arch/arm/* patch I assume it should go through RMK's
tree. Will you ack the other patch?

Thanks,
-Christoffer
