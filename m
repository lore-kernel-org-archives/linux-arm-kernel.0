From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Nov 2011 14:17:06 +0000
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111117141706.GI4748@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
> The linker places the unwind tables in readonly sections. So when using
> an XIP kernel these are located in ROM and cannot be modified.
> 
> For that reason don't convert the symbol addresses during boot (or
> module loading) but only when interpreting them in search_index().
> Moreover several consts are added to catch future writes and rename the
> member "addr" of struct unwind_idx to "addr_offset" to better match the
> new semantic.
> 
> This fixes unwinding on XIP which compared prel31 offsets to absolute
> addresses because the initial conversion from prel31 to absolute failed.

My only worry - does this increase the index search by doing the prel31
conversion every time? It could affect tools like lockdep that need to
get the backtrace regularly at run-time.

-- 
Catalin
