From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Sun, 20 Jun 2010 11:09:03 +0200
Subject: [PATCH 4/5] mtd: mxc_nand fixups
In-Reply-To: <80sk4ivkga.fsf@merkur.tec.linutronix.de>
References: <804oh0b7gx.fsf@merkur.tec.linutronix.de>
	<20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
Message-ID: <AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 19, 2010 at 10:25 PM, John Ogness <john.ogness@linutronix.de>wrote:

> On 2010-06-18, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> This patch reverts the driver to enabling/disabling the NFC interrupt
> >> mask rather than enabling/disabling the system interrupt. This cleans
> >> up the driver so that it doesn't rely on interrupts being disabled
> >> within the interrupt handler.
> >
> > This behaviour was introduced in
> > a47bfd2eb66837653dc3b42541dfe4283dd41251 mxc_nand: support i.MX21
> >
> > I guess this won't work on i.MX21.
>
> I just downloaded the i.MX21 reference manual and its NFC interrupts can
> also be masked with INT_MASK (bit 4) of NFC_Flash_Config1 (0xdf003e1a).
>
> IMHO we should revert the driver to masking the NFC interrupts. The
> current linux-next version with nosync irq disabling within the
> interrupt handler is a bit silly. Especially since the interrupt handler
> does nothing except signal a wait queue.
>
> John Ogness
>

Yes, on i.MX21, NFC interrupts can be masked using NFC_CONFIG1:NFC_INT_MSK.
But I observed that as long as NFC_INT_MSK is set, NFC_CONFIG2:NFC_INT will
always read out 0 on i.MX21, even if the operation is completed.

So the driver will remain stuck at:

                       wait_event(host->irq_waitq,
                               readw(host->regs + NFC_CONFIG2) & NFC_INT);

This behavior is not documented by Freescale (Freescale's (linux 2.4) i.MX21
reference kernel avoid this by always using polling).

Ivo.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100620/e966fefd/attachment.html>
