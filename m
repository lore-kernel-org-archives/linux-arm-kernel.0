From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jan 2016 22:12:20 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20160105152657.GA31598@yury-N73SV>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <2634904.E1fnEZUKo9@wuerfel> <20160105152657.GA31598@yury-N73SV>
Message-ID: <13371161.AI9IgZN0G2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 18:26:57 Yury Norov wrote:
> > So the calling conventions avoid the problem of being able to set
> > the upper bits from malicious user space when the kernel assumes they
> > are zeroed out (we had security bugs in this area, before we introduced
> > SYSCALL_DEFINEx()), but it means that we need wrappers around each
> > syscall that takes an argument that is different length between user
> > and kernel space (as Catalin guessed). arch/s390 has the same problem and
> > works around it with code in arch/s390/kernel/compat_wrapper.c, while
> > other architectures (at least powerpc, x86 and tile IIRC, don't know much
> > about mips, parisc and sparc) don't have the problem because of their
> > calling conventions.
> > 
> > This also means that we cannot work around it in glibc at all, because
> > we have to be able to handle malicious user space, so it has to be
> > done in the kernel using something similar to what s390 does.
> > 
> >       Arnd
> 
> So it seems like we (should) have 2 compat modes - with and without access
> to upper half of register. I'm thinking now on how put it in generic
> unistd.h less painfull way.

I think we can do that by slightly modifying the existing __SYSCALL/__SC_3264/
__SC_COMP/__SC_COMP_3264 macros: The first two need extra wrappers for
arm64-ilp32 and s390, the other two don't.

We can use some clever string concatenation to add a ##_wrapper to the name
of the handler where needed and then just have a file that implements
the wrappers, copied from s390.

Unfortunately, we can't just zero out all the upper halves and be done with
it: even if we went back to passing 64-bit arguments as separate 32-bit
registers, we'd still need to deal with sign-extending negative 32-bit
numbers.

> Beside of that, I think I almost finished with all current comments. As
> this issue is not related to ILP32 directly, I think, it's better to show
> it now, as there is pretty massive rework. What do you think?

Good idea, yes.

	Arnd
