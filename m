From: rshitrit@marvell.com (Ronen Shitrit)
Date: Mon, 17 May 2010 14:29:39 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6
	DMA cache ops
In-Reply-To: <1274090432.6053.4.camel@e102109-lin.cambridge.arm.com>
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
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
	<1274090432.6053.4.camel@e102109-lin.cambridge.arm.com>
Message-ID: <309002C0DA137042828828FC53D7A93492FA313858@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
Sent: Monday, May 17, 2010 1:01 PM
To: Ronen Shitrit
Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org
Subject: RE: [PATCH 2/8] ARM: Implement read/write for ownership in theARMv6 DMA cache ops

On Mon, 2010-05-17 at 10:34 +0300, Ronen Shitrit wrote:
> After some more thinking, I think I found the problem...
> 
> DMA for receive should operate as follows:
> 1) CPU will map (invalidate) the buffers for the DMA
> 2) DMA will place the buffers and ack the CPU
> 3) The CPU will call unmap which will invalidate the buffers again

(3) doesn't happen with my patch - the unmap function is now a no-op
since the invalidate operation is destructive.

[Ronen Shitrit] so how do you protect your self from I-cache spec prefetch?
Do you have a unified L2?

As I said in a previous e-mail, it's the sync operation that does an
invalidate and this would affect the data in the buffer. Hence the patch
to make the invalidate operation non-destructive (as long as your CPU
doesn't do speculative loads into the D-cache or they can be disabled).
[Ronen Shitrit] What about I-cache prefetch? Unified cache?

-- 
Catalin
