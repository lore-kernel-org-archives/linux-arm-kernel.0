From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Apr 2012 17:27:26 +0100
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20120418152726.GB24211@n2100.arm.linux.org.uk>
References: <20111117102205.GF4748@arm.com>
 <20111117104245.GL9581@n2100.arm.linux.org.uk>
 <20111117105935.GH4748@arm.com>
 <20111117110339.GO9581@n2100.arm.linux.org.uk>
 <20111117112508.GA20412@arm.com> <4F827A82.4000407@googlemail.com>
 <CAOesGMjEW0cj2v-2OuWTd9WhLdZr3xOdEpZ2qy_UTdyMhYvaDA@mail.gmail.com>
 <20120410171720.GH14394@mudshark.cambridge.arm.com>
 <20120418150508.GF6362@mudshark.cambridge.arm.com>
 <20120418152726.GB24211@n2100.arm.linux.org.uk>
Message-ID: <20120418162726.GK6362@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Apr 18, 2012 at 04:27:26PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 18, 2012 at 04:05:08PM +0100, Will Deacon wrote:
> > ... and here's a patch on top of the original which lets us return errors to
> > userspace from the cacheflush syscall.
> 
> Is this worth it?  No one's checking for errors as it stands.

Indeed, but that's because we always return 0 at the moment. I spoke to some
of the JIT guys here and they seemed to think it would be useful for them.

> > The cacheflush syscall can fail for two reasons:
> > 
> > (1) The arguments are invalid (nonsensical address range or no VMA)
> 
> That's a good reason...
> 
> > (2) The region generates a translation fault on a VIPT or PIPT cache
> 
> But I don't think this is, for two reasons:
> 
> 1. Remember that the purpose of this operation is to allow userspace to
>    write code into pages and then execute that code - so all that we're
>    concerned about in this call is to ensure that the I/D caches for the
>    memory region are synchronized.
> 
> 2. We'll fault at the cache operation on v6 and v7 because the page was
>    not present, and that will make the system try and bring the page back
>    into the memory space.  Only if that fails (eg, because we're running
>    low on memory) will we fail to replace the page, and use the exception
>    handling.

Understood, although the case I was actually thinking of is when you flush a
region that has the wrong protection bits (i.e. PROT_WRITE isn't set). In
this case it probably means userspace is doing something wrong and it would
be nice to indicate that with an -EFAULT.

> I think the original intention for (2) was that the page would merely get
> skipped and we'd move onto the next page without trying to bring the
> previous page back into the memory space - this won't work because of the
> way the page fault handler works.  If we want that behaviour, we need to
> use pagefault_disable()..pagefault_enable() around the cache flushing to
> ensure that the page fault handler does not try to replace the missing
> page, but instead immediately calls the fixup function.

I think the cleanest way to tidy this up is to give up as soon as we take a
fault that wasn't handled by the page fault handler. I don't see the value in
continuing with the remaining pages. even if we decide not to report it to
userspace.

> Now, the fact is that 99% of userspace will not be checking the return
> value of this syscall (they can't, because the return value has never been
> defined.)  They can't even start to check the return value, because they
> may fail on older kernels which don't.  So all round, this is a bad idea.

It looks to me like we've always return 0 for this syscall, so we could
define it retrospectively if we need to.

> Just treat this the same way that the 'prefetch' instruction does - ignore
> errors, and continue.  If you're going to be calling this function on a
> region which you haven't just written code to (and therefore should exist)
> then you're doing something wrong in userspace.

Agreed, but it would be nice to shout at userspace when they're misbehaving.

Will
