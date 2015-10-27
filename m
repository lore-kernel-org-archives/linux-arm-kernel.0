From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 27 Oct 2015 19:13:51 +0100
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151022174400.GW32532@n2100.arm.linux.org.uk>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel> <57854232.vMTrn4EgZx@wuerfel>
 <20151022150959.GU17308@twins.programming.kicks-ass.net>
 <20151022174400.GW32532@n2100.arm.linux.org.uk>
Message-ID: <20151027181351.GA15015@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Oct 22, 2015 at 05:09:59PM +0200, Peter Zijlstra wrote:
> > Hmm, I was sure I send a reply, but I cannot even find it in my own sent
> > folder so who knows.
> > 
> > My current preference is to keep the thing a macro and work around it in
> > the usage site because while these warns are annoying, they're at least
> > visible. Whereas, with an inline, code bloat is entirely silent. Even if
> > the sites you found are harmless, there's no saying what the future will
> > bring etc..
> 
> I agree - we've got way too many inline functions already.  My biggest annoyance 
> in that respect is the asm-generic dma_map_single() implementation that we're 
> now forced to use on ARM, which results in quite a large chunk of code at every 
> callsite.
> 
> The problem there is that when you have drivers which do something like:
> 
> 	dma = dma_map_single(dev, page_address(page), size, dir);
> 
> you end up with code which converts the struct page to a virtual address, and 
> then you end up with code in the dma_map_single() inline function which then 
> converts it back to a struct page + offset - none of which, with modern ARM 
> kernels, the compiler has a hope in hell of optimising.
> 
> So we end up with all that junk at every single dma_map_single() callsite. If 
> dma_map_single() were a library function, it would be a lot smaller since we'd 
> only have one copy of the complex virt->struct page conversion.

Should be pretty easy to fix, once you know which inline functions hurt.

Thanks,

	Ingo
