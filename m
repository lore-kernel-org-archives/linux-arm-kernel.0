From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 21:50:52 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <CA+=Sn1ktUCa_8MzMvZtQhE+fUNY5-V9JXTLXKDDe8a0iENgd=w@mail.gmail.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <2105480.kqDuemge8n@wuerfel>
 <CA+=Sn1ktUCa_8MzMvZtQhE+fUNY5-V9JXTLXKDDe8a0iENgd=w@mail.gmail.com>
Message-ID: <2634904.E1fnEZUKo9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 12:14:20 Andrew Pinski wrote:
> On Thu, Dec 17, 2015 at 12:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 17 December 2015 18:27:53 Catalin Marinas wrote:
> >> On Wed, Dec 16, 2015 at 12:42:38AM +0300, Yury Norov wrote:
> >
> >> > +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
> >> > +#define compat_sys_pread64             sys_pread64
> >> > +#define compat_sys_pwrite64            sys_pwrite64
> >> > +#define compat_sys_readahead           sys_readahead
> >> > +#define compat_sys_shmat               sys_shmat
> >>
> >> I wonder whether we need wrappers (actually, not only for these but
> >> sys_read etc.). These functions take either a pointer or a size_t
> >> argument which are 32-bit with ILP32 but treated as 64-bit by an LP64
> >> kernel. Can we guarantee that user space zeros the top 32-bit of the
> >> arguments passed here?
> >
> > I'm pretty sure that is safe. I haven't read the calling conventions
> > specification for arm64 ilp32, but usually all function arguments are
> > passed as 64-bit registers with proper sign-extend or zero-extend.
> 
> Well (just like LP64 on AARCH64), when passing a 32bit value to a
> function, the upper 32bits are undefined.  I ran into this when I was
> debugging the GCC go library on ILP32 (though reproduced with pure C
> code) and the assembly functions inside glibc where pointers are
> passed with the upper 32bits as undefined.
> So we have an issue if called with syscall function or using pure
> assembly to create the syscall functions (which glibc does).

Ok, I see :-(

So the calling conventions avoid the problem of being able to set
the upper bits from malicious user space when the kernel assumes they
are zeroed out (we had security bugs in this area, before we introduced
SYSCALL_DEFINEx()), but it means that we need wrappers around each
syscall that takes an argument that is different length between user
and kernel space (as Catalin guessed). arch/s390 has the same problem and
works around it with code in arch/s390/kernel/compat_wrapper.c, while
other architectures (at least powerpc, x86 and tile IIRC, don't know much
about mips, parisc and sparc) don't have the problem because of their
calling conventions.

This also means that we cannot work around it in glibc at all, because
we have to be able to handle malicious user space, so it has to be
done in the kernel using something similar to what s390 does.

	Arnd
