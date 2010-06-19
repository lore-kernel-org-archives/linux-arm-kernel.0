From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 19 Jun 2010 02:25:09 +0100
Subject: [alsa-devel] [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
In-Reply-To: <20100618224313.GC30868@www.longlandclan.yi.org>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
	<1276858862.3054.28.camel@odin>
	<20100618113335.GB30868@www.longlandclan.yi.org>
	<20100618155322.GB16941@rakim.wolfsonmicro.main>
	<20100618224313.GC30868@www.longlandclan.yi.org>
Message-ID: <20100619012509.GD2463@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 19, 2010 at 08:43:14AM +1000, Stuart Longland wrote:

> I'll think about this over the next few days... but I'm thinking the
> basic structure of such a register cache would possibly take the form of
> something like this:
> 
> struct soc_reg_cache_pg {
> 	/* Page index; for single-page registers, this would be zero */
> 	int index;
> 	/* Number of registers cached */
> 	int size;
> 	/* Register offset cached */
> 	int offset;
> 	/* Pointer to register flags */
> 	const int *flags_data[];
> 	/* Pointer to default values */
> 	const int *default_data[];

This should probably be either unsigned or void (the latter allowing for
pluggable register sizes - otherwise you might burn as much data as you
save from the sparseness on chips that have small registers).

> ... then you'd use several of these in an array... one for each block of
> registers in a page.  If your device uses sparse registers, you can use
> the next_block pointer to point to the next such struct that has the
> next bank of registers, to save you scanning through *every* struct.

This is going to be painful to write out when writing the data table -
if it's useful to do it'd be better to do it at runtime, but I think
rather than handling pages it would be at least as easy to munge the
page number into the register number like everyone does at the minute
and then just optimise plain register lookups in a sparse map.  That way
way sparse chips of all kinds get the benefit.

> The register cache could be an array of pointers, size equal to the
> total number of pages, if a page is not used; it is set to NULL.  If a
> page is sparse, the other blocks would be accessed using the next_block
> pointer.

Like I say, I think optimising for page based access is not the most
general approach - it'd be better to optimise sparse register maps in
general and then map page based register maps onto this.
