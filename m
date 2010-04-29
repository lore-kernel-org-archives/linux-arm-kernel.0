From: dima@android.com (Dima Zavin)
Date: Thu, 29 Apr 2010 12:23:54 -0700
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_sem
	held
In-Reply-To: <20100429182455.GH4877@n2100.arm.linux.org.uk>
References: <1272439931-12795-1-git-send-email-dima@android.com>
	<20100429130035.GB4877@n2100.arm.linux.org.uk>
	<20100429181636.GA25894@shareable.org>
	<20100429182455.GH4877@n2100.arm.linux.org.uk>
Message-ID: <h2s404ea8001004291223g32cd945bue3a78c6b5372cb92@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie/Russell,

Thanks for the feedback.

>> read-write locks will block a reader when there is a already blocked
>> writer. ?Otherwise the writer can be permanently starved due to new
>> readers always arriving so reader count doesn't reach zero.

That's precisely the problem.

> Hmm, true, and rather unfortunate.
>
> As I've already said, we can not do this cache maintainence outside of
> the lock.
>
> The point of this code is to first validate that the region we're working
> on is valid. ?As soon as we drop the lock, we lose the guarantee that
> the region is valid while we operate on it - indeed, the region could be
> unmapped and remapped by a different thread.

So what if it was remapped? The worst case scenario in this case is
that we needlessly flush a region of memory, but its not "wrong". It
can't be any worse than just doing a full cache flush. If another
thread unmapped the region, then we should (and will) segfault the
flushing thread, which is the correct behavior IMHO.

--Dima

> I think the only reasonable solution is to also walk the page tables
> and do the cache handling on a per-page basis, which will make this
> interface quite a bit slower - but that's the price we pay for
> correctness.


>
