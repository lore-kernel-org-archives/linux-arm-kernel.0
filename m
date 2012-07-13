From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jul 2012 13:07:55 -0400 (EDT)
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <20120713143026.GV18079@mudshark.cambridge.arm.com>
References: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
 <201207131414.37078.arnd@arndb.de>
 <20120713143026.GV18079@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1207131303090.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Will Deacon wrote:

> Hi Arnd,
> 
> On Fri, Jul 13, 2012 at 03:14:36PM +0100, Arnd Bergmann wrote:
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for that.
> 
> > One question though: can you explain why the xchg implementation is better
> > on pre-v6, while the dec implementation is better on v6+? It would probably
> > be helpful to put that in the comment at
> > 
> >  /* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
> >  # include <asm-generic/mutex-xchg.h>
> >  #else
> >  /* ARMv6+ can implement efficient atomic decrement using exclusive accessors. */
> >  # include <asm-generic/mutex-dec.h>
> > 
> > Intuitively, I'd guess that both implementations are equally efficient
> > on ARMv6 because they use the same ldrex/strex loop.
> 
> I used the atomic decrement version because that's what the old
> implementation was most similar to. For some reason I thought that maybe the
> register pressure would be higher for xchg, but it doesn't look like that's
> the case (there are compiler barriers anyway) and we actually end up with one
> fewer instruction using xchg as we longer need the subtract.

The xchg is much better on pre-ARMv6 because it uses the SWP instruction 
which is deprecated from ARMv6.  Given that the atomic dec and xchg are 
rather equivalent on ARMv6 then having only one case is fine.  However 
it is important to comment the fact that despite ARMv6+ choice, the 
pre-ARMv6 does want to remain xchg based.  Having both unified might 
hide this fact otherwise.


Nicolas
