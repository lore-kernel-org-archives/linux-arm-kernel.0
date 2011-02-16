From: rabin@rab.in (Rabin Vincent)
Date: Wed, 16 Feb 2011 23:05:23 +0530
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <146267380211262372@unknownmsgid>
References: <1297697188-5206-1-git-send-email-will.deacon@arm.com>
	<AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
	<146267380211262372@unknownmsgid>
Message-ID: <AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding tglx)

On Wed, Feb 16, 2011 at 21:47, Will Deacon <will.deacon@arm.com> wrote:
>> >> Several of the platforms using the GIC also have GPIO code which uses
>> >> set_irq_chained_handler(). ?I think you will have to modify all of
>> >> these to call irq_eoi() appropriately and not the other functions.
>> >> Some of these will also likely be used with other interrupt handlers
>> >> than the GIC, though.
>> >
>> > Hmm, I had a quick look at some platforms that do this (mach-dove and
>> > plat-spear) and I don't see what the problem is. They use their own irq_chip
>> > structures, with their own function pointers, so this doesn't seem to relate
>> > to the GIC at all. What am I missing?!
>>
>> The chained handlers are usually installed on GIC interrupts. ?So, when
>> a chained handler does something like this
>>
>> ? ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>
>> the desc->irq_data.chip refers to the gic_chip. ?These handlers are
>> written with the knowledge of what flow handler the GIC uses and what
>> functions it implements, so when you change that, the chained handler
>> code will not work correctly, and they'll need to be updated just like
>> you've updated the cascade IRQ handler.
>
> Ah yes, thanks for the explanation. After looking at the plat-omap code
> I finally understand what's going on and I can't help but feel that the
> chained GPIO handlers are terminally broken! The generic irq chip high-level
> handlers (handle_{edge,level}_irq for example) at least check to see if
> the irq_chip functions are non-NULL before calling them.
>
> Ideally, the chained handler would be able to query the irq_chip to find
> out what types of IRQ flow-control it supports and then assume that behaviour.

Thomas, suggestions on how best to handle this?  (Some of these chained
handlers are the ones in plat-omap/gpio.c, plat-nomadik/gpio.c, and
mach-s5pv310/irq-combiner.c.)

>
>> In fact, I think that 846afbd1 ("GIC: Dont disable INT in ack callback")
>> has broken not just GIC cascading interrupts but assumptions in several
>> of these chained handlers, since several of them seem to have been
>> written assuming (invalidly) that irq_ack() masks the interrupt, but
>> this is no longer the case with the GIC after that commit.
>
> Yep - it was further reaching that I originally thought. The question now is:
> is it worth changing all of these handlers or are we better off hacking the gic
> code so that .irq_ack calls .irq_eoi? In the case of the latter, your performance
> will suck in a virtualised environment, but that's better than broken.
