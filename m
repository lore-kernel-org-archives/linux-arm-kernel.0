From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 05 Nov 2009 14:04:59 +0100
Subject: [PATCH] IXP4xx: Ensure index is positive
In-Reply-To: <4AF0A92C.6050400@gmail.com> (Roel Kluin's message of "Tue, 03
	Nov 2009 23:05:32 +0100")
References: <4AF08014.4000704@gmail.com> <4AF0922B.3030701@hiramoto.org>
	<m3eiofl2v8.fsf@intrepid.localdomain> <4AF0A92C.6050400@gmail.com>
Message-ID: <m33a4t5dhg.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roel Kluin <roel.kluin@gmail.com> writes:

> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -117,7 +117,7 @@ int gpio_to_irq(int gpio)
>  }
>  EXPORT_SYMBOL(gpio_to_irq);
>  
> -int irq_to_gpio(int irq)
> +int irq_to_gpio(unsigned int irq)
>  {
>  	int gpio = (irq < 32) ? irq2gpio[irq] : -EINVAL;
>  
> diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
> index cd5aec2..a5f87de 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/gpio.h
> @@ -70,7 +70,7 @@ static inline void gpio_set_value(unsigned gpio, int value)
>  #include <asm-generic/gpio.h>			/* cansleep wrappers */
>  
>  extern int gpio_to_irq(int gpio);
> -extern int irq_to_gpio(int gpio);
> +extern int irq_to_gpio(unsigned int irq);
>  
>  #endif
>  
> diff --git a/arch/arm/mach-ixp4xx/include/mach/npe.h b/arch/arm/mach-ixp4xx/include/mach/npe.h
> index 37d0511..e320db2 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/npe.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/npe.h
> @@ -33,7 +33,7 @@ int npe_send_message(struct npe *npe, const void *msg, const char *what);
>  int npe_recv_message(struct npe *npe, void *msg, const char *what);
>  int npe_send_recv_message(struct npe *npe, void *msg, const char *what);
>  int npe_load_firmware(struct npe *npe, const char *name, struct device *dev);
> -struct npe *npe_request(int id);
> +struct npe *npe_request(unsigned id);
>  void npe_release(struct npe *npe);
>  
>  #endif /* __IXP4XX_NPE_H */
> diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> index 47ac69c..e8bb257 100644
> --- a/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> +++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> @@ -665,7 +665,7 @@ err:
>  }
>  
>  
> -struct npe *npe_request(int id)
> +struct npe *npe_request(unsigned id)

It looks good, thanks a lot.
-- 
Krzysztof Halasa
