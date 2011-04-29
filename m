From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 00:17:56 -0700
Subject: [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
In-Reply-To: <alpine.LFD.2.00.1104281408060.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
	<20110427085336.GL17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104271043160.24613@xanadu.home>
	<20110428081759.GM3755@atomide.com>
	<alpine.LFD.2.00.1104281408060.24613@xanadu.home>
Message-ID: <20110429071755.GU3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110428 11:17]:
> On Thu, 28 Apr 2011, Tony Lindgren wrote:
> 
> > Just to summarize, looks like there are three regressions:
> > 
> > 1. The stack alignment mentioned above
> 
> This one has been there forever.  I marked it for inclusion into 
> the stable tree.

Right, not a regression, but a nasty bug.
 
> > 2. Stack overwriting relocated kernel with cache flush in some cases on ARMv7
> 
> Yes, and I reverted to your original patch.  I think I agree with RMK 
> about the fact that having a stack available is more sane than trying to 
> squeeze everything into registers (including sp as my patch did).

OK
 
> > 3. Reloction overwriting running code when the relocate offset is small
> 
> Yep.  However I agree with you that having a constant like my patch did 
> is prone to failure if the code grows big enough (unlikely but still).  
> However your usage of the GOT end is overshooting as only the copy loop 
> and cache flush code has to be protected.  I have an alternative patch 
> using an explicit symbol to mark critical code.

Cool saw that, yeah that's a nice way of fixing it.
 
> > These fixes would be nice to get merged in the -rc cycle. Then the
> > other patches like the static usage in uncompress.h can probably wait
> > until the merge window.
> 
> Right.  I have sorted them so Russell can send a pointer to the first 
> part to Linus and keep the rest for later.  I'll repost the whole set 
> soon anyway.

Great & thanks for tracking down these issues.

Tony
