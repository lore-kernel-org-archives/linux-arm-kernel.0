From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Apr 2015 23:01:06 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <2507322.zX46IY7aRK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 April 2015 21:44:10 Philipp Tomsich wrote:
> If anybody wants to rerun LTP, let me know, so I can provide a
> buildroot-generated rootfs-image via FTP.
> 
> The key differences from earlier changesets are:
>  * updated to 4.0
>  * fixes for functions using 'struct msgbuf' (using compat)
>  * deduplication of code by using a 32bit stack_t (using compat)
>  * updated the documentation to clarify the changes to stack_t
>  * introduced a sub-architecture (via COMPAT_ELF_PLATFORM) to make
>    life easier for tools (e.g. gdb) when attaching to a live process
>    (a corefile is easily distinguishable by being ELFCLASS32).
> 
> Any review comments are welcome.
 
Hi Philipp,

Thanks for picking up these patches again. I have had a lot of conversations about
them recently, and have two very broad issues that we need to resolve before
merging them:

1. Adding a whole new ABI to the kernel is adding a long-term maintenance
burden, and we don't want to do that just because someone thinks it's a cute
hack or because it might add a few percent in performance of some low-level
benchmark. Please describe in the cover-letter for the patch series
specifically what applications you have in mind that would be using this, and
what the expected timeframe is before users could move to 64-bit user space.

2. The ABI follows what x86 has their "x32" ABI. This never saw a lot of
adoption and in retrospect the decision to have separate system calls seems
to not have helped them. My feeling now is that if we add support for the
ARM64 ILP32 ELF ABI, we should better stick to the existing system call ABI
as close as possible and reuse the existing system call table. I realize
that this is a bit controversial, but please let's talk about this now.

The most important aspect here I think is time_t, and while it means starting
out with a system call ABI that is not ready for y2038, at the same time the
purpose of ILP32 support is to support legacy source code that is not 64-bit
safe now, and using 32-bit time_t will make that easier in a lot of ways.
Note that I am also leading the effort to make 32-bit Linux ready for using
64-bit time_t on all architectures, so ARM64 ILP32 will be fixed as well, it
just won't be any better or worse than the others.

	Arnd
