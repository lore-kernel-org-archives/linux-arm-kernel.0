From: joravec@drewtech.com (Joey Oravec)
Date: Wed, 29 Jun 2011 16:01:22 -0400
Subject: plat-orion gpio regression for edge-sensitive on mv78xx0
Message-ID: <4E0B8492.2030201@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas, Lennert -

I just tested linux kernel 3.0-rc5 today. There were some major changes 
to arch/arm/plat-orion/gpio.c and I think they introduced a bug for edge 
sensitive interrupts. I have not tested any other types yet. This new 
version of the code specifies

ct->chip.irq_ack = irq_gc_ack;

But it looks like kernel/irq/generic-chip.c generates a positive mask (1 
to clear) and the MV78200 wants the opposite (0 to clear). The result is 
that the interrupt never gets ACKed and the handler will keep getting 
called.

-joey
