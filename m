From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2018 13:49:16 +0100
Subject: [RFC PATCH 03/11] arm64: pgtable: Implement p[mu]d_valid() and
 check in set_p[mu]d()
In-Reply-To: <CA+55aFyAWyGTCzG8YtNwDdmS9TDVYoMCUYvxo0cj3V79w7hQ4A@mail.gmail.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-4-git-send-email-will.deacon@arm.com>
 <CA+55aFyAWyGTCzG8YtNwDdmS9TDVYoMCUYvxo0cj3V79w7hQ4A@mail.gmail.com>
Message-ID: <20180828124915.GA26727@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Aug 24, 2018 at 09:15:17AM -0700, Linus Torvalds wrote:
> On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Now that our walk-cache invalidation routines imply a DSB before the
> > invalidation, we no longer need one when we are clearing an entry during
> > unmap.
> 
> Do you really still need it when *setting* it?
> 
> I'm wondering if you could just remove the thing unconditionally.
> 
> Why would you need a barrier for another CPU for a mapping that is
> just being created? It's ok if they see the old lack of mapping until
> they are told about it, and that eventual "being told about it" must
> involve a data transfer already.
> 
> And I'm assuming arm doesn't cache negative page table entries, so
> there's no issue with any stale tlb.
> 
> And any other kernel thread looking at the page tables will have to
> honor the page table locking, so you don't need it for some direct
> page table lookup either.
> 
> Hmm? It seems like you shouldn't need to order the "set page directory
> entry" with anything.
> 
> But maybe there's some magic arm64 rule I'm not aware of. Maybe even
> the local TLB hardware walker isn't coherent with local stores?

Yup, you got it: it's not related to ordering of accesses by other CPUs, but
actually because the page-table walker is treated as a separate observer by
the architecture and therefore we need the DSB to push out the store to the
page-table so that the walker can see it (practically speaking, the walker
isn't guaranteed to snoop the store buffer).

For PTEs mapping user addresses, we actually don't bother with the DSB
when writing a valid entry because it's extremely unlikely that we'd get
back to userspace with the entry sitting in the store buffer. If that
*did* happen, we'd just take the fault a second time. However, if we played
that same trick for pXds, I think that:

	(a) We'd need to distinguish between user and kernel mappings
	    in set_pXd(), since we can't tolerate spurious faults on
	    kernel addresses.
	(b) We'd need to be careful about allocating page-table pages,
	    so that e.g. the walker sees zeroes for a new pgtable

We could probably achieve (a) with a software bit and (b) is a non-issue
because mm/memory.c uses smp_wmb(), which is always a DMB for us (which
will enforce the eventual ordering but doesn't necessarily publish the
stores immediately).

Will
