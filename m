From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Dec 2015 18:27:53 +0000
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151217182753.GF25232@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:38AM +0300, Yury Norov wrote:
> +/* Using non-compat syscalls where necessary */
> +#define compat_sys_fadvise64_64        sys_fadvise64_64
> +#define compat_sys_fallocate           sys_fallocate
> +#define compat_sys_ftruncate64         sys_ftruncate

I initially thought this should be sys_ftruncate64 (or a wrapper to pass
small == 0) but we rely on sys_openat to set O_LARGEFILE.

arch/arm has ftruncate and ftruncate64, but it looks like we route both
via sys_ftruncate(). The difference is the "small" argument which
imposes a limit on the length without O_LARGEFILE, so we may have a bug
here.

> +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
> +#define compat_sys_pread64             sys_pread64
> +#define compat_sys_pwrite64            sys_pwrite64
> +#define compat_sys_readahead           sys_readahead
> +#define compat_sys_shmat               sys_shmat

I wonder whether we need wrappers (actually, not only for these but
sys_read etc.). These functions take either a pointer or a size_t
argument which are 32-bit with ILP32 but treated as 64-bit by an LP64
kernel. Can we guarantee that user space zeros the top 32-bit of the
arguments passed here?

With compat/AArch32, this is guaranteed by the kernel since EL0 won't be
able to touch the top part but here I'm not entirely sure. As long as
user space used Wn registers for 32-bit types, we are probably fine (the
architecture guarantees the top 32-bit zeroing following a MOV, LDR etc.
instruction into a Wn register). We just need to mention this in the ABI
document (ilp32.txt).

> +#define compat_sys_sigaltstack         sys_sigaltstack

I think Arnd is right here in using the compat function. The stack_t
would differ between LP64 and ILP32. compat_sys_sigaltstack() uses
compat_user_stack_pointer() but this should work correctly as it checks
pt_regs for the right mode.

> +#define compat_sys_sync_file_range     sys_sync_file_range
> +#define compat_sys_truncate64          sys_truncate
> +#define sys_llseek                     sys_lseek

I think this makes sense since we have 64-bit registers.

> +
> +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> +#define compat_sys_openat              sys_openat

So using sys_openat() forces O_LARGEFILE and we don't have a problem
with (f)truncate. We may have an issue with AArch32 compat though.

-- 
Catalin
