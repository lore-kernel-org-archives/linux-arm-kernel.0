From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Apr 2012 22:52:58 +0100
Subject: [PATCH] ARM:mfd: fix ezx-pcap build failure
In-Reply-To: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
References: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
Message-ID: <20120426215258.GG24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 11:02:43AM -0400, Mark Asselstine wrote:
> Attempting to build the ezx_defconfig we get a build failure:
> 
> drivers/mfd/ezx-pcap.c: In function 'pcap_isr_work':
> drivers/mfd/ezx-pcap.c:205: error: implicit declaration of function 'irq_to_gpio'
> 
> Looking at this failure we can find that commit 4929f5a8a99f
> [ARM:pxa: rename gpio_to_irq and irq_to_gpio] renamed irq_to_gpio()
> to pxa_irq_to_gpio() but this change was not made in the ezx-pcap
> driver.

That's because drivers shouldn't have knowledge about the SoC they're
running on.  This driver is not restricted to only being built for PXA,
and so with your change, this will cause a link error should this be
built on non-PXA.

However, there's a big problem with code using irq_to_gpio() or any
variant of that in this manner:

        } while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));

What is the effect when the supplied IRQ does not have a mapping to a
GPIO - or it _does_ by way of a badly coded irq_to_gpio() function
but that GPIO is not the correct one.

There is no prevention against endlessly looping, so it could cause a
system lockup.

The real answer is to fix SPI et.al. so that its possible to pass the
_GPIO_ number into this driver (that's what the driver wants for its
interrupt line after all).  To fix that, SPI folk need to get involved
(added Grant as a first step.)

In the meantime, I'd suggest making this depend on !ARM || BROKEN until
it's probably fixed.

> 
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> ---
>  drivers/mfd/ezx-pcap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
> index 43a76c4..c49c52a 100644
> --- a/drivers/mfd/ezx-pcap.c
> +++ b/drivers/mfd/ezx-pcap.c
> @@ -19,6 +19,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/gpio.h>
>  #include <linux/slab.h>
> +#include <linux/gpio-pxa.h>
>  
>  #define PCAP_ADC_MAXQ		8
>  struct pcap_adc_request {
> @@ -202,7 +203,7 @@ static void pcap_isr_work(struct work_struct *work)
>  		}
>  		local_irq_enable();
>  		ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
> -	} while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
> +	} while (gpio_get_value(pxa_irq_to_gpio(pcap->spi->irq)));
>  }
>  
>  static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
