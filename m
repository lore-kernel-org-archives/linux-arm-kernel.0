From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 12:46:03 +0200
Subject: [PATCH 08/32] dmaengine: ste_dma40: Optimise local MAX() macro
In-Reply-To: <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181246.03357.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> The current implementation of the DMA40's local MAX() macro evaluates
> its arguments more times than is necessary. This patch strips it
> optimises it to only evaluate what's appropriate.

No, it does not.

> index b21a8a3..7b451b2 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -53,7 +53,7 @@
>  #define D40_ALLOC_PHY          BIT(30)
>  #define D40_ALLOC_LOG_FREE     BIT(0)
>  
> -#define MAX(a, b) (((a) < (b)) ? (b) : (a))
> +#define MAX(a, b) ((a > b) ? a : b)

This just makes the macro worse in case you pass a complex expression
in, which can now have additional unwanted effects. Just drop this patch.

	Arnd
