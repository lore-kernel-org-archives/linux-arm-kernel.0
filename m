From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 11:22:18 +0100
Subject: [GIT PULL] pxa: features for next
In-Reply-To: <CAMPhdO84i1v1ibzBnJ4BPkF67cRpQ74o+=Es_rW2t8PStN-jbg@mail.gmail.com>
References: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
	<20110711074113.GK4812@n2100.arm.linux.org.uk>
	<CAMPhdO8pxGsEN1EeYwZRBnPvhkN29wOmEzWaaoCh9iqO+VkDrg@mail.gmail.com>
	<20110711074600.GL4812@n2100.arm.linux.org.uk>
	<CAMPhdO8=Gsiw_e6mFRi1PM99DSroaQi_SBiH298KAKqHb41rNw@mail.gmail.com>
	<20110711075243.GM4812@n2100.arm.linux.org.uk>
	<CAMPhdO-zR_=i_01KSTx_TzRFEOgygHc=kkUB68bke62_nzO=8Q@mail.gmail.com>
	<20110711084026.GN4812@n2100.arm.linux.org.uk>
	<CAMPhdO84i1v1ibzBnJ4BPkF67cRpQ74o+=Es_rW2t8PStN-jbg@mail.gmail.com>
Message-ID: <20110711102218.GF3239@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 06:07:56PM +0800, Eric Miao wrote:
> Ah now I see the problem. So it's actually in dump_backtrace_entry(),
> where the if (in_exception_text(where)) dump_mem(...) has this
> assumption.
> 
> One way to solve this from my humble opinion is to mandate
> __exception for the C function (stack version) of handle_arch_irq,
> and when MULTI_IRQ defined, remove __exception from asm_do_IRQ(),
> so the assumption in dump_backtrace_entry() still holds true.
> 
> Or do we have a gcc extension to tell the compiler a simple function
> doesn't need to use the stack?

Or we could rename asm_do_IRQ() to handle_arch_irq() without the
__exception tag, and recreate asm_do_IRQ() with the tag, which just calls
handle_arch_irq().
