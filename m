From: dalias@libc.org (Rich Felker)
Date: Wed, 11 Feb 2015 14:21:18 -0500
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
Message-ID: <20150211192118.GC23507@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 05:39:19PM +0000, Catalin Marinas wrote:
> (adding Marcus)
> 
> On Tue, Feb 10, 2015 at 06:13:02PM +0000, Rich Felker wrote:
> > On Thu, 2 Oct 2014 at 16:52:18 +0100, Catalin Marinas wrote:
> > > On Wed, Sep 03, 2014 at 10:18:54PM +0100, Andrew Pinski wrote:
> > > > New version with all of the requested changes.  Updated to the
> > > > latest sources.
> > > > 
> > > > Notable changes from the previous versions:
> > > > VDSO code has been factored out to be easier to understand and
> > > > easier to maintain.
> > > > Move the config option to the last thing that gets added.
> > > > Added some extra COMPAT_* macros for core dumping for easier usage.
> > > 
> > > Apart from a few comments I've made, I would also like to see non-empty
> > > commit logs and long line wrapping (both in commit logs and
> > > Documentation/). Otherwise, the patches look fine.
> > > 
> > > So what are the next steps? Are the glibc folk ok with the ILP32 Linux
> > > ABI? On the kernel side, what I would like to see:
> > 
> > I don't know if this has been discussed on libc-alpha yet or not, but
> > I think we need to open a discussion of how it relates to open glibc
> > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
> > 
> > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
> 
> I'm trying to understand the problem first. Quoting from the bug above
> (which I guess is quoted form C11):
> 
> "The range and precision of times representable in clock_t and time_t
> are implementation-defined. The timespec structure shall contain at
> least the following members, in any order.
> 
>          time_t tv_sec; // whole seconds -- >= 0
>          long   tv_nsec; // nanoseconds -- [0, 999999999]"
> 
> So changing time_t to 64-bit is fine on x32. The timespec struct
> exported by the kernel always uses a long for tv_nsec. However, glibc uses
> __syscall_slong_t which ends up as 64-bit for x32 (I guess it mirrors
> the __kernel_long_t definition).
> 
> So w.r.t. C11, the exported kernel timespec looks fine. But I think the
> x32 kernel support (and the current ILP32 patches) assume a native
> struct timespec with tv_nsec as 64-bit.

The exported kernel timespec is not fine if long is defined as a
32-bit type, which it is for x32 and the proposed aarch64-ILP32 ABIs.
The type being long means that code like

	long *p = &ts->tv_nsec;
	*p = 42;

is valid. With the proposed definition of timespec, this results in a
compiler warning or error on valid code, which is better than
dangerously wrong code generation, but we can easily hide the warning
via:

	void *p = &ts->tv_nsec;
	long *q = p;
	*q = 42;

Imagine this happening in places such as with callbacks that take void
pointers, for example pthread_create.

But even if the breakage could always be diagnosed by the compiler,
you're still breaking perfectly valid, conforming C programs.

> If we are to be C11 conformant, glibc on x32 has a bug as it defines
> timespec incorrectly. This hid a bug in the kernel handling the
> corresponding x32 syscalls. What's the best fix for x32 I can't really
> tell (we need people to agree on where the bugs are).

For the kernel, it should be casting the value to int/int32_t to
ignore the junk in the upper bits. But that only works on little
endian. On big endian it's a bigger mess.

However at this point fixing it on the kernel side is not very useful
for x32, at least not right away. Since people will still be running
old kernels with the wrong behavior, the fixup has to happen in
userspace to support those old kernels until the libc drops support
for kernels too old to handle it right.

> At least for AArch64 ILP32 we are still free to change the user/kernel
> ABI, so we could add wrappers for the affected syscalls to fix this up.

Yes. That's what I'd like to see before aarch64-ILP32 is officially
launched. It's a lot harder to retroactively fix this. Right now it's
fairly easy -- just a small wrapper/fixup layer in the kernel.

> > While most of the other type changes proposed (I'm looking at
> > https://lkml.org/lkml/2014/9/3/719) are permissible and simply
> > ugly/undesirable,
> 
> They may be ugly but definitely not undesirable ;).

I can point you to a few other cases that may be undesirable, but less
severe than timespec:

- https://sourceware.org/bugzilla/show_bug.cgi?id=16438
- http://man7.org/linux/man-pages/man2/sysinfo.2.html

In the case of sysinfo, the public API documentation documents the
fields as having type unsigned long, but on x32 (and presumably
aarch64-ILP32 as proposed) they have type unsigned long long.

I can probably find more examples if you're interested.

