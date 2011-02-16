From: rabin@rab.in (Rabin Vincent)
Date: Wed, 16 Feb 2011 19:35:29 +0530
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <-4413647205110644369@unknownmsgid>
References: <1297697188-5206-1-git-send-email-will.deacon@arm.com>
	<AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
Message-ID: <AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 18:39, Will Deacon <will.deacon@arm.com> wrote:
>> On Mon, Feb 14, 2011 at 20:56, Will Deacon <will.deacon@arm.com> wrote:
>> > This patch modifies the GIC code to use handle_fasteoi_irq for handling
>> > interrupts, which only requires us to signal EOI to the CPU interface
>> > when handling is complete. Cascaded IRQ handling is also updated so that
>> > EOI is signalled after handling.
>>
>> Several of the platforms using the GIC also have GPIO code which uses
>> set_irq_chained_handler(). ?I think you will have to modify all of
>> these to call irq_eoi() appropriately and not the other functions.
>> Some of these will also likely be used with other interrupt handlers
>> than the GIC, though.
>
> Hmm, I had a quick look at some platforms that do this (mach-dove and
> plat-spear) and I don't see what the problem is. They use their own irq_chip
> structures, with their own function pointers, so this doesn't seem to relate
> to the GIC at all. What am I missing?!

The chained handlers are usually installed on GIC interrupts.  So, when
a chained handler does something like this

	desc->irq_data.chip->irq_unmask(&desc->irq_data);

the desc->irq_data.chip refers to the gic_chip.  These handlers are
written with the knowledge of what flow handler the GIC uses and what
functions it implements, so when you change that, the chained handler
code will not work correctly, and they'll need to be updated just like
you've updated the cascade IRQ handler.

In fact, I think that 846afbd1 ("GIC: Dont disable INT in ack callback")
has broken not just GIC cascading interrupts but assumptions in several
of these chained handlers, since several of them seem to have been
written assuming (invalidly) that irq_ack() masks the interrupt, but
this is no longer the case with the GIC after that commit.
