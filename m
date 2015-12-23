From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Dec 2015 21:41:54 +0100
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <20151223133736.GB28445@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <201512222244.15155.arnd@arndb.de>
 <20151223133736.GB28445@e104818-lin.cambridge.arm.com>
Message-ID: <201512232141.54384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 December 2015, Catalin Marinas wrote:
> > That means we have to set ARCH_PACK_STATFS64 in the arm64 header files
> > though, and propagate the OABI alignment to arm64/ilp32 as well, rather
> > than using the 88-byte version that every other 32-bit architecture
> > except for x86-32 and arm32 has.
> 
> Yuri replied that for EABI glibc, sizeof(struct statfs64) is already 88.
> If that's correct and the packing attribute is ignored by glibc, we
> could drop ARCH_PACK_COMPAT_STATFS64 as well (OABI not supported by
> arm64). But I would be slightly worried since glibc is not the only user
> of the kernel ABI.

It looks like glibc has its own definition of 'struct statfs64', which
is incompatible with the one in the kernel headers for ARM EABI.

However, there are other libc implementations besides glibc, and we
can't assume that they all do it the same way, so we clearly have to
keep using the wrapper for ARM EABI. For ARM64/ILP32, we are probably
better off defining it the same way in kernel and libc without that
wrapper.

> For ILP32, I think we can skip defining ARCH_PACK_STATFS64 (of course,
> only if __ILP32__) and state that sizeof(struct statfs64) is 88
> (unpacked). In which case we need the wrappers above to be able to reuse
> the compat_sys_statfs64 code.
> 
> > Another option would be to set "#define __statfs_word __u64" and use
> > the 64-bit statfs call, instead of compat_sys_statfs64, but that in turn
> > requires special-casing statfs in libc.
> 
> I wouldn't go this route as we kind of agreed that ILP32 should look
> like any other 32-bit ABI.

It's really tricky then: in order to support EABI binaries from a libc
that uses the kernel headers with the OABI compatible definition, we
must not copy the 88 byte structure to user space, because that would
overwrite user space stack data, and that in turn means we have to set
ARCH_PACK_COMPAT_STATFS64, but that in turn prevents us from using the
generic 32-bit syscall ABI for the arm64/ilp32 fstatfs64 call. 

It seems that today, put_compat_statfs64() doesn't actually use
the size argument, and it just copies the individual fields, which
is fine either way. This means we could turn around the logic
in the arm32 wrapper, remove ARCH_PACK_COMPAT_STATFS64, and make
the ilp32 code call directly into compat_sys_fstatfs64(), but it
would be a bit fragile, as we rely on put_compat_statfs64() not
actually writing the padding fields that the native do_statfs64()
writes. If someone changed them to both use copy_to_user, we'd
silently introduce data corruption on rarely used libc implementations.

	Arnd
