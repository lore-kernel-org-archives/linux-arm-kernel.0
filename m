From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Feb 2011 14:41:25 -0500 (EST)
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <20110210154322.GE1742@n2100.arm.linux.org.uk>
References: <4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2D1942.4050905@ahsoftware.de>
	<AANLkTimAFp7ORrJLw2d8-i5pK0MZGTyAN5kmRR37ky1v@mail.gmail.com>
	<alpine.LFD.2.00.1101121314470.25498@xanadu.home>
	<20110112184258.GH11039@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101121350350.25498@xanadu.home>
	<AANLkTikLwTdV2B5Dyp_adCxgWcE-+Wb6uiN5MBfnA1_K@mail.gmail.com>
	<alpine.LFD.2.00.1101270030220.8580@xanadu.home>
	<20110210154322.GE1742@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102101405010.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Feb 2011, Russell King - ARM Linux wrote:

> On Thu, Jan 27, 2011 at 12:43:54AM -0500, Nicolas Pitre wrote:
> > The MMU-less kernel should still favor allocations close to the kernel 
> > text for modules, and anything else away from the kernel going 
> > downwards.
> > 
> > Otherwise a veneer should be created by the module symbol resolver such 
> > that if the branch distance to reach, say, printk is too large, then the 
> > following code would have to be dynamically generated right next to the 
> > module:
> > 
> > 	ldr	pc, [pc, #-4]
> > 	.word	<far_away_symbol>
> > 
> > Then, in your module, you patch the branch relocation for printk so that 
> > it branches to the code above instead, and then store the address of 
> > printk at the location represented by the .word directive.
> 
> What you're suggesting is what we used to do with the old user-space
> module tools, which would've been nice to carry forwards to the new
> module code.  I never found a way to do it.
> 
> The problems:
> 1. Where do you create those veneers?
> 2. How many veneers do you allocate space for?
> 3. How do you determine that you need a veneer?
> 
> While you can say "next to the module" for (1), you can only do that at
> the point in time when the space for the module is allocated, and you
> need to know at that point how much space you require.

You would have to guess of course.  Having a guess of 1/2 the module 
size should be pretty safe.  So allocating 3/2 the space in 
module_alloc(), and then suffice to free the unused portion in 
module_finalize().

> For (2), you could always allocate space for one veneer per symbol present
> in the module, but that's very wasteful.
> 
> (3) is almost impossible to know ahead of time as you don't have the
> relocations, realistically you have to allocate one veneer per symbol,
> and as you don't know whether it's a data or code symbol, you'll have
> to allocate one veneer for every symbol in a module.

I don't think you may know the number of symbols in advance either 
anyway.

> I really don't like it, and I don't see that this is sanely solvable
> without giving architectures much more control over module loading,
> which I don't think will ever happen.  It's probably simpler to build
> modules with whatever that magic option is to tell GCC to always generate
> 'far call' veneers for everything rather than trying to 'fix' the kernel
> module loader.

Well, this is certainly possible indeed to just use -mlong-calls to 
build modules which would solve the issue right away, and with a smaller 
cost than if each function calls were going through a veneer, but with a 
higher cost than a relocatable direct branch.  So this could be decided 
with a Kconfig option.


Nicolas
