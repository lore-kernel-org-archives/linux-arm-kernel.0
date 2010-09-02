From: js@sig21.net (Johannes Stezenbach)
Date: Thu, 2 Sep 2010 16:30:18 +0200
Subject: ARM926EJ-S TLB lockdown
In-Reply-To: <AANLkTinPN1gYoq6xLCynFmYG+3Zkje=rzHzXKvvGJGeC@mail.gmail.com>
References: <20100901151920.GA6019@sig21.net>
	<AANLkTinPN1gYoq6xLCynFmYG+3Zkje=rzHzXKvvGJGeC@mail.gmail.com>
Message-ID: <20100902143018.GA9166@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 10:01:14PM +0200, Linus Walleij wrote:
> 2010/9/1 Johannes Stezenbach <js@sig21.net>:
> 
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xffff0000); ? ? ? // exception vectors
> 
> This is probably clever to put in the lockdown TLB
> 
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0000000); ? ? ? // kernel code / data
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0100000); ? ? ? // kernel code / data
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0200000); ? ? ? // kernel code / data
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0300000); ? ? ? // kernel code / data
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0400000); ? ? ? // kernel code / data
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0500000); ? ? ? // kernel code / data
> > ? ? ? ? ? ? ? ?tlb_lockdown(0xc0600000); ? ? ? // kernel code / data
> 
> But are these really most relevant to lock down?

Well, these were just easy to do.  The kernel uses 1MB sections
(not 4K pages) for these mappings, thus it is possible to cover
all kernel code + data + a bit more with just 7 TLB entries.
Kernel modules and everything else use 4K pages so it
becomes difficult to decide what to lock down.

But OTOH the kernel's use of 1MB sections also means there is
not much TLB pressure which I guess explains the small gain.

> Since you have a JTAG debugger, can't you profile what
> memory pages are actually accessed most often and lock down
> these?
> 
> But it can be even more elaborate. Profile out the *functions*
> most used.
> 
> When I've worked with TCM I played with the idea to be able to
> tag functions like this:
> 
> #define __hotfunc __attribute__((long_call)) __section(.hot.text) noinline
> (...)
> int __hotfunc foo();
> 
> Then have the linker put the hotfuncs into separate pages and
> link that.
> 
> You can use the same scheme for locked-down TLB:s I believe?
> Up to 8 pages of code tagged "hotfunc" will be diverted to these
> pages and locked down.
> 
> See the stuff in arch/arm/include/asm/tcm.h for the compiler
> directives and check the link script in
> arch/arm/kernel/vmlinux.lds.S to see how I'm separating the
> TCM stuff to separate pages.

That's much more work than I'm willing to invest right now ;-/

I guess the intended use for the lockdown TLB is to minimize
latency for realtime code, e.g. if I had hooked up a FIQ handler
I would lock down it's code, stack and data pages.


Thanks
Johannes
