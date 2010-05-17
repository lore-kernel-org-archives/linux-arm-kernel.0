From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 08:43:29 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
References: <20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
Message-ID: <20100517074329.GB23118@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 10:34:36AM +0300, Ronen Shitrit wrote:
> After some more thinking, I think I found the problem...
> 
> DMA for receive should operate as follows:
> 1) CPU will map (invalidate) the buffers for the DMA
> 2) DMA will place the buffers and ack the CPU
> 3) The CPU will call unmap which will invalidate the buffers again
> 
> 
> I can only think of one problematic scenario:
> - After 1 and before 2: 
> 	CPU0 did spec prefetch for address x 
> - After 2: 
> 	CPU0 is doing inv: lock int, ldr x, 
> 		str x (addr x is marked dirty with wrong data).

The data has been corrupted at this point; you don't need a second CPU.

> 	CPU1 at this time doing spec prefetch for x which 
> 		will snoop CPU0 and will cause data corruption... :(
> 
> I can assume that if I count on the Soc IO cache coherency support all
> this isn't relevant, right? Or there are some issues hiding with v6 +
> IO coherency?

What "IO cache coherency" ?  Are you saying that your SoC has a mode
where the DMA controller can snoop the CPU caches?
