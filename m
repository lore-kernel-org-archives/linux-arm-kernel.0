From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Dec 2015 23:31:57 +0100
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201512212331.58152.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015, Yury Norov wrote:
> +
> +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> +#define compat_sys_openat              sys_openat
> +

One more thing I just remembered: I think we want this behavior for all new
32-bit architectures, it was a bug to call compat_sys_openat for the generic
syscall table, as we don't support 32-bit off_t.

Could you split this out into a separate patch that does these changes:

- change the default asm-generic/unistd.h to use sys_openat/sys_open_by_handle_at
- change tile to override those two to keep the current (suboptimal) behavior
- change the force_o_largefile() definition so it defaults to true for all future
  architectures. The easiest way is probably to add a Kconfig symbol for this
  that gets selected by all 32-bit architectures, so we can use

#define force_o_largefile() ((BITS_PER_LONG != 32) || !IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))

	Arnd
