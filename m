From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Dec 2015 18:31:17 +0000
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <2334903.IjsQ1BK3JF@wuerfel>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <CA+=Sn1ktUCa_8MzMvZtQhE+fUNY5-V9JXTLXKDDe8a0iENgd=w@mail.gmail.com>
 <20151218114219.GA2830@mbp> <2334903.IjsQ1BK3JF@wuerfel>
Message-ID: <20151221183117.GC24894@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 01:47:55PM +0100, Arnd Bergmann wrote:
> On Friday 18 December 2015 11:42:19 Catalin Marinas wrote:
> > On Thu, Dec 17, 2015 at 12:14:20PM -0800, Andrew Pinski wrote:
> > > Well (just like LP64 on AARCH64), when passing a 32bit value to a
> > > function, the upper 32bits are undefined.  I ran into this when I was
> > > debugging the GCC go library on ILP32 (though reproduced with pure C
> > > code) and the assembly functions inside glibc where pointers are
> > > passed with the upper 32bits as undefined.
> > > So we have an issue if called with syscall function or using pure
> > > assembly to create the syscall functions (which glibc does).
> > 
> > I think the ILP32 syscall ABI should follow the PCS convention where the
> > top 32-bit of a register is not guaranteed 0 when the size of the
> > argument is 32-bit. So take the read(2) syscall:
> > 
> >         ssize_t read(int fd, void *buf, size_t count);
> > 
> > From the ILP32 code perspective, void * and size_t are both 32-bit. It
> > would call into the kernel leaving the top 32-bit as undefined (if we
> > follow the PCS). Normally, calling a function with the same size
> > arguments is not a problem since the compiler generates the callee code
> > accordingly. However, we route the syscall directly into the native
> > sys_read() where void * and size_t are 64-bit with the top 32-bit left
> > undefined.
> > 
> > We have three options here:
> > 
> > 1. Always follow PCS convention across user/kernel call and add wrappers
> >    in the kernel (preferred)
> 
> Yes, I also think this is best.
> 
> > 2. Follow the PCS up to glibc and get glibc to zero the top part (not
> >    always safe with hand-written assembly, though we already do this for
> >    AArch32 where the PCS only specifies 4 arguments in registers, the
> >    rest go on the stack)
> 
> I assume this needs special handling for syscalls with 64-bit arguments
> in both glibc and kernel.

I think glibc only should suffice, if it is its responsibility to zero
the top 32-bit part.

> > 3. Follow the PCS up to glibc but always pass syscall arguments in W
> >    registers, like AArch32 compat support (the least preferred option,
> >    the only advantage is a single wrapper for all syscalls but it would
> >    be doing unnecessary zeroing even for syscalls where it isn't needed)
> 
> This would mean we cannot pass 64-bit arguments in registers, right?

Not in a single register but two (like we do on AArch32).

> > My preference, as stated above, is (1). You can write the wrappers in C
> > directly and let the compiler upgrade the types when calling the native
> > syscall. But any other option would be fine (take some inspiration from
> > other architectures). Unfortunately we don't have COMPAT_SYSCALL_DEFINE
> > for all functions that we need to wrap, it would have been easier (so we
> > need to add them but probably in the arch/arm64 code).
> 
> It would be nice to have that code architecture-independent, so we can
> share it with s390 and only need to update one place when new syscalls
> get added.

We could indeed move things like:

COMPAT_SYSCALL_DEFINE3(s390_read, unsigned int, fd, char __user *, buf, compat_size_t, count)

to the core code and share them between s390 and arm64/ILP32. So let's
stick to option 1.

-- 
Catalin
