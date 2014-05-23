From: marc.ceeeee@gmail.com (Marc Carino)
Date: Thu, 22 May 2014 19:56:50 -0700
Subject: [PATCH] ARM: zImage: add DSB and ISB barriers after relocating
 code
In-Reply-To: <alpine.LFD.2.11.1405222155240.17310@knanqh.ubzr>
References: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
 <alpine.LFD.2.11.1405222155240.17310@knanqh.ubzr>
Message-ID: <537EB8F2.3090401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> Beware... This statement isn't true in most cases.

Ah, yes - I do have to reword that bit. (Per the booting document, the
I-cache can either be on or off upon entry, correct?)

> Are you sure of that?  When the MMU is off, memory access is strongly
> ordered.  I'm wondering if instruction prefetching applies in that
> case.

I'm unable to find a statement in the ARM architecture reference manual
(ARM ARM) supporting the need for the DSB, so upon second glance I think
I'll eliminate it.

Anyway, you are correct. While the MMU is off, data accesses are
assigned the strongly-ordered memory type. However for instruction
fetches, memory is assigned the Normal memory type (B3.2.1). Further,
the architecture allows for prefetching of instructions within the
current and subsequent 4K page from the currently-executing program
counter (B3.2.3).

Furthermore, I've encountered the "self-modifying code" example within
the ARM ARM, which implies that a pipeline flush is needed after
performing stores memory that is a part of the instruction stream.

Another interesting tidbit is that there id no specification of
coherency order between data and instructions for _any_ memory type
(A3.9.3). It is expected that the programmer to insert an ISB to ensure
instruction fetches are synced-up with the most-recent view of memory.

> Also, is this a problem that you actually experienced in practice?

Yes.

> Are you sure those CP15 accesses are fine on all the CPU variants
> that may execute this code?  Officially we still support back to
> ARMv4 implementations.

No. I suppose I would have to leverage a lookup table scheme as is done
with the cache maintenance operations in order for this patch to be
portable?

Thank you,
Marc