> > defining struct timespec with tv_nsec having any type other than long
> > conflicts with the requirements of C11 and POSIX, and WG14 is unlikely
> > to be interested in changing the C language because the Linux kernel
> > has the wrong type in timespec.
> 
> I agree. The strange thing is that the Linux exported headers are fine.

I'm confused why you think they're fine.

> > Note that on aarch64 ILP32, the consequences of not fixing this right
> > away will be much worse than on x32, since aarch64 (at least as I
> > understand it) supports big endian where it's not just a matter of
> > sign-extending the value from userspace and ignoring the padding, but
> > rather changing the offset of the tv_nsec member.
> 
> Indeed.
> 
> > Working around the discrepencies in userspace IS possible, but ugly.
> > We do it in musl libc for x32 right now -- see:
> > 
> > http://git.musl-libc.org/cgit/musl/tree/arch/x32/syscall_arch.h?id=v1.1.6
> > http://git.musl-libc.org/cgit/musl/tree/arch/x32/src/syscall_cp_fixup.c?id=v1.1.6
> 
> For AArch64 ILP32 I would rather see the fix-ups in kernel wrappers.
> 
> Are you aware of other cases like this?

For musl x32, the only other thing we had to work around with code was:

http://git.musl-libc.org/cgit/musl/tree/arch/x32/src/sysinfo.c?id=v1.1.6

However, code was mostly only needed where the data is being passed
from userspace to the kernel; for the other direction, most of the
discrepencies were handled simply by defining structures with extra
32-bit padding fields next to their 32-bit longs. I'm including below
a diff of our arch/x86_64/bits versus arch/x32/bits trees to
demonstrate the changes made.

Rich



--- arch/x86_64/bits/alltypes.h.in
+++ arch/x32/bits/alltypes.h.in
@@ -1,12 +1,12 @@
-#define _Addr long
-#define _Int64 long
-#define _Reg long
+#define _Addr int
+#define _Int64 long long
+#define _Reg long long
 
 TYPEDEF __builtin_va_list va_list;
 TYPEDEF __builtin_va_list __isoc_va_list;
 
 #ifndef __cplusplus
-TYPEDEF int wchar_t;
+TYPEDEF long wchar_t;
 #endif
 
 #if defined(__FLT_EVAL_METHOD__) && __FLT_EVAL_METHOD__ == 2
@@ -19,8 +19,8 @@
 
 TYPEDEF struct { long long __ll; long double __ld; } max_align_t;
 
-TYPEDEF long time_t;
-TYPEDEF long suseconds_t;
+TYPEDEF long long time_t;
+TYPEDEF long long suseconds_t;
 
 TYPEDEF struct { union { int __i[14]; unsigned long __s[7]; } __u; } pthread_attr_t;
 TYPEDEF struct { union { int __i[10]; volatile void *volatile __p[5]; } __u; } pthread_mutex_t;
--- arch/x86_64/bits/ipc.h
+++ arch/x32/bits/ipc.h
@@ -7,8 +7,8 @@
 	gid_t cgid;
 	mode_t mode;
 	int __ipc_perm_seq;
-	long __pad1;
-	long __pad2;
+	long long __pad1;
+	long long __pad2;
 };
 
 #define IPC_64 0
--- arch/x86_64/bits/limits.h
+++ arch/x32/bits/limits.h
@@ -1,8 +1,8 @@
 #if defined(_POSIX_SOURCE) || defined(_POSIX_C_SOURCE) \
  || defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE) || defined(_BSD_SOURCE)
 #define PAGE_SIZE 4096
-#define LONG_BIT 64
+#define LONG_BIT 32
 #endif
 
-#define LONG_MAX  0x7fffffffffffffffL
+#define LONG_MAX  0x7fffffffL
 #define LLONG_MAX  0x7fffffffffffffffLL
--- arch/x86_64/bits/msg.h
+++ arch/x32/bits/msg.h
@@ -5,9 +5,12 @@
 	time_t msg_rtime;
 	time_t msg_ctime;
 	unsigned long msg_cbytes;
+	long __unused1;
 	msgqnum_t msg_qnum;
+	long __unused2;
 	msglen_t msg_qbytes;
+	long __unused3;
 	pid_t msg_lspid;
 	pid_t msg_lrpid;
-	unsigned long __unused[2];
+	unsigned long long __unused[2];
 };
--- arch/x86_64/bits/reg.h
+++ arch/x32/bits/reg.h
@@ -1,5 +1,5 @@
 #undef __WORDSIZE
-#define __WORDSIZE 64
+#define __WORDSIZE 32
 #define R15    0
 #define R14    1
 #define R13    2
