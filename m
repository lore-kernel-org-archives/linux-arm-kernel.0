From: schwab@suse.de (Andreas Schwab)
Date: Mon, 27 Jun 2016 09:47:38 +0200
Subject: [PATCH 01/19] compat ABI: use non-compat openat and
 open_by_handle_at variants
In-Reply-To: <1466207668-10549-2-git-send-email-ynorov@caviumnetworks.com>
 (Yury Norov's message of "Sat, 18 Jun 2016 02:54:10 +0300")
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-2-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <mvmwplbkr8l.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> The only difference is that non-compat version forces O_LARGEFILE,
> and it should be the default behaviour for all architectures, as
> we don't support 32-bit off_t. The only exception is tile32, that
> continues with compat version of syscalls.
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]
> ---
>  arch/tile/kernel/compat.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
> index 4912084..489ae19 100644
> --- a/arch/tile/kernel/compat.c
> +++ b/arch/tile/kernel/compat.c
> @@ -94,6 +94,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
>  #define compat_sys_readahead sys32_readahead
>  #define sys_llseek compat_sys_llseek
>  
> +#define sys_openat		compat_sys_openat
> +#define sys_open_by_handle_at	compat_sys_open_by_handle_at
> +
>  /* Call the assembly trampolines where necessary. */
>  #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
>  #define sys_clone _sys_clone

This is a no-op.  Did you mean to add this?  Without that the testsuite
of tar fails on ILP32.

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a26415b..4dcc38d 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -178,7 +178,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -676,8 +676,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 #define __NR_clock_adjtime 266
 __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
 #define __NR_syncfs 267
-- 
2.9.0


Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
