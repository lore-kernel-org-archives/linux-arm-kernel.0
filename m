From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 04 Mar 2015 17:52:07 +0000
Subject: [PATCH 3/5] arm-cci: Get rid of secure transactions for PMU driver
In-Reply-To: <54F5D6D2.7000801@arm.com>
References: <1425295754-13376-1-git-send-email-suzuki.poulose@arm.com>
 <1425295754-13376-4-git-send-email-suzuki.poulose@arm.com>
 <54F5D6D2.7000801@arm.com>
Message-ID: <54F74647.1050607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 15:44, Sudeep Holla wrote:
>
>
> On 02/03/15 11:29, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Avoid secure transactions while probing the CCI PMU. The
>> existing code makes use of the Peripheral ID2 (PID2) register
>> to determine the revision of the CCI400, which requires a
>> secure transaction. This puts a limitation on the usage of the
>> driver on systems running non-secure Linux(e.g, ARM64).
>>
>> Updated the device-tree binding for cci pmu node to add the explicit
>> revision number for the compatible field.
>>
>> The supported strings are :
>> 	arm,cci-400-pmu,r0
>> 	arm,cci-400-pmu,r1
>> 	arm,cci-400-pmu - DEPRECATED. See NOTE below
>>
>> NOTE: If the revision is not mentioned, we need to probe the cci revision,
>> which could be fatal on a platform running non-secure. We need a reliable way
>> to know if we can poke the CCI registers at runtime on ARM32. We depend on
>> 'mcpm_is_available()' when it is available. mcpm_is_available() returns true
>> only when there is a registered driver for mcpm. Otherwise, we assume that we
>> don't have secure access, and skips probing the revision number(ARM64 case).
>>
>> The MCPM should figure out if it is safe to access the CCI. Unfortunately
>> there isn't a reliable way to indicate the same via dtb. This patch doesn't
>> address/change the current situation. It only deals with the CCI-PMU, leaving
>> the assumptions about the secure access as it has been, prior to this patch.
>>
>> Cc: devicetree at vger.kernel.org
>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>    Documentation/devicetree/bindings/arm/cci.txt |    7 +++--
>>    arch/arm/include/asm/arm-cci.h                |   42 +++++++++++++++++++++++++
>>    arch/arm64/include/asm/arm-cci.h              |   27 ++++++++++++++++
>>    drivers/bus/arm-cci.c                         |   17 +++++++++-
>>    include/linux/arm-cci.h                       |    2 ++
>>    5 files changed, 92 insertions(+), 3 deletions(-)
>>    create mode 100644 arch/arm/include/asm/arm-cci.h
>>    create mode 100644 arch/arm64/include/asm/arm-cci.h
>>
>
> [...]
>
>> diff --git a/arch/arm/include/asm/arm-cci.h b/arch/arm/include/asm/arm-cci.h
>> new file mode 100644
>> index 0000000..936e74a
>> --- /dev/null
>> +++ b/arch/arm/include/asm/arm-cci.h
>> @@ -0,0 +1,42 @@
>> +/*
>> + * arch/arm/include/asm/arm-cci.h
>> + *
>> + * Copyright (C) 2015 ARM Ltd.
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
>> +#ifndef __ASM_ARM_CCI_H
>> +#define __ASM_ARM_CCI_H
>> +
>> +#ifdef CONFIG_MCPM
>> +#include <asm/mcpm.h>
>> +
>> +/*
>> + * We don't have a reliable way of detecting whether,
>> + * if we have access to secure-only registers, unless
>> + * mcpm is registered.
>> + */
>> +static inline int platform_has_secure_cci_access(void)
>
> bool instead of int might be more apt here ?

Yes, I will do that in the next revision.

Thanks
Suzuki
>
> Regards,
> Sudeep
>
