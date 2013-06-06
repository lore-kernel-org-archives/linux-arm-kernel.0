From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 6 Jun 2013 11:13:48 +0200
Subject: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
In-Reply-To: <20130606085039.GL23653@game.jcrosoft.org>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
 <51633F26.7000400@gmail.com> <51634835.5010302@collabora.co.uk>
 <20130605232647.55C8B3E10E4@localhost>
 <20130606085039.GL23653@game.jcrosoft.org>
Message-ID: <CABxcv==_37OxH1F=ELDMOL6Dni_x47emKHVnmMH8m2YWHgEZPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 10:50 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 00:26 Thu 06 Jun     , Grant Likely wrote:
>> On Tue, 09 Apr 2013 00:44:05 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
>> > On 04/09/2013 12:05 AM, Rob Herring wrote:
>> > > On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>> > >> This means that drivers that need the IRQ type/level flags defined in
>> > >> the DT won't be able to get it.
>> > >
>> > > But the interrupt controllers that need the information should be able
>> > > to get to it via irqd_get_trigger_type. What problem exactly are you
>> > > trying to fix? What driver would use this?
>> > >
>> >
>> > Yes but this is not about the interrupt controller wanting this information but
>> > a device driver that is using the IORESOURCE_IRQ struct resource that has the
>> > information about the virtual IRQ associated with a GPIO-IRQ.
>> >
>> > The driver doesn't know neither care if its IRQ line is connected to a line of
>> > an real IRQ controller or to a GPIO controller that allows a GPIO line to be
>> > used as an IRQ.
>> >
>> > > My understanding of the IORESOURCE_IRQ_xxx (and DMA) bits are they are
>> > > ISA specific and therefore should not be used on non-ISA buses.
>> > >
>> >
>> > Many TI OMAP2+ SoC based boards have an SMSC LAN911x/912x controller
>> > (drivers/net/ethernet/smsc/smsc911x.c) that is connected to the OMAP processor
>> > through its General-Purpose Memory Controller (GPMC) and this LAN driver obtain
>> > its IRQ and I/O address space from a struct resource IORESOURCE_IRQ and
>> > IORESOURCE_MEM respectively, that is filled by the DeviceTree core.
>> >
>> > It does this:
>> >
>> > irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> > irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
>> >
>> > Since of_irq_to_resource() doesn't fill the trigger/level flags on the
>> > IORESOURCE_IRQ struct resource, irq_flags will always be 0 regarding the value
>> > specified on the second cell of the "interrupts" DT property.
>
> why do you need to known this in you driver this need to be handle in the irq
> chip
>
> I does use irq gpio without at all
>
> Best Regards,
> J.
>

Yes, in fact as I said on an earlier email on this thread if you don't
pass a trigger type to the request_irq() call, it will use the trigger
type set by the irq chip earlier with .xlate.

A few months ago when I was testing DT on my OMAP3 board, for some
reasons it was not getting the right trigger type. That's why I sent
this patch but it seems it was a bug on the GPIO omap irq_chip driver
since now is working correctly without this. It is taking the trigger
type that was set on the .xlate function handler.

So, I don't need this patch anymore to make the LAN chip work on my
board and I don't know if the fact that an empty edge/level flags
means that is going to be used whatever was set on the .xlate function
handler is a reason enough to not return the IRQ flags on the struct
resource or if someone else is still interested on this patch and
filling this information on the struct resource.

Best regards,
Javier
