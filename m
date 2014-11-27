From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 14:20:24 +0100
Subject: [PATCH v4 5/6] ARM: zynq: Add OCM controller driver
In-Reply-To: <6741d995fbec801d795c5db481e39425bd912f8a.1415962281.git.michal.simek@xilinx.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
 <6741d995fbec801d795c5db481e39425bd912f8a.1415962281.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdbZ8Pwy=04dhJq5ONZ1B-SQK1f=eLZjjCDmV7UQ0aHduA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 11:52 AM, Michal Simek <michal.simek@xilinx.com> wrote:

> The driver provide memory allocator which can
> be used by others drivers to allocate memory inside OCM.
> All location for 64kB blocks are supported

Allocation?

> and driver is trying to allocate the largest continuous
> block of memory.

Isn't all genalloc allocations continuous?

(...)
> +       zynq_ocmc->pool = devm_gen_pool_create(&pdev->dev,
> +                                              ilog2(ZYNQ_OCMC_GRANULARITY),
> +                                              -1);

Do this:

#include <linux/sizes.h>

zynq_ocmc->pool = devm_gen_pool_create(&pdev->dev,
                                       ilog2(SZ_64K),
                                       -1);

And get rid of the #define for ZYNQ_OCMC_GRANULARITY

Yours,
Linus Walleij
