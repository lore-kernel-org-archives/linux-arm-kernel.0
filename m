From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 14:25:52 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <38FDDD2B-89C4-43C8-897D-A9DB6D023B7D@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <2069111.6po5Xr33Dn@wuerfel>
 <38FDDD2B-89C4-43C8-897D-A9DB6D023B7D@theobroma-systems.com>
Message-ID: <2298575.yFbFBhqo4c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 16:54:22 Dr.  Philipp Tomsich wrote:
> On 14 Apr 2015, at 16:07, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > I don't understand what you mean here, please elaborate. Why would an ABI that works
> > on aarch32 be wrong on aarch64-ilp32 user space when you are using the same header
> > files?
> AArch32 and AArch64/ILP32 are entirely different instruction set architectures. They have
> differently sized register files (AArch64 has about twice as many registers and each one is
> 64bits in size) and different register usage conventions. 
> 
> This affects other ?implementation details? such as the ucontext, too.
> For the sake of simplicity, I?ll refer to it just as ?register file? below.
> 
> This means that we would end up with very distinct code paths for the ?dependent? in tools
> (such as strace), if option (d) was used:
>         LP64:   AArch64 context + 64bit syscall interface
>         ILP32:  AArch64 context + 32bit syscall interface
>         AArch32:        AArch32 context + 32bit syscall interface
> 
> If we could agree on option (b), things would be much simpler:
>         LP64:   AArch64 context + 64bit syscall interface
>         ILP32:  AArch64 context + 64bit syscall interface + ILP32 compat-syscalls
>         AArch32:        AArch32 context + 32bit syscall interface
> 
> I.e. for all tools involved (whether it?s strace, gdb, etc.), LP64 and ILP32 can and should
> look very similar. After all, they differ in their sizeof(ptr_t) and sizeof(long), only.
> AArch32, on the other hand, is very dissimilar to AArch64? it?s a different architecture.
> 
> But this is talking from a tools-perspective...

Ok, I see.

>From the kernel perspective, this is very different: The compat syscall
handling in the kernel is fixed to the aarch32 behavior, and in particular
ioctl (but also a few others) in the current patch set need to share that
syscall between both IPL32 implementations (you can't use the LP64 version).

This means any data structure that can get passed into ioctl needs to
share the exact same layout between all ILP32 ABIs, or it would be a bug
in the kernel until someone fixes the driver to handle all three data
structure formats.

I thought until today that this would be limited to ioctl arguments derived
from the __kernel_ulong_t derived types I mentioned (__kernel_size_t,
__kernel_time_t, __kernel_ptrdiff_t, __kernel_off_t, __kernel_clock_t,
__kernel_ino_t, ...), but the problem is actually bigger than that and also
concerns types that are different between the traditional arm32 types and
the widened asm-generic types (__kernel_uid_t, __kernel_gid_t, __kernel_mode_t,
__kernel_off_t, __kernel_ipc_pid_t).

If we use the generic definitions for all those types, we cannot use the
existing compat_sys_ioctl() system call. If we use the aarch32 definitions,
we also have to use the other compat_sys_* calls that aarch32 uses in place
of the native ones (though a lot of syscalls are not needed any more in
general).

	Arnd
