From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 May 2016 22:26:54 +0200
Subject: [PATCH 18/23] arm64: ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <1464048292-30136-19-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-19-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <4731114.hBXBvkC8xh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 24, 2016 3:04:47 AM CEST Yury Norov wrote:
> +static unsigned long compat_sys_mmap2(compat_uptr_t addr, compat_size_t len,
> +       int prot, int flags, int fd, off_t pgoff)
> +{
> +       if (pgoff & (~PAGE_MASK >> 12))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +                      pgoff >> (PAGE_SHIFT - 12));
> +}
> +
> +static unsigned long compat_sys_pread64(unsigned int fd,
> +               compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
> +{
> +       return sys_pread64(fd, (char *) ubuf, count, offset);
> +}
> +
> +static unsigned long compat_sys_pwrite64(unsigned int fd,
> +               compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
> +{
> +       return sys_pwrite64(fd, (char *) ubuf, count, offset);
> +}
> 

The use of compat_uptr_t seems inconsistent here, and neither of the two
ways of doing it is what we do elsewhere. compat_uptr_t is meant to
be a scalar 32-bit type that gets converted into a pointer using the
compat_ptr() macro, so compat_sys_mmap2 should not use compat_ptr_t
(we don't access it as a pointer in mmap_pgoff) but compat_ulong_t,
and compat_sys_pread64() should have a compat_uptr_t argument, not
pointer to compat_uptr_t.

	Arnd
