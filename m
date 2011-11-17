From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 10:45:46 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
Message-ID: <20111117104546.GM9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 04:16:17PM -0800, Olof Johansson wrote:
> Yep, I would agree if we actually needed the vma for the flags, but we
> don't with the current implementation.

That's just one reason.  I mentioned more than one reason why the locking
was necessary in my mail but you seem to have ignored that.  The second
reason is a far more serious problem.

> We also don't continue iterating over the vmas, we only flush for the
> first one in the range that we find. That is possibly a bug.

No, that's intentional.  This function is not supposed to be used to
invalidate across several mappings.  It's there to deal with JIT code,
which will be written into some allocated memory.  It is extremely
unlikely that JIT code will be written into two consecutive, independently
created mappings and a single cache operation requested over both.

What if the two independent mappings are located at wildly different
addresses?
