From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 9 Apr 2014 10:02:06 +0100
Subject: [PATCH v2 2/2] ARM: mm: allow text and rodata sections to be
 read-only
In-Reply-To: <1396926910-11227-3-git-send-email-keescook@chromium.org>
References: <1396926910-11227-1-git-send-email-keescook@chromium.org>
 <1396926910-11227-3-git-send-email-keescook@chromium.org>
Message-ID: <20140409090204.GA6583@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

On Mon, Apr 07, 2014 at 08:15:10PM -0700, Kees Cook wrote:
> This introduces CONFIG_DEBUG_RODATA, making kernel text and rodata
> read-only. Additionally, this splits rodata from text so that rodata can
> also be NX, which may lead to wasted memory when aligning to SECTION_SIZE.
> 
> The read-only areas are made writable during ftrace updates. Additional
> work is needed for kprobes and kexec, so the feature is temporarily
> marked as unavailable in Kconfig when those options are selected.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/include/asm/cacheflush.h |    9 ++++++++
>  arch/arm/kernel/ftrace.c          |   17 ++++++++++++++
>  arch/arm/kernel/vmlinux.lds.S     |    3 +++
>  arch/arm/mm/Kconfig               |   12 ++++++++++
>  arch/arm/mm/init.c                |   46 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 87 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 8b8b61685a34..b6fea0a1a88b 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -487,4 +487,13 @@ int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  
> +#ifdef CONFIG_DEBUG_RODATA
> +void mark_rodata_ro(void);
> +void set_kernel_text_rw(void);
> +void set_kernel_text_ro(void);
> +#else
> +static inline void set_kernel_text_rw(void) { }
> +static inline void set_kernel_text_ro(void) { }
> +#endif
> +
>  #endif
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index af9a8a927a4e..ea446ae09c89 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -15,6 +15,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/uaccess.h>
>  #include <linux/module.h>
> +#include <linux/stop_machine.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/opcodes.h>
> @@ -35,6 +36,22 @@
>  
>  #define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
>  
> +static int __ftrace_modify_code(void *data)
> +{
> +	int *command = data;
> +
> +	set_kernel_text_rw();
> +	ftrace_modify_all_code(*command);
> +	set_kernel_text_ro();
> +
> +	return 0;
> +}

Would another approach be to keep all the kernel .text ro then override
probe_kernel_write (which has a weak reference), to create a separate
temporary rw mapping to the specific page that needs to be modified?

That way you only worry about TLB and cache maintenance for a smaller
area. Also, your kernel .text VAs never actually become writable, so
you don't need to worry as much about unauthorised changes whilst your
guard is temporarily down.

(Though lots of small changes could probably make this more
expensive, and you will need to double check aliasing in pre-ARMv7).

Cheers,
-- 
Steve
