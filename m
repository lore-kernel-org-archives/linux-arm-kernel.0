From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Thu, 26 Mar 2015 12:58:22 +0100
Subject: [RFC 6/6] mmc: atmel-mci: use atmel_io.h to provide on-chip IO
In-Reply-To: <1427370354-21247-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-7-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326115821.GE16148@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 26 Mar 2015 11:45:54 +0000 or thereabout, Ben Dooks wrote:
> Use <linux/atmel_io.h> to provide IO accessors which work on both
> AVR32 and ARM for on-chip peripherals.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> CC: Chris Ball <chris@printf.net>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc at vger.kernel.org
> ---
>  drivers/mmc/host/atmel-mci-regs.h | 11 ++---------
>  drivers/mmc/host/atmel-mci.c      |  1 +
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
> index 711bb53..2293f2c 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -135,17 +135,10 @@
>  #define ATMCI_REGS_SIZE		0x100
>  
>  /* Register access macros */
> -#ifdef CONFIG_AVR32
>  #define atmci_readl(port,reg)			\
> -	__raw_readl((port)->regs + reg)
> +	atmel_oc_readl((port)->regs + reg)
>  #define atmci_writel(port,reg,value)			\
> -	__raw_writel((value), (port)->regs + reg)
> -#else
> -#define atmci_readl(port,reg)			\
> -	readl_relaxed((port)->regs + reg)
> -#define atmci_writel(port,reg,value)			\
> -	writel_relaxed((value), (port)->regs + reg)
> -#endif
> +	atmel_oc_writel((value), (port)->regs + reg)

Defines are utilized in the header file, but ...

>  
>  /* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
>  #ifdef CONFIG_AVR32
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 03d7c75..49de0d7 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -37,6 +37,7 @@
>  
>  #include <linux/atmel-mci.h>
>  #include <linux/atmel_pdc.h>
> +#include <linux/atmel_io.h>

... you include the required header file in the source file instead.

Also, a follow-up patch could remove the atmci_{read,write}{l,w} defines
completely.

>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/consumer.h>
-- 
mvh
Hans-Christian Egtvedt
