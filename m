From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 8 Jul 2011 10:18:57 +0800
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110707141254.GR8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107071343.03591.arnd@arndb.de>
	<20110707123707.GN8286@n2100.arm.linux.org.uk>
	<201107071521.07070.arnd@arndb.de>
	<20110707141254.GR8286@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4wsc=Jx6+thKriX+x5KdX2m8O9HfrnC_MGYAXTUe-DoRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/7 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jul 07, 2011 at 03:21:06PM +0200, Arnd Bergmann wrote:
>> What's left then are basically the headers. There is significant
>> room for consolidation there, and I think most of them have been
>> looked at by people before or are currently being worked on.
>> Below is the complete diff between the headers of the two platforms
>> as they are being proposed now.
>
> Thanks for that. ?diff -w might be a good idea on these to eliminate
> changes due to whitespace differences. ?It has found one thing which
> should be fixed...
>
>> diff -urN arch/arm/mach-prima2/include/mach/vmalloc.h arch/arm/mach-zynq/include/mach/vmalloc.h
>> --- arch/arm/mach-prima2/include/mach/vmalloc.h ? ? ? 2011-07-07 13:21:41.000000000 +0000
>> +++ arch/arm/mach-zynq/include/mach/vmalloc.h 2011-07-07 13:22:07.000000000 +0000
>> @@ -1,14 +1,20 @@
>> -/*
>> - * arch/arm/ach-prima2/include/mach/vmalloc.h
>> +/* arch/arm/mach-zynq/include/mach/vmalloc.h
>> ? *
>> - * Copyright (c) 2010 ? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + * ?Copyright (C) 2011 Xilinx
>> ? *
>> - * Licensed under GPLv2 or later.
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>> + * GNU General Public License for more details.
>> ? */
>>
>> -#ifndef __MACH_VMALLOC_H
>> -#define __MACH_VMALLOC_H
>> +#ifndef __MACH_VMALLOC_H__
>> +#define __MACH_VMALLOC_H__
>>
>> -#define VMALLOC_END ?0xFEC00000
>> +#define VMALLOC_END ? ? ? 0xE0000000UL
>
> Prima2 should add a UL suffix to VMALLOC_END to ensure that it is
> properly typed.

simply adding a UL suffix will make compiling fail since
arch/arm/kernel/debug.S will refer to the macro calculating virtual
address of SIRFSOC_UART1_VA_BASE and UL is not legal in asm.

samsung has one way to handle this:

plat-samsung/include/plat/map-base.h

#define S3C_ADDR_BASE   0xF6000000

#ifndef __ASSEMBLY__
#define S3C_ADDR(x)     ((void __iomem __force *)S3C_ADDR_BASE + (x))
#else
#define S3C_ADDR(x)     (S3C_ADDR_BASE + (x))
#endif

#define S3C_VA_UART     S3C_ADDR(0x01000000)    /* UART */

mach-s5pc100/include/mach/debug-macro.S:
        .macro addruart, rp, rv
                ldr     \rp, = S3C_PA_UART
                ldr     \rv, = S3C_VA_UART
#if CONFIG_DEBUG_S3C_UART != 0
                add     \rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
                add     \rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
#endif
        .endm

Samsung hasn't UL for S3C_ADDR_BASE in asm context, so its
arch/arm/kernel/debug.S can compile. in C context, "(void __iomem
__force *)" works to force the right type.

To fix my problem, i might simply give the direct address to
SIRFSOC_UART1_VA_BASE:

#define SIRFSOC_UART1_VA_BASE 0xFEC60000

instead of

#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
>
