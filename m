From: carlo@caione.org (Carlo Caione)
Date: Wed, 5 Mar 2014 12:52:07 +0100
Subject: [PATCH] Revert "irqchip: irq-dove: Add PMU interrupt controller."
In-Reply-To: <20140305004139.GT21483@n2100.arm.linux.org.uk>
References: <20140304030838.GA1872@titan.lakedaemon.net>
 <1393911160-7688-1-git-send-email-jason@lakedaemon.net>
 <20140305004139.GT21483@n2100.arm.linux.org.uk>
Message-ID: <CAOQ7t2bWx+ogSDiqQBabxD2BsbePnFfUSpAVVWFThix=m4dhrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 1:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 04, 2014 at 05:32:40AM +0000, Jason Cooper wrote:
>
> Jason, Thomas,
>
> I've just been giving the above a whirl here with the RTC, and it
> doesn't seem to quite work as it should.  Not your problem, because it's
> as the code is originally.
>
> Let's say you set an alarm for 10sec time.  When the alarm fires:
>
> - we read the PMU interrupt status, mask it with the mask register,
>   and find the RTC pending.
> - we call the genirq layer for this interrupt.
> - genirq does the mask + ack thing.
> - the RTC interrupt handler is called, and there's the RTC says there's
>   an interrupt pending.
> - the RTC handler clears the interrupt, and returns.
> - genirq unmasks the interrupt, and returns.
> - dove_pmu_irq_handler() is re-entered, and again, we find that the
>   RTC interrupt is pending.
> - follow the above...
> - the RTC interrupt handler is called, but this time there's no interrupt
>   pending, so returns IRQ_NONE
> - genirq unmasks the interrupt, and returns.
>
> The reason this happens is that the attempt to "ack" - rather "clear" the
> interrupt the first time around has no effect - the RTC is still asserting
> the interrupt, so the write to clear the register results in the bit
> remaining set.
>
> The second time around, we've already cleared the RTC interrupt, so this
> time, the ack clears the interrupt down properly.
>
> In some ways, this is good news - it shows that the bits in this register
> latch '1' when an interrupt is pending, and remain '1' while the block
> continues to assert its interrupt signal - but can we say that the other
> interrupt functions in this register have that behaviour?

I don't know if this could help but I have a very similar problem with
the NMI controller found on sun6i/sun7i for which is pending the
patchset http://comments.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7554

Also in that case the first ACK has no effect and in the end I use the
unmask hook in the irqchip driver to ACK again the line before
unmasking it (the whole discussion about this problem among me, Maxime
and Hans is in this thread
http://www.spinics.net/lists/arm-kernel/msg299952.html )

I also proposed a small (and as it turned out incomplete) patch here
http://www.spinics.net/lists/arm-kernel/msg305616.html but in the end
I preferred to use the unmask hook.

-- 
Carlo Caione
