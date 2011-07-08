From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 08 Jul 2011 16:03:15 -0000
Subject: [PATCH 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <1298940450-27365-2-git-send-email-mnalajal@codeaurora.org>
References: <1298940450-27365-1-git-send-email-mnalajal@codeaurora.org>
	<1298940450-27365-2-git-send-email-mnalajal@codeaurora.org>
Message-ID: <1302861097.3220.12.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-01 at 06:17 +0530, Murali Nalajala wrote:
> +#define pr_fmt(fmt) "%s:" fmt, __func__
> +
> +#include <linux/kernel.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include <asm/mach/flash.h>
> +#include <mach/dma.h>
> +
> +#include "msm_nand.h"
> +
> +unsigned long msm_nand_phys;

No global variables like this please. Here is how you use them:

+extern unsigned long msm_nand_phys;
+#define MSM_NAND_REG(off) (msm_nand_phys + (off))
+
+#define MSM_NAND_FLASH_CMD            MSM_NAND_REG(0x0000)
+#define MSM_NAND_ADDR0                MSM_NAND_REG(0x0004)

Could you please make the macros to take the "struct msm_nand_chip
*chip" argument instead, and store the pase address there. Do not hide
the fact that those macros are actually functions, not constant - this
is error prone.

Besides, I'm do not know your HW, but if you have several controllers
with various base addresses - your driver won't work.

> +	pr_info("Save cfg0 = %x cfg1 = %x\n", chip->cfg0, chip->cfg1);
> +	pr_info("cfg0: cw/page=%d ud_sz=%d ecc_sz=%d spare_sz=%d "
> +		"num_addr_cycles=%d\n", (chip->cfg0 >> 6) & 7,
> +		(chip->cfg0 >> 9) & 0x3ff, (chip->cfg0 >> 19) & 15,
> +		(chip->cfg0 >> 23) & 15, (chip->cfg0 >> 27) & 7);

Please, revise all your pr_info() calls and turn most of them into
dev_dbg() or pr_debug. Your driver should be completely silent by
default, except of error messages and some information messages when it
is initialized.


-- 
Best Regards,
Artem Bityutskiy (????? ????????)


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
