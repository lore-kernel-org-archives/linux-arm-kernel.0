From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 10:38:31 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <20100715093107.GB17605@trinity.fluff.org>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
	<20100715093107.GB17605@trinity.fluff.org>
Message-ID: <20100715093831.GE26212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 10:31:07AM +0100, Ben Dooks wrote:
> On Thu, Jul 15, 2010 at 05:13:57PM +0800, David Yang wrote:
> >        I don't know the reason until now.I guess the memory allocated by the
> > dma_alloc_coherent may be cached....if not , why it is so slowly?
> 
> The dma_alloc_coherent coherent should return uncachable and un-bufferable
> memory, otherwise you meed explicit flushing commands when changing between
> the HW and CPU ownership.

It's a result of the weakly ordered memory model - writes to memory
are now delayed and can be re-ordered, but not across the appropriate
barrier instructions.

Lack of barrier instructions makes that these writes can arrive in
unexpected orders, which will cause exactly these kinds of problems.

Catalin has been tracking down where these barriers need to be added,
so we're getting these issues solved - but we can only find them
through people using the kernel, reporting problems like this, and
fixing the missing places.
