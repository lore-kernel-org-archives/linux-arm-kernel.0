From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 12:03:54 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151202100153.GA21461@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel> <20151202100153.GA21461@yury-N73SV>
Message-ID: <5594882.0HTLvCyrNc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 13:01:53 Yury Norov wrote:
> On Tue, Nov 17, 2015 at 10:57:52PM +0100, Arnd Bergmann wrote:
> 
> It looks, all them are needed.
> 
> > > +asmlinkage long compat_sys_mmap2_wrapper(void);
> > > +#define sys_mmap2                      compat_sys_mmap2_wrapper
> 
> This wrapper checks alignement of pgoff, if page sise is greater than
> 4K

Ok.

> > > +asmlinkage long compat_sys_fstatfs64_wrapper(void);
> > > +#define compat_sys_fstatfs64    compat_sys_fstatfs64_wrapper
> > > +asmlinkage long compat_sys_statfs64_wrapper(void);
> > > +#define compat_sys_statfs64             compat_sys_statfs64_wrapper
> 
> This two hacks fix an alignment issue. I didn't check all details but
> it looks like sizeof(compat_statfs64) is different in kernel and library.
> And this size is passed as 2nd argument to compat syscalls. We can
> handle it in userspace but I don't see any advantage. 

Ah, so it's a hack for OABI compatibility. I wonder if we can just
drop the wrapper and the ARCH_PACK_COMPAT_STATFS64 definition
on arm64 as we don't handle OABI user space anyway.

Maybe it's too risky, when there is someone that added the packing
in user space on EABI after all.
 
> All this handlers are shared between ilp32 and aarch32.
> This is best we came up, as it doesn't add new hacks, but reuses old
> ones...

Ok.

	Arnd
