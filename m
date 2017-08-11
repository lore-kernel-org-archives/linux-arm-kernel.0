From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 10:19:50 +0200
Subject: simple-reset to de-duplicate reset drivers
In-Reply-To: <f7918041-49ac-e878-d402-fae953d50035@adaptrum.com>
References: <f7918041-49ac-e878-d402-fae953d50035@adaptrum.com>
Message-ID: <1502439590.2310.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandru,

On Thu, 2017-08-10 at 17:16 -0700, Alexandru Gagniuc wrote:
> Hi,
> 
> I was looking at implementing a reset driver for our in-house SoC.
> It's?
> essentially a long bitfield, each bit controlling one sort of reset.?
> That seems to be surprisingly common. I've identified the following?
> drivers which control a very similar reset:
> 
> * reset-zynq
> * reset-zx2967
> * reset-sunxi
> * reset-stm32
> * reset-socfpga
> * reset-oxynas
> * reset-meson
> * reset-berlin

I think zx2967, sunxi, stm32, and socfpga could be unified using common
ops.

zynq, oxnas, and berlin are special because they use regmap to access
shared syscon register space, or have special delays, or both. meson is
different because the resets are self-clearing. It doesn't implement
assert/deassert at all.

> All of these have in common some form of another of:
> 
> 	int bank = id / BITS_PER_LONG;
> 	int offset = id % BITS_PER_LONG;
> 
> It doesn't make sense to me why all these would be duplicated for every?
> reset controller. I think it would make sense to have a common driver to?
> handle these simple resets -- call it "simple-reset". I'm thinking of?
> something similar to drivers/tty/serial/8250, where the following?
> parameters can be specified:
> 
> - reg-offset
> - reg-shift
> - reg-io-width

Drivers have to keep working with the existing, documented bindings, so
we can't introduce new required device tree properties for them. That
being said, adding optional properties with documented defaults that
fit the current drivers should be possible.

> I think a generic "simple-reset" driver which is configurable by a?
> similar set of parameters would be a suitable replacement for all the?
> aforementioned drivers. As far as our SoC goes, I've just added
> 
> 	compatible = "st,stm32-rcc";
> 
> to our devicetree, and I already have a fully-working reset driver. Do?
> you think we should proceed in the direction of "simple-reset", and what?
> other features do you estimate we'll need?

Another difference between the simple reset controllers is whether the
bits are set to assert or cleared to assert.

Even without touching device trees, we can share the backend code by
providing common ops to use for all compatible drivers, and we could
also merge them into a single driver that determines the parameters
from the compatible string.

What do you think about this previous attempt to unify sunxi, stm32,
and socfpga:

https://patchwork.kernel.org/patch/9610709/

regards
Philipp
