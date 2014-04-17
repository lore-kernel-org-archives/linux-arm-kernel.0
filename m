From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Apr 2014 15:27:36 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <5059282.MitP6iZ8n1@typ>
References: <3748421.ND1tAjvgKS@typ> <20140415185025.GH12304@sirena.org.uk>
 <5059282.MitP6iZ8n1@typ>
Message-ID: <1917043.Q4CxE5T68K@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. April 2014, 02:04:20 schrieb Max Schwarz:
> On Tuesday 15 April 2014 at 19:50:25, Mark Brown wrote:
> > Perhaps I'm missing something about why this is helpful but it does seem
> > like the hardware designers have good drugs here.
> 
> I assume that the point is to avoid read/write cycles for bit-level
> set/clear. You can do a "change bit X, leave everything else intact" in a
> single write without reading the previous value, be it from the register
> itself or from some cache.
> 
> > For non-volatile registers this should work fine if the write enable
> > bits are just latched on at probe time, we'll never actually look at the
> > what the hardware reads back once things are in cache.  For ones that
> > are volatile we'll need to teach the framework about it...  a write
> > enable mask setting that we splat into the value perhaps?
> 
> The regmap is not volatile at the moment, but it should probably be. We
> don't have documentation on the registers (or do you know more, Heiko?), so
> we can't be sure how the bits we don't know about behave.

>From a cursory glance through the register docs, only GRF_SOC_STATUS0, 
GRF_SOC_STATUS1 and GRF_DDRC_STAT seem to be volatile, but they are also not 
writeable at all. All others look like they only receive settings, but do not 
contain volatile information.

Apart from GRF_SOC_STATUS1 (whose only entry gpu-idle-state is simply 
contained in DDRC_STAT on the rk3066), the shared GRF registers are very much 
alike between rk3188 and the leaked rk3066 trm.


> I see three possible solutions to our problem:
> 
> 1) Ideally, regmap_update_bits(map, reg, mask, val) & co would directly boil
> down to a single register write of (mask << 16) | val, even for volatile
> registers. That's a rather big change to regmap though, isn't it?
> 
> 2) A smaller change would be to always use 0xFFFF as the write enable mask
>    while writing. That would mean that write accesses to volatile registers
>    would always need a read access before to determine the previous value,
>    though.
> 
> 3) Make the GRF/syscon device give direct register access to the drivers
> (i.e. passing a pointer to the mapped registers) and bypass regmap
> entirely.
> 
>    That would make sense to me because we are AFAIK not using any of
> regmap's features here:
> 
>    * Caching is not that useful because a) we are only doing a few init-time
> accesses and b) the write-mask provides similar functionality. * The bus
> for register access is always going to be MMIO.
>    * All the drivers using the GRF are rockchip-specific and can know about
>      the write-mask thing.
> 
> From the outcome, I would prefer (1). From the complexity, (3). Thoughts?

I don't think I like (3) :-) . So far we've seen Rockchip and Hisilicon use 
this "hiword-mask" scheme on at least some of their registers. Enabling syscon 
to also share the raw mapped registers might encourage abuse of it slipping 
in, on platforms which need the concurrency handling regmap provides.

For (2), regmap already does the necessary read in _update_bits ... either 
from its cache or from the register itself for volatile ones. So in our case, 
we'd simply fall back to use the register like a regular one.

Interestingly, when looking through the regmap_config struct, it already 
contains the "write_flag_mask", described as "Mask to be set in the top byte of 
the register when doing  a write.", which sounds a lot like what we need, only 
that it's two bytes for us instead of the current one.


So I guess the easiest way would be to make write_flag_mask somehow usable for 
us, because it looks like regmap will handle the rest on its own already.

And then teach syscon to set this flag and about volatile registers in general, 
because it doesn't seem to handle them yet.


Heiko
