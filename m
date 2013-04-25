From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 10:36:19 +0200
Subject: [PATCH 08/32] dmaengine: ste_dma40: Optimise local MAX() macro
In-Reply-To: <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ9j8Xr2-m6KG_Uet6Hft8xx_WJkKUQpi9QwuoE=9H1NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The current implementation of the DMA40's local MAX() macro evaluates
> its arguments more times than is necessary. This patch strips it
> optimises it to only evaluate what's appropriate.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Reported-by: Harvey Harrison <harvey.harrison@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
(...)
> -#define MAX(a, b) (((a) < (b)) ? (b) : (a))
> +#define MAX(a, b) ((a > b) ? a : b)

Much has been said about this patch already, but notice what it is
used for instead, one single thing at compile-time:

struct d40_base {
(...)
        u32
reg_val_backup_v4[MAX(BACKUP_REGS_SZ_V4A, BACKUP_REGS_SZ_V4B)];
(...)
};

i.e. defining the size of that array at compile-time.

The actual size is figured out in d40_hw_detect_init().

So what about you just devm_kmalloc() that array instead and
delete this macro. That is the real fix.

Yours,
Linus Walleij
