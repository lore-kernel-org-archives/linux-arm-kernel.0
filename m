From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Apr 2014 19:38:35 +0100
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <5059282.MitP6iZ8n1@typ>
References: <3748421.ND1tAjvgKS@typ> <2863495.Gjdj6NpOm9@phil>
 <20140415185025.GH12304@sirena.org.uk> <5059282.MitP6iZ8n1@typ>
Message-ID: <20140417183835.GG12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 02:04:20AM +0200, Max Schwarz wrote:
> On Tuesday 15 April 2014 at 19:50:25, Mark Brown wrote:

> > Perhaps I'm missing something about why this is helpful but it does seem
> > like the hardware designers have good drugs here.

> I assume that the point is to avoid read/write cycles for bit-level set/clear.
> You can do a "change bit X, leave everything else intact" in a single write 
> without reading the previous value, be it from the register itself or from 
> some cache.

I suppose...

> 1) Ideally, regmap_update_bits(map, reg, mask, val) & co would directly boil 
>    down to a single register write of (mask << 16) | val, even for volatile  
>    registers. That's a rather big change to regmap though, isn't it?

Fairly, yes, and it's a very specialised case which would still need to
take care of the cache.

> 2) A smaller change would be to always use 0xFFFF as the write enable mask 
>    while writing. That would mean that write accesses to volatile registers 
>    would always need a read access before to determine the previous value, 
>    though.

That's no different to any other device, though.

> 3) Make the GRF/syscon device give direct register access to the drivers (i.e. 
>    passing a pointer to the mapped registers) and bypass regmap entirely.
>    That would make sense to me because we are AFAIK not using any of regmap's   
>    features here:
> 
>    * Caching is not that useful because a) we are only doing a few init-time
>      accesses and b) the write-mask provides similar functionality.
>    * The bus for register access is always going to be MMIO.
>    * All the drivers using the GRF are rockchip-specific and can know about 
>      the write-mask thing.

> From the outcome, I would prefer (1). From the complexity, (3). Thoughts?

If you're only doing a few accesses then surely there's no meaningful
overhead from just writing what you want?  So long as you don't cache
these registers regmap won't really get in the way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140417/5c97c7b2/attachment.sig>
