From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 09:57:51 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA313710@IL-MB01.marvell.com>
References: <1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
	<20100517074329.GB23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA313710@IL-MB01.marvell.com>
Message-ID: <20100517085751.GD23118@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 11:29:53AM +0300, Ronen Shitrit wrote:
> On Mon, May 17, 2010 at 10:34:36AM +0300, Ronen Shitrit wrote:
> > I can only think of one problematic scenario:
> > - After 1 and before 2: 
> > 	CPU0 did spec prefetch for address x 
> > - After 2: 
> > 	CPU0 is doing inv: lock int, ldr x, 
> > 		str x (addr x is marked dirty with wrong data).
> 
> The data has been corrupted at this point; you don't need a second CPU.
>
> [Ronen Shitrit] Why? If the second CPU doesn't exist an invalidate will
> come just after the str inst and the wrong data will not get anywhere...
> (interrupts are locked so I assume no eviction...)

If a speculative prefetch occurs (eg, to prefetch the next ldr) it
could evict the dirty cache line that the str just wrote to.  Cache
replacement algorithms aren't always round-robin.

> 
> > 	CPU1 at this time doing spec prefetch for x which 
> > 		will snoop CPU0 and will cause data corruption... :(
> > 
> > I can assume that if I count on the Soc IO cache coherency support all
> > this isn't relevant, right? Or there are some issues hiding with v6 +
> > IO coherency?
> 
> What "IO cache coherency" ?  Are you saying that your SoC has a mode
> where the DMA controller can snoop the CPU caches?
> 
> [Ronen Shitrit] Yes. 

That suggests to me that your SoC manufacturer intended the system to run
with DMA coherency enabled - maybe to avoid these problems.

We have a macro in the kernel to avoid unnecessary cache handling as a
result of that - arch_is_coherent().  Maybe you should enable the hardware
DMA coherency and ensure arch_is_coherent() returns true for your SoC.
