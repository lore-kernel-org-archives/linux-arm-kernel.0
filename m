From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 18 Oct 2010 15:43:37 +0200
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <20101018133502.GA12449@n2100.arm.linux.org.uk>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
Message-ID: <1287409417.29097.1598.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 14:35 +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 18, 2010 at 02:46:55PM +0200, Peter Zijlstra wrote:
> > On Mon, 2010-10-18 at 09:44 +0200, Ohad Ben-Cohen wrote:
> > > OMAP4 introduces a Spinlock hardware module, which provides hardware
> > > assistance for synchronization and mutual exclusion between heterogeneous
> > > processors and those not operating under a single, shared operating system
> > > (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP). 
> > 
> > I just have to ask... was it really easier to build silicon than to
> > agree on a spinlock ABI?
> 
> I'm not really sure what point you're trying to make, but if you're
> suggesting that Linux's spinlock should be exposed to these other
> processors, you're completely off your rocker.

Of course not, that would indeed be utterly silly, nor would it serve
any purpose, the Linux kernel spinlocks are internal spinlocks and need
not interact with anything out side of it.

But for the purpose of communicating with a heterogeneous CPU/DSP it
would make perfect sense to specify a spinlock ABI. Creating specific
hardware just to serialise between these components seems like overkill.

> In any case, Linux's spinlock API (or more accurately, the ARM exclusive
> access instructions) relies upon hardware coherency support (a piece of
> hardware called an exclusive monitor) which isn't present on the M3 nor
> DSP processors.  So there's no way to ensure that updates from the M3
> and DSP are atomic wrt the A9 updates.

Right, so the problem is that there simply is no way to do atomic memory
access from these auxiliary processing units wrt the main CPU? Seeing as
they operate on the same memory space, wouldn't it make sense to have
them cache-coherent and thus provide atomicy guarantees through that?

But that's water under the bridge, and your last paragraph does indeed
answer my question.
