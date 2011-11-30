From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Nov 2011 19:52:06 +0000
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <1322680072-14269-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20111130175847.GB6005@mbp-linux>
 <1322680072-14269-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAHkRjk4ZRCEZhrtazZO92+zoMRO1dYfghuSRNt5NmmmCR+Y_BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/30 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> The linker places the unwind tables in readonly sections. So when using
> an XIP kernel these are located in ROM and cannot be modified.
> For that reason the current approach to convert the relative offsets in
> the unwind index to absolute addresses early in the boot process doesn't
> work with XIP.
>
> The offsets in the unwind index section are signed 31 bit numbers and
> the structs are sorted by this offset. So it first has offsets between
> 0x40000000 and 0x7fffffff (i.e. the negative offsets) and then offsets
> between 0x00000000 and 0x3fffffff. When seperating these two blocks the
> numbers are sorted even when interpreting the offsets as unsigned longs.
>
> So determine the first non-negative entry once and track that using the
> new origin pointer. The actual bisection can then use a plain unsigned
> long comparison. The only thing that makes the new bisection more
> complicated is that the offsets are relative to their position in the
> index section, so the key to search needs to be adapted accordingly in
> each step.
>
> Moreover several consts are added to catch future writes and rename the
> member "addr" of struct unwind_idx to "addr_offset" to better match the
> new semantic. (This has the additional benefit of breaking eventual
> users at compile time to make them aware of the change.)
>
> In my tests the new algorithm was a tad faster than the original and has
> the additional upside of not needing the initial conversion and so saves
> some boot time and it's possible to unwind even earlier.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
