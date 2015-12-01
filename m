From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Dec 2015 00:29:04 +0300
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3754277.KmO9Nk3XLD@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel>
Message-ID: <20151201212904.GA14442@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +#define compat_sys_shmat               sys_shmat
> 
> What's special about compat_sys_shmat?
> 

It's about SHMLBA definition.
For aarch32 glibc defines it as (__getpagesize () << 2).
For ILP32 there's no definition, and so generic one is used: (__getpagesize ()).

In kernel, for ARM64, COMPAT_SHMLBA defined just as 0x4000. Both
compat and non-compat shmat syscalls pass identical arguments to
do_shmat, except shmlba. Effectively, library expects shmlba to
be 0x1000, as sys_shmat does. And compat_sys_shmat expects 0x4000.

I think, both kernel and library parts are to be fixed. In library
we'd use definition identical to ARM. For kernel we'd use compat
syscall.

My question. Why aarch64 defines COMPAT_SHMLBA as 0x4000? If there's
no specific reason for it, it looks like a bug, and we should
define it like in arch/arm:
        #define SHMLBA  (4 * PAGE_SIZE)          /* attach addr a multiple of this */

Maybe that's why AARCH32 is limited to 4K pages in config.
