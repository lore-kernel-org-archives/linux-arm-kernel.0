From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jul 2012 14:14:36 +0000
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
References: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
Message-ID: <201207131414.37078.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012, Will Deacon wrote:
> The open-coded mutex implementation for ARMv6+ cores suffers from a
> couple of problems:
> 
>         1. (major) There aren't any barriers in sight, so in the
>            uncontended case we don't actually protect any accesses
>            performed in during the critical section.
> 
>         2. (minor) If the strex indicates failure to complete the store,
>            we assume that the lock is contended and run away down the
>            failure (slow) path. This assumption isn't correct and the
>            core may fail the strex for reasons other than contention.
> 
> This patch solves both of these problems by using the generic atomic_dec
> based implementation for mutexes on ARMv6+. This also has the benefit of
> removing a fair amount of inline assembly code.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Reported-by: Shan Kang <kangshan0910@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

One question though: can you explain why the xchg implementation is better
on pre-v6, while the dec implementation is better on v6+? It would probably
be helpful to put that in the comment at

 /* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
 # include <asm-generic/mutex-xchg.h>
 #else
 /* ARMv6+ can implement efficient atomic decrement using exclusive accessors. */
 # include <asm-generic/mutex-dec.h>

Intuitively, I'd guess that both implementations are equally efficient
on ARMv6 because they use the same ldrex/strex loop.

	Arnd
