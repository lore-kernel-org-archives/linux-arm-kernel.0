From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 17:07:15 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <3828111.AFlzLO4Qgd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 00:42:38 Yury Norov wrote:
> +/* Using non-compat syscalls where necessary */
> +#define compat_sys_fadvise64_64        sys_fadvise64_64
> +#define compat_sys_fallocate           sys_fallocate
> +#define compat_sys_ftruncate64         sys_ftruncate
> +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
> +#define compat_sys_pread64             sys_pread64
> +#define compat_sys_pwrite64            sys_pwrite64
> +#define compat_sys_readahead           sys_readahead
> +#define compat_sys_shmat               sys_shmat
> +#define compat_sys_sigaltstack         sys_sigaltstack
> +#define compat_sys_sync_file_range     sys_sync_file_range
> +#define compat_sys_truncate64          sys_truncate
> +#define sys_llseek                     sys_lseek
> +
> +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> +#define compat_sys_openat              sys_openat

Very nice and short list now!

I've double-checked all calls and the only one I'm not sure about is
sys_sigaltstack. Did we discuss that one earlier?
My first guess would be that it's easier to use the compat
version of that.

I would probably also group sys_shmat with sys_openat, because it's
different from the other ones in the first block as this is not
about passing 64-bit arguments as registers, but instead it's about
the behavior of the system call.

	Arnd
