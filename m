From: simon@sequanux.org (Simon Guinot)
Date: Thu, 30 Jun 2011 09:52:23 +0000
Subject: plat-orion gpio regression for edge-sensitive on mv78xx0
In-Reply-To: <4E0B8492.2030201@drewtech.com>
References: <4E0B8492.2030201@drewtech.com>
Message-ID: <20110630095223.GH31228@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 29, 2011 at 04:01:22PM -0400, Joey Oravec wrote:
> Nicolas, Lennert -
> 
> I just tested linux kernel 3.0-rc5 today. There were some major
> changes to arch/arm/plat-orion/gpio.c and I think they introduced a
> bug for edge sensitive interrupts. I have not tested any other types
> yet. This new version of the code specifies

As level interrupts don't need to be acked, it should be ok.

> 
> ct->chip.irq_ack = irq_gc_ack;
> 
> But it looks like kernel/irq/generic-chip.c generates a positive
> mask (1 to clear) and the MV78200 wants the opposite (0 to clear).
> The result is that the interrupt never gets ACKed and the handler
> will keep getting called.

Maybe we could introduce some irq_gc_ack{_set_bit,_clear_bit}
variants (as for the mask functions) ?

As an another option, we could define an Orion specific irq_ack
function.

I don't know what is the better choice for rc5.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110630/b77176e8/attachment.sig>
