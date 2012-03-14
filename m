From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 22:32:23 +0800
Subject: [PATCH] mfd: pcap: depend on arch-pxa
In-Reply-To: <1331011808-28307-1-git-send-email-haojian.zhuang@gmail.com>
References: <1331011808-28307-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAN1soZwf8fSwZeoXBg87Xb=24xmo8m=T8wR74DKJUT5WQYfjrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 1:30 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> drivers/mfd/ezx-pcap.c: In function ?pcap_isr_work?:
> drivers/mfd/ezx-pcap.c:206:2: error: implicit declaration of function
> ?pxa_irq_to_gpio?
> make[2]: *** [drivers/mfd/ezx-pcap.o] Error 1
>
> PCAP driver invokes irq_to_gpio() directly. This function isn't common
> function in most silicons. PCAP driver is enabled for EZX machine with
> arch-pxa. Now use pxa_irq_to_gpio() instead.
>
> It's only a workaround for this issue. Acutally the best solution is
> using thread irq to fix this issue.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
> ?drivers/mfd/Kconfig ? ?| ? ?2 +-
> ?drivers/mfd/ezx-pcap.c | ? ?3 ++-
> ?2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f147395..e88d315 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -619,7 +619,7 @@ config AB3100_OTP
>
> ?config EZX_PCAP
> ? ? ? ?bool "PCAP Support"
> - ? ? ? depends on GENERIC_HARDIRQS && SPI_MASTER
> + ? ? ? depends on GENERIC_HARDIRQS && SPI_MASTER && ARCH_PXA
> ? ? ? ?help
> ? ? ? ? ?This enables the PCAP ASIC present on EZX Phones. This is
> ? ? ? ? ?needed for MMC, TouchScreen, Sound, USB, etc..
> diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
> index 43a76c4..e9320e2 100644
> --- a/drivers/mfd/ezx-pcap.c
> +++ b/drivers/mfd/ezx-pcap.c
> @@ -18,6 +18,7 @@
> ?#include <linux/mfd/ezx-pcap.h>
> ?#include <linux/spi/spi.h>
> ?#include <linux/gpio.h>
> +#include <linux/gpio-pxa.h>
> ?#include <linux/slab.h>
>
> ?#define PCAP_ADC_MAXQ ? ? ? ? ?8
> @@ -202,7 +203,7 @@ static void pcap_isr_work(struct work_struct *work)
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?local_irq_enable();
> ? ? ? ? ? ? ? ?ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
> - ? ? ? } while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
> + ? ? ? } while (gpio_get_value(pxa_irq_to_gpio(pcap->spi->irq)));
> ?}
>
> ?static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
> --
> 1.7.5.4
>

Hi Samuel,

How about this patch? Is it OK?

Best Regards
Haojian
