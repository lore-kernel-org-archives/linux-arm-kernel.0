From: nleeder@codeaurora.org (Neil Leeder)
Date: Mon, 23 May 2016 14:22:59 -0400
Subject: [PATCH] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <20160523172527.GK4976@leverpostej>
References: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
 <20160523172527.GK4976@leverpostej>
Message-ID: <f49d58ed-38b4-6284-11c2-8708d8443b14@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/23/2016 01:25 PM, Mark Rutland wrote:
> On Fri, May 20, 2016 at 03:13:07PM -0400, Neil Leeder wrote:
>> L2 registers are accessed using a select register and data
>> register pair. To prevent multiple concurrent writes to the
>> select register by independent drivers, the write to the
>> select register and the associated access of the data register
>> are protected with a lock. All drivers accessing the L2
>> registers use the set and get functions provided by
>> l2-accessors to ensure correct reads and writes to L2 registers.
> 
> What will this be used for? (i.e. which drivers want to touch the L2
> registers?).
> 
> Generally we expect FW to configure the caches and interconnect
> appropriately.

The primary use is in the L2 PMU driver, which will be posted shortly.

> 
>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
>> ---
>>  drivers/soc/qcom/Kconfig              |  9 +++++
>>  drivers/soc/qcom/Makefile             |  1 +
>>  drivers/soc/qcom/l2-accessors.c       | 66 +++++++++++++++++++++++++++++++++++
>>  include/linux/soc/qcom/l2-accessors.h | 27 ++++++++++++++
>>  4 files changed, 103 insertions(+)
>>  create mode 100644 drivers/soc/qcom/l2-accessors.c
>>  create mode 100644 include/linux/soc/qcom/l2-accessors.h
> 
> These are awfully generic file names (and function names). Which SoCs
> does this apply to?
> 
> It would be good to give these more specific names.

It's under soc/qcom, and dependent on ARCH_QCOM and (in v2) also on ARM64. It applies to all QCOM ARM64 SoCs.
Given that it can only be used in a QCOM driver, and the include path has qcom in it, I'd
prefer not to add redundancy by adding another qcom in there.

>> diff --git a/include/linux/soc/qcom/l2-accessors.h b/include/linux/soc/qcom/l2-accessors.h
>> new file mode 100644
>> index 0000000..563c114
>> --- /dev/null
>> +++ b/include/linux/soc/qcom/l2-accessors.h
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Copyright (c) 2011-2016 The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
> 
>> +#ifndef __QCOM_L2_ACCESSORS_H
>> +#define __QCOM_L2_ACCESSORS_H
>> +
>> +#ifdef CONFIG_QCOM_L2_ACCESSORS
>> +void set_l2_indirect_reg(u64 reg_addr, u64 val);
>> +u64 get_l2_indirect_reg(u64 reg_addr);
>> +#else
>> +static inline void set_l2_indirect_reg(u64 reg_addr, u64 val) {}
>> +static inline u64 get_l2_indirect_reg(u64 reg_addr)
>> +{
>> +	return 0;
>> +}
> 
> Surely it would be better to error out on any unintentional use of these
> at build time?

This allows building code which is common to ARM SoCs and QCOM SoCs without having to ifdef out the
QCOM-specific pieces.

> 
> Thanks,
> Mark.
> 

Thanks,
Neil

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
