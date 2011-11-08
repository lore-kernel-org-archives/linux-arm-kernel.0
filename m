From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Nov 2011 20:06:49 +0200
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B38B8B5@wm021.weinmann.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <EF2E73589CA71846A15D0B2CDF79505D087B38B899@wm021.weinmann.com>
 <20111108154004.GK20728@legolas.emea.dhcp.ti.com>
 <EF2E73589CA71846A15D0B2CDF79505D087B38B8B5@wm021.weinmann.com>
Message-ID: <20111108180648.GA24399@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2011 at 04:49:07PM +0100, Voss, Nikolaus wrote:
> > > > > +#include <mach/at91_twi.h>
> > > > > +#include <mach/board.h>
> > > > > +#include <mach/cpu.h>
> > > >
> > > > avoid including <mach/*> on drivers.
> > >
> > > Should I move at91_twi.h to include/linux (omap does it like this,
> > > other use the mach-include)?
> > 
> > maybe, is at91_twi.h some sort of platform_data ? there's
> > <linux/platform_data/...> for that.
> 
> It contains hardware register definitions, not really platform data.
> So linux/i2c-at91.h (like linux/i2c-{omap,pxe,...}) would be the right place?

if it's only register definitions, does it need to be in a header ? I
mean, is anyone outside of this driver trying to access those registers?
Otherwise they could sit on the C source file itself.

If there's anyone else which needs those register definitions then
<linux/i2c/at91.h> seems like a good place (??)

> > > > > +	if (irqstatus & AT91_TWI_TXCOMP) {
> > > > > +		at91_disable_twi_interrupts(dev);
> > > > > +		dev->transfer_status = status;
> > > > > +		complete(&dev->cmd_complete);
> > > > > +	}
> > > > > +	else if (irqstatus & AT91_TWI_RXRDY) {
> > > > > +		at91_twi_read_next_byte(dev);
> > > > > +	}
> > > > > +	else if (irqstatus & AT91_TWI_TXRDY) {
> > > > > +		at91_twi_write_next_byte(dev);
> > > > > +	}
> > > > > +	else {
> > > > > +		return IRQ_NONE;
> > > >
> > > > coding style is wrong. Also, are those IRQ events really mutually
> > exclusive ??
> > >
> > > These are indeed mutually exclusive (semantically).
> > 
> > so you couldn't have AT91_TWI_TXCOMP and AT91_TWI_RXRDY set when you read
> > irqstatus ?
> 
> Yes, I do have this, but in this constellation only TXCOMP is relevant and
> all other flags can be ignored (because the transfer is finished).

I asked about different directions exactly because of that. My question
was if you could have a TX Complete and RX Ready IRQs simultaneously.

The way you coded this IRQ handler is like a priority encoder, meaning
that you will ignore all other bits once you find the first set bit. I'm
wondering if you shouldn't drop the "else" as most of the IRQ handlers
do.

But it's your driver anyway, I don't know how this controller behaves.
Just found it a bit worrying that you ignore all other IRQ status bits.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/49980e10/attachment.sig>
