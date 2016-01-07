From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 15:13:37 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20160106171047.GP6301@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <13371161.AI9IgZN0G2@wuerfel>
 <20160106171047.GP6301@e104818-lin.cambridge.arm.com>
Message-ID: <2605790.14f8aape6N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 January 2016 17:10:47 Catalin Marinas wrote:
> On Tue, Jan 05, 2016 at 10:12:20PM +0100, Arnd Bergmann wrote:
> > On Tuesday 05 January 2016 18:26:57 Yury Norov wrote:
> > > > So the calling conventions avoid the problem of being able to set
> > > > the upper bits from malicious user space when the kernel assumes they
> > > > are zeroed out (we had security bugs in this area, before we introduced
> > > > SYSCALL_DEFINEx()), but it means that we need wrappers around each
> > > > syscall that takes an argument that is different length between user
> > > > and kernel space (as Catalin guessed). arch/s390 has the same problem and
> > > > works around it with code in arch/s390/kernel/compat_wrapper.c, while
> > > > other architectures (at least powerpc, x86 and tile IIRC, don't know much
> > > > about mips, parisc and sparc) don't have the problem because of their
> > > > calling conventions.
> > > > 
> > > > This also means that we cannot work around it in glibc at all, because
> > > > we have to be able to handle malicious user space, so it has to be
> > > > done in the kernel using something similar to what s390 does.
> > > 
> > > So it seems like we (should) have 2 compat modes - with and without access
> > > to upper half of register. I'm thinking now on how put it in generic
> > > unistd.h less painfull way.
> > 
> > I think we can do that by slightly modifying the existing __SYSCALL/__SC_3264/
> > __SC_COMP/__SC_COMP_3264 macros: The first two need extra wrappers for
> > arm64-ilp32 and s390, the other two don't.
> > 
> > We can use some clever string concatenation to add a ##_wrapper to the name
> > of the handler where needed and then just have a file that implements
> > the wrappers, copied from s390.
> > 
> > Unfortunately, we can't just zero out all the upper halves and be done with
> > it: even if we went back to passing 64-bit arguments as separate 32-bit
> > registers, we'd still need to deal with sign-extending negative 32-bit
> > numbers.
> 
> How many syscalls would we need sign-extension for? Most are probably
> already handled by specific compat_sys_* functions, otherwise A32 compat
> wouldn't work properly.

Good point. I suppose any system call that expects a negative argument
may run into this on all architectures and require a COMPAT_SYSCALL handler,
but only s390 cares about doing the extension for the entire set of syscalls.

This may be to work around a peculiarity of s390, which has now two
but three possible 32-to-64 extension modes: signed int, unsigned int
and pointer. The third one sets the top 33 bits to zero, clearing the
top bit of the 31-bit pointer value in the process. Nothing else needs
this, so if we just clear the upper bits on all system calls and go
back to passing 64-bit arguments as pairs, we are fine and have a much
simpler solution.

> Anyway, I think we can get away with not modifying the generic __SYSCALL
> definition and only use something like
> arch/s390/kernel/compat_wrapper.c. In sys_ilp32.c, we would make
> __SYSCALL expand the function name with some ilp32_ prefix.

I couldn't think of a way, but I'm gladly proven wrong here.

> For existing compat_* syscalls, we only need to handle the pointer types
> (something like the s390's __TYPE_IS_PTR). I think other types are
> already handled by defining the prototype with compat_ulong_t etc.

Right.
 
> For native syscalls like sys_read, apart from pointers we also need to
> handle size_t. The wrapper would need to be defined using compat types:
> 
> ILP32_SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, compat_size_t, count)
> 
> and let the compiler handle the conversion to size_t automatically when
> calling sys_read from the wrapper.

Correct. I don't think we need an ILP32_SYSCALL_DEFINEx set of macros
though, the existing COMPAT_SYSCALL_DEFINEx ones should get this right
already.

	Arnd
