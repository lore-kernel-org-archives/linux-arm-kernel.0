From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Jun 2017 16:24:34 +0100
Subject: [PATCH 19/20] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <20170604120009.342-20-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-20-ynorov@caviumnetworks.com>
Message-ID: <20170608152434.5jgcrk6jisdaqap7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 03:00:08PM +0300, Yury Norov wrote:
> From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> 
> ILP32 VDSO exports following symbols:
>  __kernel_rt_sigreturn;
>  __kernel_gettimeofday;
>  __kernel_clock_gettime;
>  __kernel_clock_getres.
> 
> What shared object to use, kernel selects depending on result of
> is_ilp32_compat_task() in arch/arm64/kernel/vdso.c, so it substitutes
> correct pages and spec.
> 
> Adjusted to move the data page before code pages in sync with
> commit 601255ae3c98 ("arm64: vdso: move data page before code pages")
> 
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> ---
>  arch/arm64/Makefile                           |  3 +
>  arch/arm64/include/asm/vdso.h                 |  6 ++
>  arch/arm64/kernel/Makefile                    |  1 +
>  arch/arm64/kernel/asm-offsets.c               |  7 ++
>  arch/arm64/kernel/signal.c                    |  2 +
>  arch/arm64/kernel/vdso-ilp32/.gitignore       |  2 +
>  arch/arm64/kernel/vdso-ilp32/Makefile         | 80 ++++++++++++++++++++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     | 33 ++++++++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S | 95 +++++++++++++++++++++++++++
>  arch/arm64/kernel/vdso.c                      | 65 +++++++++++++++---
>  arch/arm64/kernel/vdso/gettimeofday.S         | 20 +++++-
>  arch/arm64/kernel/vdso/vdso.S                 |  6 +-
>  12 files changed, 304 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S

Does this patch get simpler with Andrew Pinski's vdso in C proposal?
I have to read the other thread in detail, Will followed up already.

> diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> index 839ce0031bd5..649a9a416500 100644
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -29,6 +29,12 @@
>  
>  #include <generated/vdso-offsets.h>
>  
> +#ifdef CONFIG_ARM64_ILP32
> +#include <generated/vdso-ilp32-offsets.h>
> +#else
> +#define vdso_offset_sigtramp_ilp32
> +#endif

BTW, here you could do something like:

#define vdso_offset_sigtramp_ilp32	({ BUILD_BUG(); 0; })

-- 
Catalin
