From: alex.g@adaptrum.com (Alexandru Gagniuc)
Date: Thu, 10 Aug 2017 17:16:12 -0700
Subject: simple-reset to de-duplicate reset drivers
Message-ID: <f7918041-49ac-e878-d402-fae953d50035@adaptrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was looking at implementing a reset driver for our in-house SoC. It's 
essentially a long bitfield, each bit controlling one sort of reset. 
That seems to be surprisingly common. I've identified the following 
drivers which control a very similar reset:

* reset-zynq
* reset-zx2967
* reset-sunxi
* reset-stm32
* reset-socfpga
* reset-oxynas
* reset-meson
* reset-berlin

All of these have in common some form of another of:

	int bank = id / BITS_PER_LONG;
	int offset = id % BITS_PER_LONG;

It doesn't make sense to me why all these would be duplicated for every 
reset controller. I think it would make sense to have a common driver to 
handle these simple resets -- call it "simple-reset". I'm thinking of 
something similar to drivers/tty/serial/8250, where the following 
parameters can be specified:

- reg-offset
- reg-shift
- reg-io-width

I think a generic "simple-reset" driver which is configurable by a 
similar set of parameters would be a suitable replacement for all the 
aforementioned drivers. As far as our SoC goes, I've just added

	compatible = "st,stm32-rcc";

to our devicetree, and I already have a fully-working reset driver. Do 
you think we should proceed in the direction of "simple-reset", and what 
other features do you estimate we'll need?

Alex
