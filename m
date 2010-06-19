From: john.ogness@linutronix.de (John Ogness)
Date: Sat, 19 Jun 2010 22:25:25 +0200
Subject: [PATCH 4/5] mtd: mxc_nand fixups
In-Reply-To: <20100618205401.GA12115@pengutronix.de> (Sascha Hauer's message
	of "Fri, 18 Jun 2010 22:54:01 +0200")
References: <804oh0b7gx.fsf@merkur.tec.linutronix.de>
	<20100618205401.GA12115@pengutronix.de>
Message-ID: <80sk4ivkga.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-06-18, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> This patch reverts the driver to enabling/disabling the NFC interrupt
>> mask rather than enabling/disabling the system interrupt. This cleans
>> up the driver so that it doesn't rely on interrupts being disabled
>> within the interrupt handler.
>
> This behaviour was introduced in
> a47bfd2eb66837653dc3b42541dfe4283dd41251 mxc_nand: support i.MX21
>
> I guess this won't work on i.MX21.

I just downloaded the i.MX21 reference manual and its NFC interrupts can
also be masked with INT_MASK (bit 4) of NFC_Flash_Config1 (0xdf003e1a).

IMHO we should revert the driver to masking the NFC interrupts. The
current linux-next version with nosync irq disabling within the
interrupt handler is a bit silly. Especially since the interrupt handler
does nothing except signal a wait queue.

John Ogness
