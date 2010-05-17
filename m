From: rshitrit@marvell.com (Ronen Shitrit)
Date: Mon, 17 May 2010 10:34:36 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6
	DMA cache ops
In-Reply-To: <20100517065712.GA23118@n2100.arm.linux.org.uk>
References: <309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
Message-ID: <309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After some more thinking, I think I found the problem...

DMA for receive should operate as follows:
1) CPU will map (invalidate) the buffers for the DMA
2) DMA will place the buffers and ack the CPU
3) The CPU will call unmap which will invalidate the buffers again


I can only think of one problematic scenario:
- After 1 and before 2: 
	CPU0 did spec prefetch for address x 
- After 2: 
	CPU0 is doing inv: lock int, ldr x, 
		str x (addr x is marked dirty with wrong data).
	CPU1 at this time doing spec prefetch for x which 
		will snoop CPU0 and will cause data corruption... :(

I can assume that if I count on the Soc IO cache coherency support all this isn't relevant, right? Or there are some issues hiding with v6 + IO coherency?


Thanks
Ronen Shitrit



-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, May 17, 2010 9:57 AM
To: Ronen Shitrit
Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6 DMA cache ops

On Mon, May 17, 2010 at 09:29:35AM +0300, Ronen Shitrit wrote:
> Got it, thanks.

No you haven't; disabling interrupts doesn't prevent CPUs speculatively
prefetching.
