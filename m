From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 16 Jul 2015 17:29:02 +0200
Subject: [PATCH 2/2] at91: use request_irq/free_irq instead of
 setup_irq/remove_irq
In-Reply-To: <alpine.DEB.2.11.1507052341420.3916@nanos>
References: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
 <1435937609-18623-2-git-send-email-davidcdueck@googlemail.com>
 <alpine.DEB.2.11.1507052341420.3916@nanos>
Message-ID: <20150716152902.GN20482@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/07/2015 at 23:48:26 +0200, Thomas Gleixner wrote :
> On Fri, 3 Jul 2015, David Dueck wrote:
> 
> > This fixes a warning when using RT-Preempt.
> 
> That's not a proper explanation for the patch and by all means it
> cannot fix anything because free_irq() is just a different wrapper
> around __free_irq() than remove_irq(). So how on earth fixes that the
> problem at hand?
> 

Hum, that is quite simple, the following patch
http://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=227cd21851456fb08e87f5a35e0e51280a9fd439
bitrotted and should be rewritten completely or at least dropped.

For drivers/clocksource/timer-atmel-st.c, the patch is broken since at
least 3.18 as NR_IRQS_LEGACY + AT91_ID_SYS is 17 and the actual irq
allocated by irq_of_parse_and_map is 16.
Since 4.1, AT91_ID_SYS doesn't exist anymore and this is not compiling
at all.

For drivers/clocksource/timer-atmel-pit.c, struct irqaction
at91sam926x_pit_irq is never initialized but then it is used in
setup_irq()/remove_irq(). This basically ends up registering a null
handler for IRQ 0.

I'm preparing a replacement patch. I'd even say that this is probably
something we would want to mainline. Meanwhile, can you drop the
mentioned patch?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
