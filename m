From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 26 Nov 2018 12:30:53 +0100
Subject: [PATCH] arm64: crypto: add NEON accelerated XOR implementation
In-Reply-To: <20181126085530.2699-1-liuyun01@kylinos.cn>
References: <20181126085530.2699-1-liuyun01@kylinos.cn>
Message-ID: <CAKv+Gu8EAqehWPysCBD10buLXwfr5v_rRivYrzsLLG=CE_hVyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jackie,

On Mon, 26 Nov 2018 at 09:56, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
> This is a NEON acceleration method that can improve
> performance by approximately 20%. I got the following
> data from the centos 7.5 on Huawei's HISI1616 chip:
>
> [ 93.837726] xor: measuring software checksum speed
> [ 93.874039]   8regs  : 7123.200 MB/sec
> [ 93.914038]   32regs : 7180.300 MB/sec
> [ 93.954043]   arm64_neon: 9856.000 MB/sec
> [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
>
> I believe this code can bring some optimization for
> all arm64 platform.
>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/asm/xor.h   |  73 ++++++++++++++++++++
>  arch/arm64/lib/Makefile        |   7 ++
>  arch/arm64/lib/xor-neon-core.c | 152 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/lib/xor-neon-glue.c |  36 ++++++++++

You should remove xor.h from arch/arm64/include/asm/Kbuild as well so
we no longer get the asm-generic version.

>  4 files changed, 268 insertions(+)
>  create mode 100644 arch/arm64/include/asm/xor.h
>  create mode 100644 arch/arm64/lib/xor-neon-core.c
>  create mode 100644 arch/arm64/lib/xor-neon-glue.c
>
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> new file mode 100644
> index 0000000..31e8aaf
> --- /dev/null
> +++ b/arch/arm64/include/asm/xor.h
> @@ -0,0 +1,73 @@
> +/*
> + * arch/arm64/include/asm/xor.h
> + *
> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/hardirq.h>
> +#include <asm-generic/xor.h>
> +#include <asm/hwcap.h>
> +#include <asm/neon.h>
> +
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +extern struct xor_block_template const xor_block_inner_neon;
> +
> +static void
> +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_2(bytes, p1, p2);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +            unsigned long *p3)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +            unsigned long *p3, unsigned long *p4)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +            unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> +       kernel_neon_end();
> +}
> +
> +static struct xor_block_template xor_block_arm64 = {
> +       .name   = "arm64_neon",
> +       .do_2   = xor_neon_2,
> +       .do_3   = xor_neon_3,
> +       .do_4   = xor_neon_4,
> +       .do_5   = xor_neon_5
> +};
> +#undef XOR_TRY_TEMPLATES
> +#define XOR_TRY_TEMPLATES           \
> +       do {        \
> +               xor_speed(&xor_block_8regs);    \
> +               xor_speed(&xor_block_32regs);    \
> +               if (cpu_has_neon()) { \
> +                       xor_speed(&xor_block_arm64);\
> +               } \
> +       } while (0)
> +
> +#endif // CONFIG_KERNEL_MODE_NEON
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 69ff988..272cc42 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -5,6 +5,13 @@ lib-y          := clear_user.o delay.o copy_from_user.o                \
>                    memcmp.o strcmp.o strncmp.o strlen.o strnlen.o       \
>                    strchr.o strrchr.o tishift.o
>
> +ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> +obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
> +xor-neon-y                     += xor-neon-glue.o xor-neon-core.o

No need for two separate source files (see below)

> +CFLAGS_REMOVE_xor-neon-core.o  += -mgeneral-regs-only
> +CFLAGS_xor-neon-core.o         += -ffreestanding

This looks ok. I will note (for other reviewers) that the
-ffreestanding is required because the <arm_neon.h> system header
includes <stdint.h>, which either pulls in the system's <stdint.h> or
gcc-stdint.h which ships with the compiler (and we want the latter)

> +endif
> +
>  # Tell the compiler to treat all general purpose registers (with the
>  # exception of the IP registers, which are already handled by the caller
>  # in case of a PLT) as callee-saved, which allows for efficient runtime
> diff --git a/arch/arm64/lib/xor-neon-core.c b/arch/arm64/lib/xor-neon-core.c
> new file mode 100644
> index 0000000..b2880a2
> --- /dev/null
> +++ b/arch/arm64/lib/xor-neon-core.c
> @@ -0,0 +1,152 @@
> +/*
> + * arch/arm64/lib/xor-neon-core.c
> + *
> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/raid/xor.h>
> +#include <arm_neon.h>
> +
> +void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +               p3 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3, unsigned long *p4)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
> +
> +               /* p1 ^= p4 */
> +               v0 = veorq_u64(v0, vld1q_u64(p4 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p4 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p4 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p4 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +               p3 += 8;
> +               p4 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3,
> +       unsigned long *p4, unsigned long *p5)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
> +
> +               /* p1 ^= p4 */
> +               v0 = veorq_u64(v0, vld1q_u64(p4 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p4 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p4 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p4 +  6));
> +
> +               /* p1 ^= p5 */
> +               v0 = veorq_u64(v0, vld1q_u64(p5 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p5 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p5 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p5 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +               p3 += 8;
> +               p4 += 8;
> +               p5 += 8;
> +       } while (--lines > 0);
> +}
> diff --git a/arch/arm64/lib/xor-neon-glue.c b/arch/arm64/lib/xor-neon-glue.c
> new file mode 100644
> index 0000000..fdaac8b
> --- /dev/null
> +++ b/arch/arm64/lib/xor-neon-glue.c
> @@ -0,0 +1,36 @@
> +/*
> + * arch/arm64/lib/xor-neon-glue.c
> + *
> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/raid/xor.h>
> +#include <linux/module.h>
> +
> +void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2);
> +void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2, unsigned long *p3);
> +void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2, unsigned long *p3,
> +                            unsigned long *p4);
> +void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2, unsigned long *p3,
> +                            unsigned long *p4, unsigned long *p5);
> +
> +struct xor_block_template const xor_block_inner_neon = {
> +       .name   = "__inner_neon__",
> +       .do_2   = xor_arm64_neon_2,
> +       .do_3   = xor_arm64_neon_3,
> +       .do_4   = xor_arm64_neon_4,
> +       .do_5   = xor_arm64_neon_5,
> +};
> +EXPORT_SYMBOL_GPL(xor_block_inner_neon);

Can you move this struct into the NEON source file? (and drop this
file altogether) Or are there header soup concerns?

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
> --
> 2.7.4
>
>
>
