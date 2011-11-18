From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Nov 2011 13:28:14 -0500 (EST)
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <20111117141706.GI4748@arm.com>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
Message-ID: <alpine.LFD.2.02.1111181321390.13989@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Nov 2011, Catalin Marinas wrote:

> On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
> > The linker places the unwind tables in readonly sections. So when using
> > an XIP kernel these are located in ROM and cannot be modified.
> > 
> > For that reason don't convert the symbol addresses during boot (or
> > module loading) but only when interpreting them in search_index().
> > Moreover several consts are added to catch future writes and rename the
> > member "addr" of struct unwind_idx to "addr_offset" to better match the
> > new semantic.
> > 
> > This fixes unwinding on XIP which compared prel31 offsets to absolute
> > addresses because the initial conversion from prel31 to absolute failed.
> 
> My only worry - does this increase the index search by doing the prel31
> conversion every time? It could affect tools like lockdep that need to
> get the backtrace regularly at run-time.

We're talking about two constant shifts and an add.  something that 
myght take around 2 cycles on ARM.  Hardly noticeable I would say, 
especially given that lockdep is already quite costly and hardly 
something you want to keep around in production anyway.

On the plus side, this fixes the XIP case, and allow for backtrace to be 
usable pretty early without any explicit initialization.

As far as I'm concerned (which isn't much as this is not my code):

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
