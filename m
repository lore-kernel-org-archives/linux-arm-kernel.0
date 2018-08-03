From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Aug 2018 10:43:38 +0200
Subject: [PATCH] arm64: build CONFIG_ARM64_LSE_ATOMICS without -ffixed-
 flags
In-Reply-To: <20180802231753.86336-1-trong@android.com>
References: <20180802231753.86336-1-trong@android.com>
Message-ID: <CAKv+Gu_QzzDSV74pzLQcPBsWHZK5hvMwa8PojSJmzTOMnY780Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2018 at 01:17, Tri Vo <trong@android.com> wrote:
> Remove -ffixed- compile flags as they are not required for correct
> behavior of out-of-line ll/sc implementations of atomic functions.
> Registers (except x0 which contains return value) only need to be
> callee-saved, not necessarily fixed.
>
> For readability purposes, represent "callee-saves-all-registers" calling
> convention with a combination of -fcall-used- and -fcall-saved- flags only.
>
> Signed-off-by: Tri Vo <trong@android.com>

Wouldn't this permit the compiler to stack/unstack these registers in
the implementations of the out of line LL/SC fallbacks.

> ---
>  arch/arm64/lib/Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index c86b7909ef31..05ba3d276c15 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -11,9 +11,9 @@ lib-y         := bitops.o clear_user.o delay.o copy_from_user.o       \
>  # when supported by the CPU. Result and argument registers are handled
>  # correctly, based on the function prototype.
>  lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
> -CFLAGS_atomic_ll_sc.o  := -fcall-used-x0 -ffixed-x1 -ffixed-x2         \
> -                  -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6          \
> -                  -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9           \
> -                  -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12   \
> -                  -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15   \
> -                  -fcall-saved-x18
> +CFLAGS_atomic_ll_sc.o  := -fcall-used-x0 -fcall-saved-x1               \
> +                  -fcall-saved-x2 -fcall-saved-x3 -fcall-saved-x4      \
> +                  -fcall-saved-x5 -fcall-saved-x6 -fcall-saved-x7      \
> +                  -fcall-saved-x8 -fcall-saved-x9 -fcall-saved-x10     \
> +                  -fcall-saved-x11 -fcall-saved-x12 -fcall-saved-x13   \
> +                  -fcall-saved-x14 -fcall-saved-x15 -fcall-saved-x18
> --
> 2.18.0.597.ga71716f1ad-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
