From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Nov 2015 15:33:24 +0100
Subject: [PATCH v6 01/17] arm64:ilp32: add documentation on the ILP32 ABI
 for ARM64
In-Reply-To: <1446507046-24604-2-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-2-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <6849878.g4juXb5ikg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 02:30:30 Yury Norov wrote:
> From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> 
> Based on Andrew Pinski's original patch-series and adapted with changes
> to reduce the duplication of code-paths and resolve issue found during
> LTP testing.
> 
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> Reviewed-by: David Daney <david.daney@cavium.com>

Thanks for the updated version, I'm much happier with this, and only have
some comments on a few details to the later patches.

> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic linux syscall interface.
> +
> +Some structures are changed to reduce the difference in the code path
> +for both ILP32 and LP64 ABIs for signal handling.
> +
> +The following structures have been changed so the layout of the
> +structures are the same between ILP32 and LP64 ABIs, including:
> + * sigval_t        contains pointers
> + * sigevent        Uses sigval_t which causes it to be the same.  Special
> +                   handing is needed for reading; in the mq_notify syscall
> + * sigaction       Conversion is handled in the userland (glibc), as the
> +		    userland data structures are defined in glibc anyway.

Right, makes sense.

> +A number of structures differ between ILP32 and LP64, including:
> + * timespec        uses time_t and suseconds_t
> + * timeval         uses time_t and suseconds_t
> + * stat            uses timespec/time_t

As I commented, we might want to change this for 'stat', which doesn't
really time_t anyway.

> + * semid64_ds      uses time_t.
> + * msqid64_ds      uses time_t.
> + * shmid64_ds      uses time_t.

These use the arm32 layout, right? That's good for consistency.
Fixing these for y2038 will be a bit ugly, but that code can be
shared across all architectures.

> + * rt_sigframe     uses siginfo and ucontext.
> + * siginfo_t       uses clock_t and sigval_t
> + * ucontext        uses stack_t and sigset_t
> + * fd_set          This is done to avoid endian issues between ILP32 and
> +		   LP64. Syscalls consuming fd_set use timespec.
> + * struct msgbuf   The specification of 'struct msgbuf' defines the 'mtype'
> +                   field as a 'long' (i.e. 32bit for ILP32, but 64bit for
> +		   LP64).  Functions that operate on 'struct msgbuf' need
> +		   to be passed through the compat-syscalls to resolve
> +		   this.
> + * stack_t         contains pointers (handled in the compatibility layer)
> +
> +Also the syscalls which normally would pass 64bit values as two arguments;
> +now pass the 64bit value as one argument.  Also they have been renamed
> +(removing the 64 from the name) to avoid confusion.
> +The list of these LP64 syscalls reused by ILP32 clients is:
> + * fcntl
> + * statfs
> + * fstatfs

Did you forget to edit this list? I see fcntl and {f,}statfs use the compat
implementation, not the native one in your patches.

> + * truncate
> + * ftruncate
> + * lseek
> + * sendfile
> + * fadvise64

Makes sense. I think using the normal compat syscalls would have been
just as good here, to save a few lines in the syscall table, but I
agree that the calling conventions are rather silly when you pass
a 64-bit number in two registers.

> + * newfstatat
> + * fstat

This contradicts what you write above regarding separate 'struct stat'.

> + * mmap

Not direct reuse because of the wrapper to check the page size I guess.
Aside from the wrapper, the 32-bit and 64-bit system calls are basically
identical.

	Arnd
