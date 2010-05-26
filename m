From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 May 2010 08:50:59 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100526004418.GM9645@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100522215848.GB29889@n2100.arm.linux.org.uk>
	<20100526004418.GM9645@atomide.com>
Message-ID: <20100526075059.GA25435@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 05:44:18PM -0700, Tony Lindgren wrote:
> > So, below is a patch to sanitize the code in arch/arm/plat-omap/fb.c.
> > The logic in this file is rather convoluted, but essentially:
> 
> I've tried the patch below with the patches from your lmb branch
> up to this one and I can see tux on my osk5912 and n900:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Interesting patch name!

> After applying the next patch in your lmb branch "ARM: OMAP: Convert
> to use ->reserve method to reserve boot time memory" tux still works
> on 5912osk, but not on n900. The difference is that osk5912 uses
> the old omapfb code.

I guess this is because I don't have board-n900.c in my tree.  All OMAP
boards need a ".reserve = omap_reserve," line added in their machine
descriptor.

I just noticed that board-n8x0.c contains more than one machine descriptor,
which I've now fixed up.

> Then, looks like reordering of the patches now causes patch
> "ARM: initial LMB trial" to fail with:
> 
> arch/arm/mm/init.c:301: error: conflicting types for 'bootmem_init'
> arch/arm/mm/mm.h:32: error: previous declaration of 'bootmem_init' was here
> arch/arm/mm/init.c: In function 'bootmem_init':
> arch/arm/mm/init.c:312: error: 'mdesc' undeclared (first use in this function)
> arch/arm/mm/init.c:312: error: (Each undeclared identifier is reported only once
> arch/arm/mm/init.c:312: error: for each function it appears in.)
> make[1]: *** [arch/arm/mm/init.o] Error 1

Now fixed, thanks.

> Also, the last patch in lmb branch "ARM: use LMB to allocate system
> memory MMIO resource structures" causes both osk5912 and n900
> to hang very early. Maybe I'm missing some patch again..

Hmm, I'll take a look later today.

> Anyways, I've picked the patches from lmb branch up to the one below
> into omap-testing. Will add more of them once we get them working.

You should now be able to pick all but the last patch.
