From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Nov 2011 23:50:24 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
Message-ID: <20111116235024.GH9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 01:23:02PM -0800, Olof Johansson wrote:
> Agreed. Russell, please consider picking this up -- the bug is very
> real and it sounds like the objection is vague.

No, it isn't.  It's creating an unsafe situation.  If we're going to do
this, we might as well give up on architecture correctness because we're
throwing out locking correctness.

1. We look up the VMA.
2. We pass the VMA to the cache operation.
3. The cache operation dereferences the VMA to obtain the VMA flags.

If something else happens to modify the VMA (eg, a concurrent mremap or
munmap) then without locking, we could end up dereferencing something
that is no longer the VMA we thought we had.

Plus, consider that the VMA list is modifyable while the mmap_sem is not
held - do we really want to see the effects of having find_vma() being
preempted having loaded a vm_next pointer, another thread coming in,
modifying the VMA list (possibly deleting the next vma), that memory being
reallocated to something else, and then we resume and fall off the VMA
list and possibly OOPS because we've accessed what we thought was the
next vm_next pointer but it wasn't?

While we can say "an application should not do that" that's not a reason
to ignore this problem and just delete all the locking in the hope that
we'll always have well behaving applications.

So, it's *totally* unsafe to delete the locking here.

The requirement is that the mmap_sem must be held while you expect to
hold any reference to a vm_area_struct.  There's no exceptions to that.

One solution to this is to use pagefault_disable()...pagefault_enable()
around the cache operation, so that faults just cause us to skip to the
next page.  The down-side to that is that pagefault_disable() makes us
non-preemptible while performing the cache operation.  However, we can
work around that by performing the cache handling in appropriately sized
chunks.
