From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Apr 2015 13:45:50 +0200
Subject: [PATCH v4 04/10] eeprom: Add a simple EEPROM framework for
 eeprom consumers
In-Reply-To: <20150409144522.GB9663@codeaurora.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427752670-17219-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150407184533.GA10278@codeaurora.org>
 <55243982.7020907@linaro.org>
 <20150409144522.GB9663@codeaurora.org>
Message-ID: <20150410114550.GR26727@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Apr 09, 2015 at 07:45:22AM -0700, Stephen Boyd wrote:
> > eeprom block array is just another way intended to get hold of
> > eeprom content for non-DT providers/consumers, but DT
> > consumers/providers can also use it. As of today SOC/mach level code
> > could use it as well.
> > 
> > In eeprom_cell_get() case the lookup of provider is done based on
> > provider name, this provider name is generally supplied by all the
> > providers (both DT/non DT).
> > 
> > for example in qfprom case,
> > provider is registered from DT with eeprom config containing a unique name:
> > static struct eeprom_config econfig = {
> > 	.name = "qfprom",
> > 	.id = 0,
> > };
> > 
> > In the consumer case, the tsens driver could do some like in non DT way:
> > 
> > 	struct eeprom_block blocks[4] ={
> > 		{
> > 		.offset = 0x404,
> > 		.count = 0x4,
> > 		},
> > 		{
> > 		.offset = 0x408,
> > 		.count = 0x4,
> > 		},
> > 		{
> > 		.offset = 0x40c,
> > 		.count = 0x4,
> > 		},
> > 		{
> > 		.offset = 0x410,
> > 		.count = 0x4,
> > 		},
> > 	};
> > 	calib_cell = eeprom_cell_get("qfprom0", blocks, 4);
> > 
> > 
> > Or in DT way
> > calib_cell  = of_eeprom_cell_get(np, "calib");
> > 
> 
> Ok. I guess I was hoping for a more device centric approach like
> we have for clks/regulators/etc. That way a driver doesn't need
> to know it's using DT or not to figure out which API to call.
> Also the global namespace is sort of worrying (qfprom0 part). How
> do we know it's qfprom0? What if it's qfprom1 sometimes?

Through platform_data?

Or maybe that could be done using a function that would attach a cell
to a struct device?

I'm not sure that would cover all cases though.

> Also, how are we supposed to encode certain bits inside the
> stream of bytes (blocks)? In some situations (e.g. the qcom CPR
> stuff) we have quite a few fuse bits we need to read that are
> packed into different bytes and may cross byte boundaries (i.e.
> bits 6 to 10 of a 32-bit word). The current API looks to be byte
> focused when I have bit based/non-byte aligned data.
> 
> My current feeling is that I don't want to use any of the block
> stuff at all. I just want a simple byte-based API that allows me
> to read a number of contiguous bytes from the fuses. Then I'll
> need to shift that data down by a few bits and mask it with the
> width of the data I want to read to extract the data needed.

Except that this is highly dependent on the usage you're making of
this API.

It could be fine to expect that if your writing machine code, that for
one given SoC will always be true.

If you're writing driver code, that will just have to lookup one value
from an EEPROM, the exact offset, size and device being completely
board dependant, it's not really practical.

> The only thing after that where I have a problem is figuring out
> which eeprom is present in the consumer driver.

Is that really necessary? I mean, the point of having an abstraction
layer is precisely to *not* care about the provider when you are the
consumer.

If we can't, then the abstraction layer is not good enough and we
should improve it, but we shouldn't need to hack around it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/8616215d/attachment.sig>
