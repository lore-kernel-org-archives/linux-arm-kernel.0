From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 29 Jul 2010 01:12:48 +0200
Subject: [PATCH 2/2] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTi=jStVGbJC7jUyhOG3og14F58rw+LEN2UqnP-X0@mail.gmail.com>
References: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=jStVGbJC7jUyhOG3og14F58rw+LEN2UqnP-X0@mail.gmail.com>
Message-ID: <AANLkTi=bkp+JJYQ7dF36Up3gcjJR8LypgfKBWZHLfPH-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/28 Dan Williams <dan.j.williams@intel.com>:
> On Tue, Jun 29, 2010 at 4:36 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> This creates a DMAengine driver for the ARM PL080/PL081 PrimeCells
>> based on the implementation earlier submitted by Peter Pearse.
>> This is working like a charm for memcpy and slave DMA to the PL011
>> PrimeCell on the PB11MPCore.
>
> Russell I am assuming this implementation and testing is sufficient to
> allay your prior nak [1]? ?Linus is oversubscribing virtual channels
> to physical channels to handle muxing.

I don't think Russell has ever NAK:ed the PL08x driver(s). The NAK
was about the PrimeCell DMA extenstions to amba-pl011.c etc.
(Still I'm happy if Russell looks at this thing of course.)

This patch along with the generic channel control removed the
cross-dependency between the PrimeCell DMA patchset and the
drivers/dma DMA engine framework (yay!) so there is no arch/arm
or AMBA stuff involved anymore, other than the fact that this driver
sits on the AMBA/PrimeCell bus.

>> +#ifdef MODULE
>> +
>> +# error "AMBA PL08X DMA CANNOT BE COMPILED AS A LOADABLE MODULE AT PRESENT"
>> +
>> +/*
>> + ? ? ? a) Some devices might make use of DMA during boot
>> + ? ? ? ? ?(esp true for DMAENGINE implementation)
>> + ? ? ? b) Memory allocation will need much more attention
>> + ? ? ? ? ?before load/unload can be supported
>> + */
>> +#endif
>
> This is taken care of by being "config bool", but I assume you want
> this for documentation purposes?

Peter had that in and I didn't remove it. If you don't like it you
can remove it or I can send a new patch.

>> + ? ? ? txd = kzalloc(sizeof(struct pl08x_txd), GFP_KERNEL);
>
> ...appears in the prep routines. ?Will this driver be used by any
> storage controllers on the platfom? ?Might we deadlock waiting on i/o
> that needs to allocate a descriptor to complete?

I haven't noticed anything but a descriptor pool is on my
list of things to look into and fix.

Yours,
Linus Walleij
