From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Nov 2013 09:24:29 -0600
Subject: [PATCH v2] arm64: enable EDAC on arm64
In-Reply-To: <20131125182002.GD28201@mudshark.cambridge.arm.com>
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
 <20131125182002.GD28201@mudshark.cambridge.arm.com>
Message-ID: <CAL_JsqKWaRTVVcA=Ok0L3HyShKtEeUud-JJ6TJA3taXG2wnZTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 12:20 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Nov 22, 2013 at 09:05:08PM +0000, Rob Herring wrote:
>> diff --git a/arch/arm64/include/asm/edac.h b/arch/arm64/include/asm/edac.h
>> new file mode 100644
>> index 0000000..6d2d262
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/edac.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * Copyright 2013 Calxeda, Inc.
>> + * Based on PPC version Copyright 2007 MontaVista Software, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#ifndef ASM_EDAC_H
>> +#define ASM_EDAC_H
>> +/*
>> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
>> + * Implements the per arch atomic_scrub() that EDAC use for software
>> + * ECC scrubbing.  It reads memory and then writes back the original
>> + * value, allowing the hardware to detect and correct memory errors.
>> + */
>> +static inline void atomic_scrub(void *va, u32 size)
>> +{
>> +     unsigned int *virt_addr = va;
>> +     unsigned int i;
>> +
>> +     for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
>> +             long result;
>> +             unsigned long tmp;
>> +
>> +             asm volatile("// atomic_scrub\n"
>> +             "1:     ldxr    %w0, %2\n"
>> +             "       stxr    %w1, %w0, %2\n"
>> +             "       cbnz    %w1, 1b"
>> +                     : "=&r" (result), "=&r" (tmp), "+Q" (*virt_addr)
>> +                     : : "cc");
>
> You still don't need the "cc" clobber (cbnz doesn't update the flags and,
> yes, we have redundant clobbers in our atomic.h which I'll fix...).

Okay, I thought since the first version did not have the cbnz was why
you said to remove it.

Rob
