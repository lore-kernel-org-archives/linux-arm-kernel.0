From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Apr 2012 13:39:41 +0300
Subject: [PATCH v9 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <CAFfN3gWCu5RnKb6dK4YMCAhpkfLncYdk1Cwqxb3wxMVznSiSFQ@mail.gmail.com>
References: <cover.1322479017a.git.n.voss@weinmann.de>
 <201203191534.q2JFYl1b012744@gatekeeper.vosshq.de>
 <CAFfN3gWCu5RnKb6dK4YMCAhpkfLncYdk1Cwqxb3wxMVznSiSFQ@mail.gmail.com>
Message-ID: <20120413103937.GH7154@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 13, 2012 at 12:17:59PM +0200, Hubert Feurstein wrote:
> Hi Niko,
> 
> I'm using this driver since a while a now in my system
> (soc:at91sam9m10; kernel:v3.2.14) and it works quite well. But
> occasionally it happens that wrong data is read from my devices. I've
> traced down the issue to the way how you do the interrupt handling. In
> your code you do not consider that both status-flags (TXCOMP and
> RXRDY) may be pending at the same time. So you handle the TXCOMP but
> NOT the RXRDY which will cause a data-loss on the current transfer. As
> a consequence also the next transfer will be corrupt, because you
> start with old data in RHR. So I would suggest the following changes:
> 
> static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> {
> 	struct at91_twi_dev *dev = dev_id;
> 	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
> 	unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
> 
> 	if (irqstatus & AT91_TWI_RXRDY) {
> 		at91_twi_read_next_byte(dev);
> 		irqstatus &= ~AT91_TWI_RXRDY;
> 	}
> 
> 	if (irqstatus & AT91_TWI_TXRDY) {
> 		at91_twi_write_next_byte(dev);
> 		irqstatus &= ~AT91_TWI_TXRDY;
> 	}
> 
> 	if (irqstatus & AT91_TWI_TXCOMP) {
> 		at91_disable_twi_interrupts(dev);
> 		dev->transfer_status = status;
> 		complete(&dev->cmd_complete);
> 		irqstatus &= ~AT91_TWI_TXCOMP;
> 	}
> 	
> 	if (irqstatus) {
> 		/* There should be no pending interrupt anymore. *)
> 		return IRQ_NONE;
> 	}

Dude, I remember asking the exact same thing when he first posted this
driver. That whole if...else if... else if ... else didn't look right.

Can you send this in patch format Hubert ? Take a look at
Documentation/SumittingPatches if you have never done it before.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/dabfb87a/attachment-0001.sig>
