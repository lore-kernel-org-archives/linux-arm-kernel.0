From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 30 Apr 2013 13:22:11 -0400
Subject: [PATCH v3 1/4] arm: Move the set_handle_irq and handle_arch_irq
 declarations to asm/irq.h
In-Reply-To: <1363714703-9629-2-git-send-email-catalin.marinas@arm.com>
References: <1363714703-9629-1-git-send-email-catalin.marinas@arm.com>
 <1363714703-9629-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <517FFDC3.5030803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 03/19/2013 01:38 PM, Catalin Marinas wrote:
> This patch prepares the removal of <asm/mach/irq.h> include in the
> GIC and VIC irqchip drivers.

[...]

> diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
> index 3cf97aa..e38cb00 100644
> --- a/drivers/irqchip/irq-vic.c
> +++ b/drivers/irqchip/irq-vic.c
> @@ -33,7 +33,7 @@
>  #include <linux/irqchip/arm-vic.h>
>  
>  #include <asm/exception.h>
> -#include <asm/mach/irq.h>
> +#include <asm/irq.h>
>  
>  #include "irqchip.h"

I'm seeing implicit declaration of function issues using your soc-armv8-model
branch that seem to be caused by this change.

drivers/irqchip/irq-vic.c: In function ?vic_irqdomain_map?:
drivers/irqchip/irq-vic.c:200:2: error: implicit declaration of function
?irq_set_chip_and_handler? [-Werror=implicit-function-declaration]
drivers/irqchip/irq-vic.c:200:43: error: ?handle_level_irq? undeclared (first
use in this function)

etc.

Explicitly including linux/irq.h fixed the issue for me.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
