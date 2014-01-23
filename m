From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 24 Jan 2014 00:05:12 +0100
Subject: [PATCH 3/3] irqchip: orion: clear stale interrupts in irq_enable
In-Reply-To: <20140123225208.GA24778@obsidianresearch.com>
References: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390516686-2224-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140123225208.GA24778@obsidianresearch.com>
Message-ID: <52E1A028.6020309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2014 11:52 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2014 at 11:38:06PM +0100, Sebastian Hesselbarth wrote:
>> Bridge IRQ_CAUSE bits are asserted regardless of the corresponding bit in
>> IRQ_MASK register. To avoid interrupt events on stale irqs, we have to clear
>> them before unmask. This installs an .irq_enable callback to ensure stale
>> irqs are cleared before initial unmask.
>
> I'm not sure if putting this in irq_enable is correct. I think this
> should only happen at irq_startup.
>
> The question boils down to what is supposed to happen with this code
> sequence:
>
> disable_irq(..);
> write(.. something to cause an interrupt edge ..);
> .. synchronize ..
> enable_irq(..);
>
> Do we get the interrupt or not?

Jason,

I get the point and actually I'd chosen .irq_enable because using
.irq_startup didn't work. I rechecked this and now it works.. maybe
it is getting too late for me. I'll send a v2 of this patch shortly.

Sebastian

> I found this message from Linus long ago:
>   http://yarchive.net/comp/linux/edge_triggered_interrupts.html
>> Btw, the "disable_irq()/enable_irq()" subsystem has been written so that
>> when you disable an edge-triggered interrupt, and the edge happens while
>> the interrupt is disabled, we will re-play the interrupt at enable time.
>> Exactly so that drivers can have an easier time and don't have to
>> normally worry about whether something is edge or level-triggered.
>
> And found this note in Documentation/DocBook/genericirq.tmpl:
>
>> This prevents losing edge interrupts on hardware which does
>> not store an edge interrupt event while the interrupt is disabled at
>> the hardware level.
>
> So I think it is very clear that the chip driver should not discard
> edges that happened while the interrupt was disabled.
>
> Regards,
> Jason
>
