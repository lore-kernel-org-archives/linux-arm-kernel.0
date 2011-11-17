From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Nov 2011 19:59:52 +0100
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <20111117141706.GI4748@arm.com>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
Message-ID: <20111117185952.GU30612@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 02:17:06PM +0000, Catalin Marinas wrote:
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
Yeah, I thought about the increased runtime, too and considered to only
fix it on CONFIG_XIP=y. Unfortunately as the addresses are relative to
their respective position in the idx section it's not trivial to just do
the inverse mapping on the address and compare that. But maybe it's
still cheaper to do it that way?

I will take a look and do some measurements when I have my more pressing
problems solved. For now I'm happy to have backtraces again.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
