From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 13 Jul 2012 13:35:17 -0400 (EDT)
Subject: [PATCH v2] ARM: mutex: use generic xchg-based implementation for
 ARMv6+
In-Reply-To: <1342199767-15108-1-git-send-email-will.deacon@arm.com>
References: <1342199767-15108-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1207131334080.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Will Deacon wrote:

> The open-coded mutex implementation for ARMv6+ cores suffers from a
> severe lack of barriers, so in the uncontended case we don't actually
> protect any accesses performed during the critical section.
> 
> Furthermore, the code is largely a duplication of the ARMv6+ atomic_dec
> code but optimised to remove a branch instruction, as the mutex fastpath
> was previously inlined. Now that this is executed out-of-line, we can
> reuse the atomic access code for the locking (in fact, we use the xchg
> code as this produces shorter critical sections).
> 
> This patch uses the generic xchg based implementation for mutexes on
> ARMv6+, which introduces barriers to the lock/unlock operations and also
> has the benefit of removing a fair amount of inline assembly code.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reported-by: Shan Kang <kangshan0910@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Ok, so here's v2 following the feedback from Arnd and Nico. We now use
> the xchg-based version for all versions of the architecture and I've
> updated the commit message to reflect both that and also to remove the
> bit about avoiding the slowpath on frivolous CPUs!

Looks great.  You probably should tag it for stable as well.


Nicolas
