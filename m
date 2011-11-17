From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Nov 2011 10:26:23 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
Message-ID: <20111117102623.GG4748@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 12:16:17AM +0000, Olof Johansson wrote:
> On Wed, Nov 16, 2011 at 3:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Nov 16, 2011 at 01:23:02PM -0800, Olof Johansson wrote:
> >> Agreed. Russell, please consider picking this up -- the bug is very
> >> real and it sounds like the objection is vague.
> >
> > No, it isn't. ?It's creating an unsafe situation. ?If we're going to do
> > this, we might as well give up on architecture correctness because we're
> > throwing out locking correctness.
> >
> > 1. We look up the VMA.
> > 2. We pass the VMA to the cache operation.
> > 3. The cache operation dereferences the VMA to obtain the VMA flags.
...
> We also don't continue iterating over the vmas, we only flush for the
> first one in the range that we find. That is possibly a bug.

I don't remember the details but couple of years ago someone working on
Java in ARM pointed out that a cache operation spanning two vmas only
flushes a single one. I think the JIT was modified since as I haven't
heard back but I would be more in favour of just dropping the vma
checks altogether.

-- 
Catalin
