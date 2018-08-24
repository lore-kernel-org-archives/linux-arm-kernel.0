From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Aug 2018 09:15:17 -0700
Subject: [RFC PATCH 03/11] arm64: pgtable: Implement p[mu]d_valid() and
 check in set_p[mu]d()
In-Reply-To: <1535125966-7666-4-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-4-git-send-email-will.deacon@arm.com>
Message-ID: <CA+55aFyAWyGTCzG8YtNwDdmS9TDVYoMCUYvxo0cj3V79w7hQ4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Now that our walk-cache invalidation routines imply a DSB before the
> invalidation, we no longer need one when we are clearing an entry during
> unmap.

Do you really still need it when *setting* it?

I'm wondering if you could just remove the thing unconditionally.

Why would you need a barrier for another CPU for a mapping that is
just being created? It's ok if they see the old lack of mapping until
they are told about it, and that eventual "being told about it" must
involve a data transfer already.

And I'm assuming arm doesn't cache negative page table entries, so
there's no issue with any stale tlb.

And any other kernel thread looking at the page tables will have to
honor the page table locking, so you don't need it for some direct
page table lookup either.

Hmm? It seems like you shouldn't need to order the "set page directory
entry" with anything.

But maybe there's some magic arm64 rule I'm not aware of. Maybe even
the local TLB hardware walker isn't coherent with local stores?

                Linus
