From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 22:02:38 +0000
Subject: Locking in the clk API
In-Reply-To: <alpine.LFD.2.00.1101211618170.8580@xanadu.home>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
	<4D3907BD.4040900@codeaurora.org>
	<AANLkTik53zyXytvuAd5zK0_zExfQT3FmOgTr8BexmGeT@mail.gmail.com>
	<alpine.LFD.2.00.1101211618170.8580@xanadu.home>
Message-ID: <20110121220238.GE23151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 04:53:44PM -0500, Nicolas Pitre wrote:
> So I think that the API must be augmented with more methods, such as:
> 
> clk_slow_enable():
>   - may sleep
>   - may be a no-op if the clk_fast_enable() is supported
> 
> clk_fast_enable():
>   - may not sleep, used in atomic context
>   - may be a no-op if controlling the clock takes time, in which case 
>     clk_slow_enable() must have set the clock up entirely
> 
> ... and similar for clk_slow_disable() and clk_fast_disable().

Isn't this along the same lines as my clk_prepare() vs clk_enable()
suggestion?

I suggested that clk_prepare() be callable only from non-atomic contexts,
and do whatever's required to ensure that the clock is available.  That
may end up enabling the clock as a result.

clk_enable() callable from atomic contexts, and turns the clock on if
the hardware supports such an operation.

So, if you have something like:

Xtal--->PLL--->Routing/Masking--->Device

clk = clk_get() returns the clock for the device.

clk_prepare(clk) would walk up the clock tree, selecting the routing and
preparing each clock.  Clocks prior to _and_ including the PLL would need
to be enabled.

clk_enable(clk) would walk up the tree if the clock isn't already enabled,
calling clk_enable() on the parent clock.  As we require prepared clocks
to already be enabled, this automatically stops at the PLL.

To encourage correct usage, we just need to make sure that clk_prepare()
has a might_sleep() thing, and clk_enable() throws a fit if it's used
on a clk without prepare being used first.  The second point is not easy
to do in a foolproof manner though, but doing _something_ is better than
nothing.