--- arch/x86_64/bits/setjmp.h
+++ arch/x32/bits/setjmp.h
@@ -1 +1 @@
-typedef unsigned long __jmp_buf[8];
+typedef unsigned long long __jmp_buf[8];
--- arch/x86_64/bits/shm.h
+++ arch/x32/bits/shm.h
@@ -10,17 +10,24 @@
 	pid_t shm_cpid;
 	pid_t shm_lpid;
 	unsigned long shm_nattch;
-	unsigned long __pad1;
-	unsigned long __pad2;
+	unsigned long __pad0;
+	unsigned long long __pad1;
+	unsigned long long __pad2;
 };
 
 struct shminfo {
-	unsigned long shmmax, shmmin, shmmni, shmseg, shmall, __unused[4];
+	unsigned long shmmax, __pad0, shmmin, __pad1, shmmni, __pad2,
+	              shmseg, __pad3, shmall, __pad4;
+	unsigned long long __unused[4];
 };
 
 struct shm_info {
 	int __used_ids;
-	unsigned long shm_tot, shm_rss, shm_swp;
-	unsigned long __swap_attempts, __swap_successes;
-};
-
+	int __pad_ids;
+	unsigned long shm_tot, __pad0, shm_rss, __pad1, shm_swp, __pad2;
+	unsigned long __swap_attempts, __pad3, __swap_successes, __pad4;
+}
+#ifdef __GNUC__
+__attribute__((__aligned__(8)))
+#endif
+;
--- arch/x86_64/bits/signal.h
+++ arch/x32/bits/signal.h
@@ -42,12 +42,12 @@
 	unsigned padding[24];
 } *fpregset_t;
 struct sigcontext {
-	unsigned long r8, r9, r10, r11, r12, r13, r14, r15;
-	unsigned long rdi, rsi, rbp, rbx, rdx, rax, rcx, rsp, rip, eflags;
+	unsigned long long r8, r9, r10, r11, r12, r13, r14, r15;
+	unsigned long long rdi, rsi, rbp, rbx, rdx, rax, rcx, rsp, rip, eflags;
 	unsigned short cs, gs, fs, __pad0;
-	unsigned long err, trapno, oldmask, cr2;
+	unsigned long long err, trapno, oldmask, cr2;
 	struct _fpstate *fpstate;
-	unsigned long __reserved1[8];
+	unsigned long long __reserved1[8];
 };
 typedef struct {
 	gregset_t gregs;
@@ -56,7 +56,7 @@
 } mcontext_t;
 #else
 typedef struct {
-	unsigned long __space[32];
+	unsigned long long __space[32];
 } mcontext_t;
 #endif
 
@@ -72,7 +72,7 @@
 	stack_t uc_stack;
 	mcontext_t uc_mcontext;
 	sigset_t uc_sigmask;
-	unsigned long __fpregs_mem[64];
+	unsigned long long __fpregs_mem[64];
 } ucontext_t;
 
 #define SA_NOCLDSTOP  1
--- arch/x86_64/bits/stat.h
+++ arch/x32/bits/stat.h
@@ -18,5 +18,5 @@
 	struct timespec st_atim;
 	struct timespec st_mtim;
 	struct timespec st_ctim;
-	long __unused[3];
+	long long __unused[3];
 };
--- arch/x86_64/bits/statfs.h
+++ arch/x32/bits/statfs.h
@@ -1,7 +1,9 @@
 struct statfs {
-	unsigned long f_type, f_bsize;
+	unsigned long f_type, __pad0, f_bsize, __pad1;
 	fsblkcnt_t f_blocks, f_bfree, f_bavail;
 	fsfilcnt_t f_files, f_ffree;
 	fsid_t f_fsid;
-	unsigned long f_namelen, f_frsize, f_flags, f_spare[4];
+	unsigned long f_namelen, __pad2, f_frsize, __pad3;
+	unsigned long f_flags, __pad4;
+	unsigned long long f_spare[4];
 };
--- arch/x86_64/bits/stdint.h
+++ arch/x32/bits/stdint.h
@@ -12,9 +12,9 @@
 #define UINT_FAST16_MAX UINT32_MAX
 #define UINT_FAST32_MAX UINT32_MAX
 
-#define INTPTR_MIN      INT64_MIN
-#define INTPTR_MAX      INT64_MAX
-#define UINTPTR_MAX     UINT64_MAX
-#define PTRDIFF_MIN     INT64_MIN
-#define PTRDIFF_MAX     INT64_MAX
-#define SIZE_MAX        UINT64_MAX
+#define INTPTR_MIN      INT32_MIN
+#define INTPTR_MAX      INT32_MAX
+#define UINTPTR_MAX     UINT32_MAX
+#define PTRDIFF_MIN     INT32_MIN
+#define PTRDIFF_MAX     INT32_MAX
+#define SIZE_MAX        UINT32_MAX
