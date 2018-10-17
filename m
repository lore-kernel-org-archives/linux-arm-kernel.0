From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Wed, 17 Oct 2018 15:06:53 +0100
Subject: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
Message-ID: <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On 02/10/2018 14:12, Andrey Konovalov wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> Right now the kernel is already able to handle user faults with tagged
> pointers, due to these patches:
> 
> 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
>              tagged pointer")
> 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> 	      pointers")
> 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> 	      pointers")
> 
> When passing tagged pointers to syscalls, there's a special case of such a
> pointer being passed to one of the memory syscalls (mmap, mprotect, etc.).
> These syscalls don't do memory accesses but rather deal with memory
> ranges, hence an untagged pointer is better suited.
> 
> This patchset extends tagged pointer support to non-memory syscalls. This
> is done by reusing the untagged_addr macro to untag user pointers when the
> kernel performs pointer checking to find out whether the pointer comes
> from userspace (most notably in access_ok).
> 
> The following testing approaches has been taken to find potential issues
> with user pointer untagging:
> 
> 1. Static testing (with sparse [2] and separately with a custom static
>    analyzer based on Clang) to track casts of __user pointers to integer
>    types to find places where untagging needs to be done.
> 
> 2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
>    a modified syzkaller version that passes tagged pointers to the kernel.
> 
...

I have been thinking a bit lately on how to address the problem of user tagged pointers passed to the kernel through syscalls, and IMHO probably the best way we have to catch them all and make sure that the approach is maintainable in the long term is to introduce shims that tag/untag the pointers passed to the kernel.

In details, what I am proposing can live either in userspace (preferred solution so that we do not have to relax the ABI) or in kernel space and can be summarized as follows:
 - A shim is specific to a syscall and is called by the libc when it needs to invoke the respective syscall.
 - It is required only if the syscall accepts pointers.
 - It saves the tags of a pointers passed to the syscall in memory (same approach if the we are passing a struct that contains pointers to the kernel, with the difference that all the tags of the pointers in the struct need to be saved singularly)
 - Untags the pointers
 - Invokes the syscall
 - Retags the pointers with the tags stored in memory
 - Returns

What do you think?

-- 
Regards,
Vincenzo
