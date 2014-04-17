From: max.schwarz@online.de (Max Schwarz)
Date: Thu, 17 Apr 2014 02:04:20 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <20140415185025.GH12304@sirena.org.uk>
References: <3748421.ND1tAjvgKS@typ> <2863495.Gjdj6NpOm9@phil>
 <20140415185025.GH12304@sirena.org.uk>
Message-ID: <5059282.MitP6iZ8n1@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 at 19:50:25, Mark Brown wrote:

> Perhaps I'm missing something about why this is helpful but it does seem
> like the hardware designers have good drugs here.

I assume that the point is to avoid read/write cycles for bit-level set/clear.
You can do a "change bit X, leave everything else intact" in a single write 
without reading the previous value, be it from the register itself or from 
some cache.

> For non-volatile registers this should work fine if the write enable
> bits are just latched on at probe time, we'll never actually look at the
> what the hardware reads back once things are in cache.  For ones that
> are volatile we'll need to teach the framework about it...  a write
> enable mask setting that we splat into the value perhaps?

The regmap is not volatile at the moment, but it should probably be. We don't 
have documentation on the registers (or do you know more, Heiko?), so we can't 
be sure how the bits we don't know about behave.

I see three possible solutions to our problem:

1) Ideally, regmap_update_bits(map, reg, mask, val) & co would directly boil 
   down to a single register write of (mask << 16) | val, even for volatile  
   registers. That's a rather big change to regmap though, isn't it?

2) A smaller change would be to always use 0xFFFF as the write enable mask 
   while writing. That would mean that write accesses to volatile registers 
   would always need a read access before to determine the previous value, 
   though.

3) Make the GRF/syscon device give direct register access to the drivers (i.e. 
   passing a pointer to the mapped registers) and bypass regmap entirely.

   That would make sense to me because we are AFAIK not using any of regmap's   
   features here:

   * Caching is not that useful because a) we are only doing a few init-time
     accesses and b) the write-mask provides similar functionality.
   * The bus for register access is always going to be MMIO.
   * All the drivers using the GRF are rockchip-specific and can know about 
     the write-mask thing.

>From the outcome, I would prefer (1). From the complexity, (3). Thoughts?

Cheers,
  Max
