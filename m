From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Dec 2016 15:10:19 +0000
Subject: [PATCH 09/18] arm64: introduce binfmt_elf32.c
In-Reply-To: <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20161205151018.GD14429@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 11:33:08PM +0300, Yury Norov wrote:
> As we support more than one compat formats, it looks more reasonable
> to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
> specific definitions there and make code more maintainable and readable.

Can you remind me why we need this patch (rather than using the default
fs/compat_binfmt_elf.c which you include here anyway)?

> --- /dev/null
> +++ b/arch/arm64/kernel/binfmt_elf32.c
> @@ -0,0 +1,31 @@
> +/*
> + * Support for AArch32 Linux ELF binaries.
> + */
> +
> +/* AArch32 EABI. */
> +#define EF_ARM_EABI_MASK		0xff000000
> +
> +#define compat_start_thread		compat_start_thread
> +#define COMPAT_SET_PERSONALITY(ex)		\
> +do {						\
> +	clear_thread_flag(TIF_32BIT_AARCH64);	\
> +	set_thread_flag(TIF_32BIT);		\
> +} while (0)

You introduce this here but it seems to still be present in asm/elf.h.

-- 
Catalin
