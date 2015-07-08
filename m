From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Wed, 8 Jul 2015 08:46:07 +0200
Subject: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
In-Reply-To: <1436288623-13007-3-git-send-email-emunson@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
Message-ID: <20150708064607.GB7079@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 01:03:40PM -0400, Eric B Munson wrote:
> With the refactored mlock code, introduce new system calls for mlock,
> munlock, and munlockall.  The new calls will allow the user to specify
> what lock states are being added or cleared.  mlock2 and munlock2 are
> trivial at the moment, but a follow on patch will add a new mlock state
> making them useful.
> 
> munlock2 addresses a limitation of the current implementation.  If a
> user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> that MCL_FUTURE should be removed, they would have to call munlockall()
> followed by mlockall(MCL_CURRENT) which could potentially be very
> expensive.  The new munlockall2 system call allows a user to simply
> clear the MCL_FUTURE flag.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>

...

> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
> index 1acad02..f6d81d6 100644
> --- a/arch/s390/kernel/syscalls.S
> +++ b/arch/s390/kernel/syscalls.S
> @@ -363,3 +363,6 @@ SYSCALL(sys_bpf,compat_sys_bpf)
>  SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
>  SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
>  SYSCALL(sys_execveat,compat_sys_execveat)
> +SYSCALL(sys_mlock2,compat_sys_mlock2)			/* 355 */
> +SYSCALL(sys_munlock2,compat_sys_munlock2)
> +SYSCALL(sys_munlockall2,compat_sys_munlockall2)

FWIW, you would also need to add matching lines to the two files

arch/s390/include/uapi/asm/unistd.h
arch/s390/kernel/compat_wrapper.c

so that the system call would be wired up on s390.
