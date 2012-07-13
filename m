From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2012 15:30:27 +0100
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <201207131414.37078.arnd@arndb.de>
References: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
 <201207131414.37078.arnd@arndb.de>
Message-ID: <20120713143026.GV18079@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jul 13, 2012 at 03:14:36PM +0100, Arnd Bergmann wrote:
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for that.

> One question though: can you explain why the xchg implementation is better
> on pre-v6, while the dec implementation is better on v6+? It would probably
> be helpful to put that in the comment at
> 
>  /* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
>  # include <asm-generic/mutex-xchg.h>
>  #else
>  /* ARMv6+ can implement efficient atomic decrement using exclusive accessors. */
>  # include <asm-generic/mutex-dec.h>
> 
> Intuitively, I'd guess that both implementations are equally efficient
> on ARMv6 because they use the same ldrex/strex loop.

I used the atomic decrement version because that's what the old
implementation was most similar to. For some reason I thought that maybe the
register pressure would be higher for xchg, but it doesn't look like that's
the case (there are compiler barriers anyway) and we actually end up with one
fewer instruction using xchg as we longer need the subtract.

If Nicolas is happy with it, I'd be tempted to use mutex-xchg.h regardless
of the architecture version (unfortunately we can't use generic-y for that).

Will
