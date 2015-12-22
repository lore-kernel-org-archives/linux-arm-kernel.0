From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 22:44:14 +0100
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <20151222122514.GA1302@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-14-git-send-email-ynorov@caviumnetworks.com>
 <20151222122514.GA1302@e104818-lin.cambridge.arm.com>
Message-ID: <201512222244.15155.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Catalin Marinas wrote:
> > +
> > +ENTRY(compat_sys_statfs64_wrapper)
> > +     mov     w3, #84
> > +     cmp     w1, #88
> > +     csel    w1, w3, w1, eq
> > +     b       compat_sys_statfs64
> > +ENDPROC(compat_sys_statfs64_wrapper)
> > +
> > +ENTRY(compat_sys_fstatfs64_wrapper)
> > +     mov     w3, #84
> > +     cmp     w1, #88
> > +     csel    w1, w3, w1, eq
> > +     b       compat_sys_fstatfs64
> > +ENDPROC(compat_sys_fstatfs64_wrapper)
> 
> I'm not convinced we need these wrappers for ILP32. They've been
> introduced on arch/arm many years ago by commit Fixes: 713c481519f1
> ([ARM] 3108/2: old ABI compat: statfs64 and fstatfs64) to deal with user
> space passing a size of 88 (the EABI size of struct compat_statfs64
> without the packing and alignment attribute). Since that commit, the
> sizeof(struct compat_statfs64) is 84 already. This should be the case
> with the new ILP32 exported headers (no backwards compatibility), so
> user space should never pass 88 as size. Therefore we could call
> compat_sys_(f)statfs64 directly without wrappers.

That means we have to set ARCH_PACK_STATFS64 in the arm64 header files
though, and propagate the OABI alignment to arm64/ilp32 as well, rather
than using the 88-byte version that every other 32-bit architecture
except for x86-32 and arm32 has.

Another option would be to set "#define __statfs_word __u64" and use
the 64-bit statfs call, instead of compat_sys_statfs64, but that in turn
requires special-casing statfs in libc.

	Arnd
