From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 09 Sep 2012 17:51:16 +0100
Subject: [PATCH] ARM: 7467/1: mutex: use generic xchg-based
 implementation for ARMv6+
In-Reply-To: <1345811807-7971-1-git-send-email-will.deacon@arm.com>
References: <1345811807-7971-1-git-send-email-will.deacon@arm.com>
Message-ID: <1347209476.7709.36.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-24 at 13:36 +0100, Will Deacon wrote:
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
> Cc: <stable@vger.kernel.org> : 0bce9c46: mutex: Place lock in contended...
> Cc: <stable@vger.kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reported-by: Shan Kang <kangshan0910@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> 
> Greg, Ben: Here's a re-send of this mutex patch now that the dependency
> has been merged into mainline. Although that patch also has a CC: stable,
> I added an explicit dependency here too.
[...]

I thought this had been deferred, but it actually already went into
3.2.27.  The fix you refer to is queued up for the next 3.2 update.

Ben.

-- 
Ben Hutchings
Time is nature's way of making sure that everything doesn't happen at once.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120909/c5b0d547/attachment.sig>
