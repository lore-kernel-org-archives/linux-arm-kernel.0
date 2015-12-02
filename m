From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 09:37:05 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151201233503.GA23156@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <12844690.Yr8y3jA010@wuerfel> <20151201233503.GA23156@yury-N73SV>
Message-ID: <1712431.VUth4NvudT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 02:35:03 Yury Norov wrote:
> On Tue, Dec 01, 2015 at 11:39:42PM +0100, Arnd Bergmann wrote:
> > On Wednesday 02 December 2015 00:29:04 Yury Norov wrote:
> > I'm not sure I understand this part. What changes specifically do we need?
> > 
> 
> For kernel:
> 
>         diff --git a/arch/arm64/include/asm/shmparam.h b/arch/arm64/include/asm/shmparam.h
>         index 4df608a..e368a55 100644
>         --- a/arch/arm64/include/asm/shmparam.h
>         +++ b/arch/arm64/include/asm/shmparam.h
>         @@ -21,7 +21,7 @@
>           * alignment value. Since we don't have aliasing D-caches, the rest of
>           * the time we can safely use PAGE_SIZE.
>           */
>         -#define COMPAT_SHMLBA	0x4000
>         +#define COMPAT_SHMLBA	(4 * PAGE_SIZE)
>          
>          #include <asm-generic/shmparam.h>
>          
>         diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
>         index c5bc712..877bedf 100644
>         --- a/arch/arm64/kernel/sys_ilp32.c
>         +++ b/arch/arm64/kernel/sys_ilp32.c
>         @@ -42,15 +42,12 @@ asmlinkage long sys_rt_sigreturn_wrapper(void);
>          #define compat_sys_pwrite64            sys_pwrite64
>          #define compat_sys_readahead           sys_readahead
>          #define compat_sys_rt_sigaction        sys_rt_sigaction
>         -#define compat_sys_shmat               sys_shmat
>          #define compat_sys_sync_file_range     sys_sync_file_range
>          #define compat_sys_truncate64          sys_truncate
>          #define compat_sys_sigaltstack         sys_sigaltstack
>  
> For library - just create a header in ilp32 directory that defines
> SHMLBA exactly as arm: __getpagesize () << 2

I think we both reversed our positions here ;-)

The 4*PAGE_SIZE on ARM is an architecture specific oddity, I believe
to work around aliasing caches on ARMv6. As no other architecture does
this, we're probably better off not duplicating it for aarch64-ilp32
and just use sys_shmat as your v6 patch does.

> > It sounds like shmat is one of the cases we an override makes sense
> > and we should use sys_shmat with PAGE_SIZE for aarch64 ilp32 mode.
> > 
> 
> [...]
> 
> > We normally assume that the page size on ARM is fixed to 4K, so
> > there might be user space that just hardcodes 16K SHMLBA 
> 
> It means that we should use compat_sys_shmat because hardcoded
> userspace may have a chance to work for 4K pages. If we'll use
> sys_shmat (and so 4K SHMLBA), we'll definitely make hardcoded
> userspace broken. Non-hardcoded userspace will work anyway.
> 
> We can describe in documentation that 4k pages are prefferable.

The hardcoded user space would only apply to old source code that
specifically tries to adapt to what ARM does, but gets it wrong,
If we have source code that is converted from x86 or mips and
hardcodes anything, it's more likely to be the normal __getpagesize().

	Arnd
