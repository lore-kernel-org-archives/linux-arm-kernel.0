From: rjui@broadcom.com (Ray Jui)
Date: Sun, 7 Dec 2014 17:59:57 -0800
Subject: [PATCH 2/5] gpio: Cygnus: add GPIO driver
In-Reply-To: <5482668F.1040907@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>	
 <1417826408-1600-1-git-send-email-rjui@broadcom.com>	
 <1417826408-1600-3-git-send-email-rjui@broadcom.com>
 <1417829282.31745.3.camel@perches.com> <5482668F.1040907@broadcom.com>
Message-ID: <5485061D.1060302@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/5/2014 6:14 PM, Ray Jui wrote:
>>> +static struct irq_chip bcm_cygnus_gpio_irq_chip = {
>>> +    .name = "bcm-cygnus-gpio",
>>> +    .irq_ack = bcm_cygnus_gpio_irq_ack,
>>> +    .irq_mask = bcm_cygnus_gpio_irq_mask,
>>> +    .irq_unmask = bcm_cygnus_gpio_irq_unmask,
>>> +    .irq_set_type = bcm_cygnus_gpio_irq_set_type,
>>> +};
>>
>> const?
>>
>
>
> Sure, will add const to bcm_cygnus_gpio_irq_chip
>
>>> +static struct irq_domain_ops bcm_cygnus_irq_ops = {
>>> +    .map = bcm_cygnus_gpio_irq_map,
>>> +    .unmap = bcm_cygnus_gpio_irq_unmap,
>>> +    .xlate = irq_domain_xlate_twocell,
>>> +};
>>
>> const here too?
>>
>
> Yes, will make bcm_cygnus_irq_ops const.
>
Actually, I cannot make them const here. Note they are passed into other 
APIs which can potentially modifies their values internally.

drivers/gpio/gpio-bcm-cygnus.c: In function ?bcm_cygnus_gpio_irq_map?:
drivers/gpio/gpio-bcm-cygnus.c:430:4: warning: passing argument 2 of 
?irq_set_chip_and_handler? discards ?const? qualifier from pointer 
target type [enabled by default]
     handle_simple_irq);
     ^
In file included from drivers/gpio/gpio-bcm-cygnus.c:17:0:
include/linux/irq.h:461:20: note: expected ?struct irq_chip *? but 
argument is of type ?const struct irq_chip *?
  static inline void irq_set_chip_and_handler(unsigned int irq, struct 
irq_chip *chip,
                     ^
drivers/gpio/gpio-bcm-cygnus.c: In function ?bcm_cygnus_gpio_probe?:
drivers/gpio/gpio-bcm-cygnus.c:679:5: warning: passing argument 2 of 
?irq_set_chip_and_handler? discards ?const? qualifier from pointer 
target type [enabled by default]
      handle_simple_irq);
      ^
In file included from drivers/gpio/gpio-bcm-cygnus.c:17:0:
include/linux/irq.h:461:20: note: expected ?struct irq_chip *? but 
argument is of type ?const struct irq_chip *?
  static inline void irq_set_chip_and_handler(unsigned int irq, struct 
irq_chip *chip,
