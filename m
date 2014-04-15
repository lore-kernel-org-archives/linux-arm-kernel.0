From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 15 Apr 2014 20:39:24 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <20140415175504.GG12304@sirena.org.uk>
References: <3748421.ND1tAjvgKS@typ> <2745802.Mh5myQIMrf@phil>
 <20140415175504.GG12304@sirena.org.uk>
Message-ID: <2863495.Gjdj6NpOm9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 15. April 2014, 18:55:04 schrieb Mark Brown:
> On Tue, Apr 15, 2014 at 07:25:28PM +0200, Heiko St?bner wrote:
> > Looking at the grf-handling of your i2c-driver [0] reminded me, that I'm
> > generally not sure how we should handle these registers. All of them use
> > what recently always got called a hiword-mask, with the upper 16 bit
> > indicating which lower 16 bit get changed.
> > 
> > So while the
> > 
> > 	regmap_write(grf, 4, BIT(11 + bus_idx) | BIT(27 + bus_idx));
> > 
> > will most likely get the desired result at least once, I'm not sure how
> > this interacts with the caching regmap implements [and regmap in
> > general], as the bit(27 + bus_idx) is not a real value bit and will
> > always read 0.
> 
> Can you be more specific what the wire format is here please?  The above
> sounds like you're saying that the register value contains 32 bits, the
> top 16 being essentially an extension of the register field and the last
> 16 bits being a value but that just sounds like 16+n bit registers and
> 16 bit data so presumably isn't what you mean.  Is there a datasheet
> somewhere?

ok, I'll try to explain better.

The register has 32 bit. The upper 16 bit [31:16] are a write enable mask, so 
to change bit x, you also have to set (x+16) to 1.

There is a manual floating around the net, for example linked on [0] (the first 
link to TRM v2.0) and in it for example on page 226 the GRF_SOC_CON2 register.

To cite the relevant bits 31:16:
	bit0~bit15 write enable
	When bit 16=1, bit 0 can be written by software .
	When bit 16=0, bit 0 cannot be written by software;
	When bit 17=1, bit 1 can be written by software .
	When bit 17=0, bit 1 cannot be written by software;
	...

And these "write enable" bits are reset to 0 after the write, so if you write 
0x30001 you will get something like 0x1 on the next read, without the mask.


Thanks
Heiko


[0] http://hwswbits.blogspot.nl/2013/06/full-rk3066-technical-reference-manual.html
