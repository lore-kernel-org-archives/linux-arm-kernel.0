From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Nov 2011 17:40:05 +0200
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B38B899@wm021.weinmann.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <EF2E73589CA71846A15D0B2CDF79505D087B38B899@wm021.weinmann.com>
Message-ID: <20111108154004.GK20728@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 04:35:21PM +0100, Voss, Nikolaus wrote:
> Hi,
> 
> > > +#include <mach/at91_twi.h>
> > > +#include <mach/board.h>
> > > +#include <mach/cpu.h>
> > 
> > avoid including <mach/*> on drivers.
> 
> Should I move at91_twi.h to include/linux (omap does it like this,
> other use the mach-include)?

maybe, is at91_twi.h some sort of platform_data ? there's
<linux/platform_data/...> for that.

> > > +	if (irqstatus & AT91_TWI_TXCOMP) {
> > > +		at91_disable_twi_interrupts(dev);
> > > +		dev->transfer_status = status;
> > > +		complete(&dev->cmd_complete);
> > > +	}
> > > +	else if (irqstatus & AT91_TWI_RXRDY) {
> > > +		at91_twi_read_next_byte(dev);
> > > +	}
> > > +	else if (irqstatus & AT91_TWI_TXRDY) {
> > > +		at91_twi_write_next_byte(dev);
> > > +	}
> > > +	else {
> > > +		return IRQ_NONE;
> > 
> > coding style is wrong. Also, are those IRQ events really mutually exclusive ??
> 
> These are indeed mutually exclusive (semantically).

so you couldn't have AT91_TWI_TXCOMP and AT91_TWI_RXRDY set when you
read irqstatus ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/620b9204/attachment.sig>
