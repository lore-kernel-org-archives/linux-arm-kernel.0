From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 28 Apr 2011 14:20:20 -0400 (EDT)
Subject: [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
In-Reply-To: <20110428081759.GM3755@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-3-git-send-email-nicolas.pitre@linaro.org>
	<20110427085336.GL17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104271043160.24613@xanadu.home>
	<20110428081759.GM3755@atomide.com>
Message-ID: <alpine.LFD.2.00.1104281408060.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Apr 2011, Tony Lindgren wrote:

> Just to summarize, looks like there are three regressions:
> 
> 1. The stack alignment mentioned above

This one has been there forever.  I marked it for inclusion into 
the stable tree.

> 2. Stack overwriting relocated kernel with cache flush in some cases on ARMv7

Yes, and I reverted to your original patch.  I think I agree with RMK 
about the fact that having a stack available is more sane than trying to 
squeeze everything into registers (including sp as my patch did).

> 3. Reloction overwriting running code when the relocate offset is small

Yep.  However I agree with you that having a constant like my patch did 
is prone to failure if the code grows big enough (unlikely but still).  
However your usage of the GOT end is overshooting as only the copy loop 
and cache flush code has to be protected.  I have an alternative patch 
using an explicit symbol to mark critical code.

> These fixes would be nice to get merged in the -rc cycle. Then the
> other patches like the static usage in uncompress.h can probably wait
> until the merge window.

Right.  I have sorted them so Russell can send a pointer to the first 
part to Linus and keep the rest for later.  I'll repost the whole set 
soon anyway.


Nicolas
