From: glider@google.com (Alexander Potapenko)
Date: Thu, 31 Mar 2016 16:02:47 +0200
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
Message-ID: <CAG_fn=Vxjki4B=Z9jFtORgmnao081yE03mR1b2OQC0igrA7cdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 3:54 PM, Alexander Potapenko <glider@google.com> wrote:
> Add ARCH_HAS_KCOV to ARM64 config. Disable instrumentation of
> arch/arm64/lib/delay.c
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/arm64/Kconfig      | 1 +
>  arch/arm64/lib/Makefile | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f43622..c52aa61 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -7,6 +7,7 @@ config ARM64
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_HAS_ELF_RANDOMIZE
>         select ARCH_HAS_GCOV_PROFILE_ALL
> +       select ARCH_HAS_KCOV
>         select ARCH_HAS_SG_CHAIN
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_USE_CMPXCHG_LOCKREF
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index c86b790..b407bc1 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -1,3 +1,6 @@
> +# Produces uninteresting flaky coverage.
> +KCOV_INSTRUMENT_delay.o        := n
> +
>  lib-y          := bitops.o clear_user.o delay.o copy_from_user.o       \
>                    copy_to_user.o copy_in_user.o copy_page.o            \
>                    clear_page.o memchr.o memcpy.o memmove.o memset.o    \
> --
> 2.8.0.rc3.226.g39d4020
>

Hi all,

I've ported the above patch from kernel 3.18, which I was able to
successfully run with kcov support on an arm64 device.
The original 3.18 patch is at
https://chromium-review.googlesource.com/#/c/334560/1, it also touches
arch/arm64/kernel/Makefile, which is unnecessary in upstream code,
because efi-stub.c has been moved to libstub.
Therefore I suspect the above patch should be correct, but I don't
have an opportunity to actually test it.

Alex

-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
