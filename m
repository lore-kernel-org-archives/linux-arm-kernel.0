From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 23:39:42 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151201212904.GA14442@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel> <20151201212904.GA14442@yury-N73SV>
Message-ID: <12844690.Yr8y3jA010@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 00:29:04 Yury Norov wrote:
> > > +#define compat_sys_shmat               sys_shmat
> > 
> > What's special about compat_sys_shmat?
> > 
> 
> It's about  	 definition.
> For aarch32 glibc defines it as (__getpagesize () << 2).
> For ILP32 there's no definition, and so generic one is used: (__getpagesize ()).

Ok, got it.

> In kernel, for ARM64, COMPAT_SHMLBA defined just as 0x4000. Both
> compat and non-compat shmat syscalls pass identical arguments to
> do_shmat, except shmlba. Effectively, library expects shmlba to
> be 0x1000, as sys_shmat does. And compat_sys_shmat expects 0x4000.
> 
> I think, both kernel and library parts are to be fixed. In library
> we'd use definition identical to ARM. For kernel we'd use compat
> syscall.

I'm not sure I understand this part. What changes specifically do we need?

It sounds like shmat is one of the cases we an override makes sense
and we should use sys_shmat with PAGE_SIZE for aarch64 ilp32 mode.

> My question. Why aarch64 defines COMPAT_SHMLBA as 0x4000? If there's
> no specific reason for it, it looks like a bug, and we should
> define it like in arch/arm:
>         #define SHMLBA  (4 * PAGE_SIZE)          /* attach addr a multiple of this */
> 
> Maybe that's why AARCH32 is limited to 4K pages in config.

The reason why AARCH32 is limited to 4K pages is the alignment of
ELF sections, and with newer binutils versions, that is no longer
a problem, other than the bug you just found.

We normally assume that the page size on ARM is fixed to 4K, so
there might be user space that just hardcodes 16K SHMLBA rather
than using the glibc (__getpagesize () << 2) definition. Changing
the kernel would break those programs, but you can also argue that
they are already broken today.

	Arnd
