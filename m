From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 8 Aug 2011 17:09:04 +0800
Subject: [RFC PATCH 2/2] GPIO: add gpiolib and irqchip for CSR SiRFprimaII
	GPIO controller
In-Reply-To: <20110726100928.GO9653@n2100.arm.linux.org.uk>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4z32ETjAc2DFZMLPx5_qSwSffGqME2S36YEsnX9JGTw4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Jul 26, 2011 at 01:13:13AM -0700, Barry Song wrote:
>> diff --git a/arch/arm/mach-prima2/include/mach/gpio.h b/arch/arm/mach-prima2/include/mach/gpio.h
>> new file mode 100644
>> index 0000000..25673b1
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/include/mach/gpio.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * arch/arm/mach-prima2/include/mach/gpio.h
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#ifndef __MACH_GPIO_H
>> +#define __MACH_GPIO_H
>> +
>> +#include <mach/irqs.h>
>> +
>> +#ifndef CONFIG_GPIO_SIRFCPLD
>> +#define ARCH_NR_GPIOS ? ? ? ?(SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS)
>> +#else
>> +#define ARCH_NR_GPIOS ? ? ? ?(SIRFSOC_GPIO_BANK_SIZE * SIRFSOC_GPIO_NO_OF_BANKS + \
>> + ? ? SIRFSOC_GPIO_CPLD_SIZE + SIRFSOC_GPIO_IO_CPLD_SIZE + \
>> + ? ? SIRFSOC_GPIO_HS_CPLD_SIZE)
>> +#endif
>> +
>> +#include <linux/errno.h>
>
> Why do you need linux/errno.h? ?asm-generic/gpio.h already includes this.
>
>> +#include <asm-generic/gpio.h>
>> +
>> +#define gpio_get_value ? ? ? __gpio_get_value
>> +#define gpio_set_value ? ? ? __gpio_set_value
>> +#define gpio_cansleep ? ? ? ?__gpio_cansleep
>
> Hmm, yet another trivial gpio implementation. ?We have 24 others just like
> this. ?Well, mainline does... I have just one.

Ok.
this gpio driver includes two parts: gpio chip and irq chip.  For gpio
chip, we could import gpio-generic and delete
sirfsoc_gpio_direction_input, sirfsoc_gpio_get_value,
sirfsoc_gpio_direction_output and so on.
For the part of irq chip, i don't see much benefit from generic-irq.
all of sirfsoc_gpio_irq_ack, sirfsoc_gpio_irq_mask and
sirfsoc_gpio_irq_unmask are CSR-specific.  irq_gc_ack_set_bit,
irq_gc_mask_clr_bit and irq_gc_mask_set_bit are not practicable to
this chip.

-barry
