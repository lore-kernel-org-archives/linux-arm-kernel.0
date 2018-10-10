From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Wed, 10 Oct 2018 15:39:07 +0100
Subject: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <20181010141017.GA2881@asgard.redhat.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
Message-ID: <7aac1a08-8948-1a04-cbd3-fbc6a53f9ff0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/18 15:10, Eugene Syromiatnikov wrote:
>  * What's the reasoning behind capping syscall arguments to 32 bit? x32
>    and MIPS N32 do not have such a restriction (and do not need special
>    wrappers for syscalls that pass 64-bit values as a result, except
>    when they do,  as it is the case for preadv2 on x32); moreover, that
>    would lead to insurmountable difficulties for AArch64 ILP32 tracers
>    that try to trace LP64 tracees, as it would be impossible to pass
>    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.

but that's necessarily the case for all ilp32 abis:
the userspace syscall function receives 32bit
arguments so even if the kernel abi takes 64bit
args you cannot use that from c code. (the libc
does not even know which args should be sign or
zero extended.)

process_vm_readv/writev is limited by the ilp32
iovec struct, not by the syscall arguments.

ptrace is specified to take void* addr argument,
and void* is 32bit on all ilp32 targets.
so again on the c language level there is no
way around the 32bit limitation.
