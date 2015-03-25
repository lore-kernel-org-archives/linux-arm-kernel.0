From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 25 Mar 2015 09:52:21 +0100
Subject: [PATCH 12/13] mmc: atmel-mci: use endian agnostic IO
In-Reply-To: <1426693992-31163-13-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-13-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAPDyKFpwZA52zDQCt01xiuFrATu2As5Hm3uLmQQf9kk=hYKfzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 16:53, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Change the __raw IO functions to endian agnostic relaxed ones to allow
> the driver to function on big endian ARM systems.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks! Applied.

Kind regards
Uffe


> --
> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> CC: Chris Ball <chris@printf.net>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc at vger.kernel.org
> ---
>  drivers/mmc/host/atmel-mci-regs.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
> index c97001e..711bb53 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -135,10 +135,17 @@
>  #define ATMCI_REGS_SIZE                0x100
>
>  /* Register access macros */
> -#define atmci_readl(port,reg)                          \
> +#ifdef CONFIG_AVR32
> +#define atmci_readl(port,reg)                  \
>         __raw_readl((port)->regs + reg)
>  #define atmci_writel(port,reg,value)                   \
>         __raw_writel((value), (port)->regs + reg)
> +#else
> +#define atmci_readl(port,reg)                  \
> +       readl_relaxed((port)->regs + reg)
> +#define atmci_writel(port,reg,value)                   \
> +       writel_relaxed((value), (port)->regs + reg)
> +#endif
>
>  /* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
>  #ifdef CONFIG_AVR32
> --
> 2.1.4
>
