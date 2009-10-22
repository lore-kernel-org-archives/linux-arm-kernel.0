From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 22 Oct 2009 19:33:49 +0200
Subject: soc_common and irq handling
Message-ID: <ba4215e10910221033u2874e955v23e6df5462c21743@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

am currently working on pcmcia/cf support for freescale mxc.

I started from the Freescale MX31 code (although my hardware is MX21 -
its quite similar and I hope to make a generic driver).

The Freescale code basically includes a (slightly modified) private
copy of soc_common. I am attempting to clean this up...

The current in tree users of soc_common (sa11xx and pxa2xx) use
seperate irqs for card status events and card interrupts, they request
the card status interrupts with soc_pcmcia_request_irqs() and just
define the irq for the card interrupt (via skt->irq) and let the
client driver request the interrupt later.

However the mxc SoCs only have a single interrupt for all this so if I
use soc_pcmcia_request_irqs() it is requested in non shared mode and
the client driver gets  EBUSY when it tries to request the same
interrupt.

My current solution to this is:

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index de25eb8..8ba3167 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c

@@ -528,7 +528,8 @@ int soc_pcmcia_request_irqs(struct soc_pcmcia_socket *skt,
               if (irqs[i].sock != skt->nr)
                       continue;
               res = request_irq(irqs[i].irq, soc_common_pcmcia_interrupt,
-                                 IRQF_DISABLED, irqs[i].str, skt);
+                                 IRQF_DISABLED | irqs[i].flags,
+                                 irqs[i].str, skt);
               if (res)
                       break;
               set_irq_type(irqs[i].irq, IRQ_TYPE_NONE);

diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index e2d837b..9076003 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -126,6 +126,7 @@ struct pcmcia_irqs {
       int sock;
       int irq;
       const char *str;
+       unsigned long flags;
 };



Ie add a flags field and let the driver request IRQF_SHARED.

Is this reasonable / acceptable?

Unfortunately this gives the the runtime warning (from kernel/irq/manage.c)
 IRQ 28/pcmcia0: IRQF_DISABLED is not guaranteed on shared IRQs

Is there a better solution for this case? - I can't think of one
seeing as the client driver will be doing a request_irq() and the host
controller needs the same irq.

Cheers,

Martin
