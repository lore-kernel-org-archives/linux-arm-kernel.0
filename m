From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 3 Mar 2014 11:46:25 -0800
Subject: [PATCH RFC 0/3] clk: CCF clock primitives + custom IO accessors
In-Reply-To: <5314DA49.9060001@codeaurora.org>
References: <1393630495-29689-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140302202940.GQ3327@book.gsilab.sittig.org>
 <19206d89-cd0d-4fea-9170-3fd0a8482bf5@VA3EHSMHS045.ehs.local>
 <20140303190736.GU3327@book.gsilab.sittig.org>
 <87e0d582-77a2-4645-a52a-c303b7cd8b84@VA3EHSMHS007.ehs.local>
 <5314DA49.9060001@codeaurora.org>
Message-ID: <8d1a2e24-869d-4e77-aa73-d5c0ca36fe28@VA3EHSMHS011.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-03 at 11:38AM -0800, Stephen Boyd wrote:
> On 03/03/14 11:13, S?ren Brinkmann wrote:
> > On Mon, 2014-03-03 at 08:07PM +0100, Gerhard Sittig wrote:
> >> On Mon, Mar 03, 2014 at 09:35 -0800, S?ren Brinkmann wrote:
> >>> It would be nice if we could use the logic provided in the mux, div etc
> >>> primitives independently of how the HW is accessed and what is
> >>> necessary to shift and mask those register values around, right? I
> >>> mean, at then end we want to model a clk-(div|mux) and not a
> >>> clk-(div|mux) which has only a single, memory-mapped control register,
> >>> that does not overlap with other things, ...
> >> Did you lookup the ll_ops discussion in the thread that
> >> originated from
> >> http://article.gmane.org/gmane.linux.ports.arm.kernel/289895 and
> >> did you see the outlined logic in
> >> http://article.gmane.org/gmane.linux.ports.arm.omap/109233 and
> >> http://article.gmane.org/gmane.linux.ports.arm.omap/109381 ?
> >>
> >> Support for regmap access instead of mere MMIO was one of the
> >> things you could do with this approach.  You appear to be in the
> >> situation where you need such an extension (or something similar,
> >> but you really should look into the ll_ops thing).
> > Thanks for those pointer, I have some reading to do. That seems to
> > go into the right direction.  What is the status of those patches?
> > Are they already merged or actively worked on?
> >
> 
> Ugh. The ll_ops design is a simplified form of regmap. Why not just use
> regmap? It seems like it would be possible to make a regmap per
> clk_register_{basic_type}() call via regmap_init_mmio() while still
> allowing those functions to take a void __iomem pointer. Then we could
> remove clk_readl/clk_writel (after providing *_be variants of the
> registration functions for PPC) and just use a regmap throughout the
> basic clock type code. Finally we can introduce *_regmap() registration
> functions that allow drivers to register basic clock types with regmaps.

Migrating everything to regmap would be a good step, IMHO. That would
accommodate most of my concerns. One remains though: Especially the I2C
clocks may have parameters like dividers stored in more than one register
(in my particular case there is a 10-bit divider which - obviously -
spans across two device registers).
So, replacing a readl() with regmap_read() would not be enough for such
a clock. Would be nice if we could have a solution for such HW as well.

	S?ren
