From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Nov 2012 07:03:12 -0600
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121112102354.GA2346@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121112102354.GA2346@mudshark.cambridge.arm.com>
Message-ID: <50A0F390.7060800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 04:23 AM, Will Deacon wrote:
> Hi Rob,
> 
> On Sun, Nov 11, 2012 at 03:20:40AM +0000, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Use the previously unused TPIDRPRW register to store percpu offsets.
>> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
>>
>> This saves 2 loads for each percpu variable access which should yield
>> improved performance, but the improvement has not been quantified.
> 
> The patch looks largely fine to me (one minor comment below), but we should
> try and see what the performance difference is like on a few cores before
> merging this. Have you tried something like hackbench to see if the
> difference is measurable there? If not, I guess we'll need something more
> targetted.

Thanks for the suggestion. I'll give it a try.

>> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
>> new file mode 100644
>> index 0000000..9eb7372
>> --- /dev/null
>> +++ b/arch/arm/include/asm/percpu.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * Copyright 2012 Calxeda, Inc.
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
>> +#ifndef _ASM_ARM_PERCPU_H_
>> +#define _ASM_ARM_PERCPU_H_
>> +
>> +/*
>> + * Same as asm-generic/percpu.h, except that we store the per cpu offset
>> + * in the TPIDRPRW.
>> + */
>> +#if defined(CONFIG_SMP) && (__LINUX_ARM_ARCH__ >= 6)
>> +
>> +static inline void set_my_cpu_offset(unsigned long off)
>> +{
>> +	asm volatile("mcr p15, 0, %0, c13, c0, 4	@ set TPIDRPRW" : : "r" (off) : "cc" );
>> +}
> 
> You don't need the "cc" here.

You would think so, but the compiler drops this instruction if you
don't. set_cr does the same thing.

Rob
