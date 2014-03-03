From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 3 Mar 2014 09:35:43 -0800
Subject: [PATCH RFC 0/3] clk: CCF clock primitives + custom IO accessors
In-Reply-To: <20140302202940.GQ3327@book.gsilab.sittig.org>
References: <1393630495-29689-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140302202940.GQ3327@book.gsilab.sittig.org>
Message-ID: <19206d89-cd0d-4fea-9170-3fd0a8482bf5@VA3EHSMHS045.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-03-02 at 09:29PM +0100, Gerhard Sittig wrote:
> On Fri, Feb 28, 2014 at 15:34 -0800, Soren Brinkmann wrote:
> > 
> > [ MMIO registers assumed for clock control modules, but I2C
> > communication may be involved in other hardware, individual for
> > a (set of) clock(s) and not for an architecture or platform ]
> > 
> > Does anybody have a good idea how we could avoid all this code
> > duplication while enabling usage of the clock primitives with different
> > IO accessors?
> > Especially the divider and mux primitive have a lot of code that would
> > be painful to maintain twice.
> 
> Hasn't past discussion already reached the point where code
> duplication of the clock control logic was considered
> undesirable, and "low level ops" were outlined?  I.e. extending
> the compile time decision for a specific clk_{read,write}l()
> implementation by another potential redirection that is specific
> to a clock item?
> 
> Re-submitting a series which duplicates complete clock types,
> while the difference is only in how registers get accessed, is
> quite saddening.
I'm not really planning to submit this as is. I'm hoping to get some
input on how to resolve this properly. I know this is a big mess, but I
also don't see the way out (yet).

> 
> 
> > In the next step, I encountered a divider clock whose divider is stored
> > in 2 I2C registers. So now, the simple IO access replacement doesn't
> > work anymore either since this clock needs 2 registers to be read and
> > then shifting around the bitfields accordingly.
> 
> Are the registers adjacent and contain only bit fields for one
> clock?  Or do registers share parameters for several clocks, or
> are not adjacent?
> 
> In the former case you may use a table from "divider value" to
> "bit pattern to read/write".  In the latter case, the clock
> control module is rather special, and may not be easily get
> mapped to the common primitives.  Unless the ll_ops can implement
> the required special handling.
It would be nice if we could use the logic provided in the mux, div etc
primitives independently of how the HW is accessed and what is
necessary to shift and mask those register values around, right? I
mean, at then end we want to model a clk-(div|mux) and not a
clk-(div|mux) which has only a single, memory-mapped control register,
that does not overlap with other things, ...

	S?ren
