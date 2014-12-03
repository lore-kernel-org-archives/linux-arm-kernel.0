From: mpeg.blue@free.fr (Mason)
Date: Wed, 03 Dec 2014 18:47:46 +0100
Subject: Creating 16 MB super-sections for MMIO
In-Reply-To: <2452742.elcJohDinR@wuerfel>
References: <547D97A5.4090302@free.fr>
 <20141203103211.GB7373@e104818-lin.cambridge.arm.com>
 <547F1C11.5090408@free.fr> <2452742.elcJohDinR@wuerfel>
Message-ID: <547F4CC2.2090801@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 18:06, Arnd Bergmann wrote:

> Mason wrote:
>
>> As far as I could tell, Linux does not create a super-section in the
>> case outlined above. Perhaps I misread the source code?
>
> I believe you are right, and I also agree that in theory implementing
> what you say (both 64k and 16M mappings) can only help, but it's not
> obvious if this makes a measurable difference in the end.

It will be an interesting thought experiment to come up with
a relevant benchmark. TODO.

> MMIO register accesses are usually slow for other reasons, and
> they tend to be rare,

Reading e.g. the system tick counter on this SoC takes ~65 ns
(so ~65 cycles from the CPU's PoV) which is roughly twice as
fast as accessing uncached RAM.

I don't think we can say that MMIO registers accesses are slow
when they are faster than RAM, right?

> so it's possible that you won't be able
> to ever tell a difference because the MMIO TLB often gets evicted
> by user mappings between accesses to different 1MB sections,
> and the timing difference between a TLB-hot and cold MMIO access
> might not be that great (depending on the latency of a particular
> register).

I don't know if other SoCs are built differently, but on this one,
most drivers are hammering the same 16MB memory region where the
MMIO registers live. I don't think the entry would ever get evicted
if there's some kind of LRU-policy in action.

[Seems it might worthwhile to investigate TLB entry lockdown
(on Cortex A9) after all.]

> I don't think there would be any objections to doing superpage
> or supersection mappings for early page tables if you can show
> any benefit whatsoever, but it may be hard to come up with a
> scenario where it's actually measurable.

I'll have to think about it.

Thanks.
