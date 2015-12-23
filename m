From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Dec 2015 13:37:36 +0000
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <201512222244.15155.arnd@arndb.de>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-14-git-send-email-ynorov@caviumnetworks.com>
 <20151222122514.GA1302@e104818-lin.cambridge.arm.com>
 <201512222244.15155.arnd@arndb.de>
Message-ID: <20151223133736.GB28445@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:44:14PM +0100, Arnd Bergmann wrote:
> On Tuesday 22 December 2015, Catalin Marinas wrote:
> > > +
> > > +ENTRY(compat_sys_statfs64_wrapper)
> > > +     mov     w3, #84
> > > +     cmp     w1, #88
> > > +     csel    w1, w3, w1, eq
> > > +     b       compat_sys_statfs64
> > > +ENDPROC(compat_sys_statfs64_wrapper)
> > > +
> > > +ENTRY(compat_sys_fstatfs64_wrapper)
> > > +     mov     w3, #84
> > > +     cmp     w1, #88
> > > +     csel    w1, w3, w1, eq
> > > +     b       compat_sys_fstatfs64
> > > +ENDPROC(compat_sys_fstatfs64_wrapper)
> > 
> > I'm not convinced we need these wrappers for ILP32. They've been
> > introduced on arch/arm many years ago by commit Fixes: 713c481519f1
> > ([ARM] 3108/2: old ABI compat: statfs64 and fstatfs64) to deal with user
> > space passing a size of 88 (the EABI size of struct compat_statfs64
> > without the packing and alignment attribute). Since that commit, the
> > sizeof(struct compat_statfs64) is 84 already. This should be the case
> > with the new ILP32 exported headers (no backwards compatibility), so
> > user space should never pass 88 as size. Therefore we could call
> > compat_sys_(f)statfs64 directly without wrappers.
> 
> That means we have to set ARCH_PACK_STATFS64 in the arm64 header files
> though, and propagate the OABI alignment to arm64/ilp32 as well, rather
> than using the 88-byte version that every other 32-bit architecture
> except for x86-32 and arm32 has.

Yuri replied that for EABI glibc, sizeof(struct statfs64) is already 88.
If that's correct and the packing attribute is ignored by glibc, we
could drop ARCH_PACK_COMPAT_STATFS64 as well (OABI not supported by
arm64). But I would be slightly worried since glibc is not the only user
of the kernel ABI.

For ILP32, I think we can skip defining ARCH_PACK_STATFS64 (of course,
only if __ILP32__) and state that sizeof(struct statfs64) is 88
(unpacked). In which case we need the wrappers above to be able to reuse
the compat_sys_statfs64 code.

> Another option would be to set "#define __statfs_word __u64" and use
> the 64-bit statfs call, instead of compat_sys_statfs64, but that in turn
> requires special-casing statfs in libc.

I wouldn't go this route as we kind of agreed that ILP32 should look
like any other 32-bit ABI.

-- 
Catalin
