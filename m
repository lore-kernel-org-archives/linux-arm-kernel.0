From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 26 Jan 2015 13:49:19 -0800
Subject: [PATCH 2/5] syscalls: Declare sys_*stat64 prototypes if
 __ARCH_WANT_(COMPAT_)STAT64
In-Reply-To: <1420819048-3515-3-git-send-email-catalin.marinas@arm.com>
References: <1420819048-3515-1-git-send-email-catalin.marinas@arm.com>
 <1420819048-3515-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20150126134919.ea59b69ae1c0b62188bdbdd0@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Jan 2015 15:57:25 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Currently, the sys_stat64, sys_fstat64 and sys_lstat64 prototpyes are
> only declared if BITS_PER_LONG == 32. Following commit 0753f70f07fb
> (fs: Build sys_stat64() and friends if __ARCH_WANT_COMPAT_STAT64), the
> implementation of these functions is allowed on 64-bit systems for
> compat support. The patch changes the condition on the prototype
> declaration from BITS_PER_LONG == 32 to defined(__ARCH_WANT_STAT64) ||
> defined(__ARCH_WANT_COMPAT_STAT64).
> 
> In addition, it moves the sys_fstatat64 prototype under the same #if
> block
> 
> ...
>
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -410,12 +410,16 @@ asmlinkage long sys_newlstat(const char __user *filename,
>  				struct stat __user *statbuf);
>  asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
>  asmlinkage long sys_ustat(unsigned dev, struct ustat __user *ubuf);
> -#if BITS_PER_LONG == 32
> +#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
>  asmlinkage long sys_stat64(const char __user *filename,
>  				struct stat64 __user *statbuf);
>  asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
>  asmlinkage long sys_lstat64(const char __user *filename,
>  				struct stat64 __user *statbuf);
> +asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
> +			       struct stat64 __user *statbuf, int flag);
> +#endif
> +#if BITS_PER_LONG == 32
>  asmlinkage long sys_truncate64(const char __user *path, loff_t length);
>  asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);

ack.  sys_stat64() and friends are already conditional on
__ARCH_WANT_STAT64) && __ARCH_WANT_COMPAT_STAT64.  I'm a bit
surprised that the current code didn't break.
