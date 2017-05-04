From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 4 May 2017 12:31:34 +0100
Subject: [PATCH 3/4] ARM: perf: Allow the use of the PMUv3 driver on 32bit
 ARM
In-Reply-To: <74692e75-1cb7-21da-be83-7a315e9a84b6@arm.com>
References: <20170324121529.22603-1-marc.zyngier@arm.com>
 <20170324121529.22603-4-marc.zyngier@arm.com>
 <74692e75-1cb7-21da-be83-7a315e9a84b6@arm.com>
Message-ID: <80bb9c65-d456-a49b-5ab1-5683c991c1b5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/17 12:00, Vladimir Murzin wrote:
> Hi Marc,
> 
> On 24/03/17 12:15, Marc Zyngier wrote:
>> The only thing stopping the PMUv3 driver from compiling on 32bit
>> is the lack of defined system registers names. This is easily
>> solved by providing the sysreg accessors and updating the Kconfig entry.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/arm_pmuv3.h | 115 +++++++++++++++++++++++++++++++++++++++
>>  drivers/perf/Kconfig             |   4 +-
>>  2 files changed, 117 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/include/asm/arm_pmuv3.h
>>
>> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
>> new file mode 100644
>> index 000000000000..df14de3d7bdf
>> --- /dev/null
>> +++ b/arch/arm/include/asm/arm_pmuv3.h
>> @@ -0,0 +1,115 @@
>> +/*
>> + * Copyright (C) 2012 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ASM_PMUV3_H
>> +#define __ASM_PMUV3_H
>> +
>> +#include <asm/cp15.h>
>> +
>> +#define pmcr		__ACCESS_CP15(c9, 0, c12, 0)
>> +#define pmselr		__ACCESS_CP15(c9, 0, c12, 5)
>> +#define pmccntr		__ACCESS_CP15_64(0, c9)
>> +#define pmxevcntr	__ACCESS_CP15(c9, 0, c13, 2)
>> +#define pmxevtyper	__ACCESS_CP15(c9, 0, c13, 1)
>> +#define pmcntenset	__ACCESS_CP15(c9, 0, c12, 1)
>> +#define pmcntenclr	__ACCESS_CP15(c9, 0, c12, 2)
>> +#define pmintenset	__ACCESS_CP15(c9, 0, c12, 1)
> 
> Encoding is not right here
> 
> To access the PMINTENSET:
> 
> MRC p15,0,<Rt>,c9,c14,1 ; Read PMINTENSET into Rt
> 
> MCR p15,0,<Rt>,c9,c14,1 ; Write Rt to PMINTENSET
> 
> 
>> +#define pmintenclr	__ACCESS_CP15(c9, 0, c12, 2)
> 
> Ditto
> 
> To access the PMINTENCLR:
> 
> MRC p15,0,<Rt>,c9,c14,2 ; Read PMINTENCLR into Rt
> 
> MCR p15,0,<Rt>,c9,c14,2 ; Write Rt to PMINTENCLR

Arghh, -ECOPYPASTE. Thanks for the heads up!

> 
> 
>> +#define pmovsclr	__ACCESS_CP15(c9, 0, c12, 3)
> 
> Nit: in 32-bit world it is named as PMOVSR.
> 
>> +#define pmceid0		__ACCESS_CP15(c9, 0, c12, 6)
>> +#define pmceid1		__ACCESS_CP15(c9, 0, c12, 7)
> 
> Can all these defines be done in uppercase to be in align with existent users
> of __ACCESS_CP15() macro?

Sure, that shouldn't be an issue.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
