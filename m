From: vipin.kumar@st.com (Vipin Kumar)
Date: Fri, 1 Oct 2010 16:22:40 +0530
Subject: [PATCH 1/2] MTD: generic FSMC NAND MTD driver
In-Reply-To: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
References: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4CA5BD78.9080808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello David, Linus

> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <mtd/fsmc.h>
> +#include <mtd/mtd-abi.h>
> +
> +static struct nand_ecclayout fsmc_ecc1_layout = {
> +       .eccbytes = 24,
> +       .eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52,
> +               66, 67, 68, 82, 83, 84, 98, 99, 100, 114, 115, 116},
> +       .oobfree = {
> +               {.offset = 8, .length = 8},
> +               {.offset = 24, .length = 8},
> +               {.offset = 40, .length = 8},
> +               {.offset = 56, .length = 8},
> +               {.offset = 72, .length = 8},
> +               {.offset = 88, .length = 8},
> +               {.offset = 104, .length = 8},
> +               {.offset = 120, .length = 8}
> +       }
> +};
> +
> +static struct nand_ecclayout fsmc_ecc4_lp_layout = {
> +       .eccbytes = 104,
> +       .eccpos = {  2,   3,   4,   5,   6,   7,   8,
> +               9,  10,  11,  12,  13,  14,
> +               18,  19,  20,  21,  22,  23,  24,
> +               25,  26,  27,  28,  29,  30,
> +               34,  35,  36,  37,  38,  39,  40,
> +               41,  42,  43,  44,  45,  46,
> +               50,  51,  52,  53,  54,  55,  56,
> +               57,  58,  59,  60,  61,  62,
> +               66,  67,  68,  69,  70,  71,  72,
> +               73,  74,  75,  76,  77,  78,
> +               82,  83,  84,  85,  86,  87,  88,
> +               89,  90,  91,  92,  93,  94,
> +               98,  99, 100, 101, 102, 103, 104,
> +               105, 106, 107, 108, 109, 110,
> +               114, 115, 116, 117, 118, 119, 120,
> +               121, 122, 123, 124, 125, 126
> +       },
> +       .oobfree = {
> +               {.offset = 15, .length = 3},
> +               {.offset = 31, .length = 3},
> +               {.offset = 47, .length = 3},
> +               {.offset = 63, .length = 3},
> +               {.offset = 79, .length = 3},
> +               {.offset = 95, .length = 3},
> +               {.offset = 111, .length = 3},
> +               {.offset = 127, .length = 1}
> +       }
> +};
> +

I just noticed that the above array is based on an earlier patch which increased 
the array size from 64 to 128. 

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/024372.html

This patch itself was under the lense of reviewers for a long time. Actually, 
increasing this array breaks mtd abi as pointed by Artem


Quoting from his mail

> The old interface should remain unchanged in that include/mtd/mtd-abi.h.
> If an application using the old interface calls any of the ecc ioctls
> for a nand chip with > 64 bytes ecc it should return an error.

It will, because size of the structure is part of the ioctl number,
even. See the corresponding ioctl macro definition.

> I still think the eccpos field should be a pointer, so that it can
> allocate as much space as is needed for the ecc. This also means that
> the kernel doesn't need to be changed every time a new NAND chips
> appears with a bigger ecc size.

Sure, this is the whole point: go ahead and design the new ioctl, and
then deprecate the old one. Just invest men/hours into that and we are
all right :-)


This means that the patch sent by linus can be added only after a new ioctl
is defined and the old one deprecated

> +#define __MTD_FSMC_H
> +
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/types.h>
> +#include <linux/mtd/partitions.h>
> +#include <asm/param.h>

Linus, there is a checkpatch warining here :)

Best Regards
Vipin
