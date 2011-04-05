From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2011 14:57:06 +0100
Subject: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
In-Reply-To: <20110405111257.GR13963@pengutronix.de>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
	<20110405075622.GB4699@n2100.arm.linux.org.uk>
	<20110405083144.GN13963@pengutronix.de>
	<20110405090100.GC4699@n2100.arm.linux.org.uk>
	<20110405111257.GR13963@pengutronix.de>
Message-ID: <20110405135706.GE4699@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 01:12:57PM +0200, Uwe Kleine-K?nig wrote:
> ah, ok, makes sense and actually is consistent with my book.
> (After knowing what I search I found it. The rules are:
> 
>  - A signed type of rank less than int
>    -> int
>  - An unsigned type of rank less than int,
>    all of whose values can be represented in type int
>    -> int
>  - An unsigned type of rank less than int,
>    all of whose values cannot be represented in type int
>    -> unsigned int
> ).
> 
> So the maximal correct variant is (u32)(int)~0U or alternatively
> (u32)(-1), right?

If you really want to be pedantic, (u32)~0UL, as we assume that longs
will always be equal or larger than 32-bit throughout the kernel.  The
u32 cast then becomes truncating in itself.

But... in the interests of avoiding churn, we know the current code
works, we know that its safe should we chose to change the function
argument to be a u64, so lets leave it as-is.  We know the only time
that it'd break is if an 'int' becomes less than 32-bit, which we
aren't going to see on ARM any time soon.
