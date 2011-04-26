From: avictor.za@gmail.com (Andrew Victor)
Date: Wed, 27 Apr 2011 00:04:53 +0200
Subject: [PATCH 03/14] at91: factorize at91 interrupts init to soc
In-Reply-To: <20110426172912.GA29103@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-3-git-send-email-plagnioj@jcrosoft.com>
	<0D753D10438DA54287A00B027084269764D256A077@AUSP01VMBX24.collaborationhost.net>
	<20110426172912.GA29103@game.jcrosoft.org>
Message-ID: <BANLkTimRb91DDB-LffjARrUdC5fxyzif9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

>> All the board files call at91_init_interrupts with a NULL priority. ?Why not just
>> remove the parameter entirely, make MACHINE_START.init_irq = at91_init_interrupts,
>> and then remove all the {board}_init_irq functions.

> keep it is important as the irq priority can be board specific as we have
> nearly no fifo on at91
> agreed to too have a a generic function

As of this patch:
  http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.35.y.git;a=commit;h=e58aa3d2d0cc01ad8d6f7f640a0670433f794922
interrupt priority / nesting were disabled in the core IRQ code.
So even though we configure the AT91's AIC controller for priority
levels, it won't as make much difference as before.  Only if you have
multiple pending interrupts, will the one with the highest priority be
serviced first.

Also, you might want to look into changing the AIC's handler from
handle_level_irq() to the handle_fasteoi_irq().
Then the irq_finish() can be removed from the low-level ARM
asm_do_IRQ() handler.


Regards,
  Andrew Victor
