From: benoar@dolka.fr (Benjamin Cama)
Date: Thu, 18 Jun 2015 04:12:35 +0200
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem, not
 booting since 3.8
In-Reply-To: <1434446447.4785.7.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr>
Message-ID: <1434593555.13334.14.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again (feeling lonely),

I have got some news, I think I found the culprit.

Le mardi 16 juin 2015 ? 11:20 +0200, Benjamin Cama a ?crit :
> Le lundi 15 juin 2015 ? 15:51 +0200, Benjamin Cama a ?crit :
> > it didn't boot anymore at
> > all: no message at all displayed, not even with earlyprintk
> 
> Note that I tried the earlyprintk=serial,ttyS0,115200 with a working
> kernel as I do for the non-working ones, and it hangs at boot too, so
> this is no indication, sorry.

(Note for later: read the manual first, earlyprintk on this arch is for
a special tool to handle on the serial port on the host side. So it
looks like it hangs when running with it.)

> > I bisected
> > the faulty commit down to b8b499c86be58cb309964fcab5b62ac4a240a878 
> > ?ARM:
> > 7602/1: Pass real "__machine_arch_type" variable to 
> > setup_machine_tags()
> > procedure? which looks like a quite broad change, and makes me 1) 
> > not
> > really understand what it does 2) astonished not to see someone 
> > else
> > affected (judging by the time since it doesn't work).
> 
> I dug some more and found what changed: it simply passes the bootloader
> -provided machine ID instead of the kernel-configured one! This is
> quite a change indeed, which is not mentionned in the commit text. This
> may seem good for vendor-provided support which assigns IDs early with
> upstream, but for user one (like for this machine), the machine ID will
> in general be some ID that has nothing to do with the one passed by the
> bootloader. So this ought to be mentioned somewhere!

No comment on this? I continued with my hack which hardcodes the
machine ID, but has anyone some advice on how it should be done? Should
the behavior be reverted, or is there a clean way to force a machine ID
at build time?

> How I found this? Well, my bootloader passes a bad machine ID (526
> instead of 1858), and thus the code doesn't recognize it. What I cannot
> understand is why the decompressor doesn't even run with a wrong
> machine ID (MMU initialization that depend on it maybe??). This is very
> strange.

(that was because I enabled earlyprintk, which for some reason removes
messages from the decompressor? or maybe I mixed things up while
configuring the kernel)

> And also, I don't get why a more recent kernel with a hardcoded machine
> ID (personal modification) doesn't work either. Maybe I should bisect
> that too.

And I did it. And I stumbled upon commit
a71b092a9c68685a270ebdde7b5986ba8787e575 ?ARM: Convert handle_IRQ to
use __handle_domain_irq? (author Cc'ed). The new function
__handle_domain_irq (in kernel/irq/irqdesc.c, which comes just two
commits before, with 76ba59f8366f2d9282cb5bda9de75b4b68cbe55f) is
subtly different from the one it replaces, handle_IRQ, as it checks if
the irq is not 0 as well as checking for an upper bound. Removing the
check for 0 makes my machine work again! But honestly, I do not know if
a zero irq is legit, so I hope some more knowledgeable people will tell
me if this is OK.

-- >8 --
Subject: [PATCH] Make __handle_domain_irq accept IRQ 0

The same as handle_IRQ did before.

Signed-off-by: Benjamin Cama <benoar@dolka.fr>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a1782f8..bfbeeb6 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -365,7 +365,7 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
         * Some hardware gives randomly wrong interrupts.  Rather
         * than crashing, do something sensible.
         */
-       if (unlikely(!irq || irq >= nr_irqs)) {
+       if (unlikely(irq >= nr_irqs)) {
                ack_bad_irq(irq);
                ret = -EINVAL;
        } else {
-- 
2.1.4
