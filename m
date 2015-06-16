From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Jun 2015 08:17:47 -0500
Subject: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
In-Reply-To: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Message-ID: <CAL_JsqK3L9Hv9bhAtwAAXVYjLJBTOG9=4ddOo-SFqnD-_KieCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 11:42 AM, David Long <dave.long@linaro.org> wrote:
> From: "David A. Long" <dave.long@linaro.org>
>
> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>  feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h.
>
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/kernel/ptrace.c     | 5 -----
>  arch/powerpc/kernel/ptrace.c | 5 -----
>  arch/sh/include/asm/ptrace.h | 5 -----
>  arch/x86/kernel/ptrace.c     | 5 -----
>  include/linux/ptrace.h       | 9 +++++++++
>  5 files changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ef9119f..fb45cf1 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -59,11 +59,6 @@
>  #define BREAKINST_THUMB        0xde01
>  #endif
>
> -struct pt_regs_offset {
> -       const char *name;
> -       int offset;
> -};
> -
>  #define REG_OFFSET_NAME(r) \
>         {.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
>  #define REG_OFFSET_END {.name = NULL, .offset = 0}

Can't you also move these? ARM is complicated with the "ARM_"
prefixing, but the others appear to be the same. Maybe you can remove
the prefix or redefine the macro for ARM.

Rob
