From: nleeder@codeaurora.org (Neil Leeder)
Date: Fri, 5 Aug 2016 14:53:47 -0400
Subject: [PATCH v2 1/2] soc: qcom: provide mechanism for drivers to access
 L2 registers
In-Reply-To: <20160805100018.GA25152@leverpostej>
References: <1470345071-9455-1-git-send-email-nleeder@codeaurora.org>
 <1470345071-9455-2-git-send-email-nleeder@codeaurora.org>
 <20160805100018.GA25152@leverpostej>
Message-ID: <b7c298cc-cc7d-c021-95f7-2df6003f212c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/5/2016 06:00 AM, Mark Rutland wrote:
> On Thu, Aug 04, 2016 at 05:11:10PM -0400, Neil Leeder wrote:
>> L2 registers are accessed using a select register and data
>> register pair. To prevent multiple concurrent writes to the
>> select register by independent drivers, the write to the
>> select register and the associated access of the data register
>> are protected with a lock. All drivers accessing the L2
>> registers use the set and get functions provided by
>> l2-accessors to ensure correct reads and writes to L2 registers.
> 
> As of this series, this is only used by the PMU driver. Which other
> drivers do you plan to use this for?
> 
> If there's nothing else planned at the moment, it would be nicer to fold
> these into the PMU driver.
> 

I see a couple of other drivers on codeaurora.org using it: the
Error Reporting (ERP) driver and an adaptive clock generator. 
I'd guess they'll be submitted to LKML but they're not mine so I don't
know when.

As the purpose of this is to be the common interface for multiple drivers
to stop them walking over each other, I think it makes sense to keep
it separate.

> [...]
> 
>> +config QCOM_L2_ACCESSORS
>> +	bool "Qualcomm Technologies L2-cache accessors"
>> +	depends on ARCH_QCOM && ARM64
>> +	help
>> +	  Say y here to enable support for the Qualcomm Technologies
>> +	  L2 accessors.
>> +	  Provides support for accessing registers in the L2 cache
>> +	  for Qualcomm Technologies chips.
> 
> Which chips have this?

Qualcomm Technologies ARM64 chips, so currently QDF24xx family and 
anything Kryo based. I'd assume any future chip families as well.
Given the 'depends on' line, I wasn't sure there was any benefit
to essentially duplicating that in the help text.

> 
> Have drivers select this as necessary. There's no reason for this to be
> used-selectable given this is trivial common infrastructure.

OK, I'll fix that

> 
> [...]
> 
>> +#include <linux/spinlock.h>
>> +#include <linux/export.h>
>> +#include <linux/soc/qcom/l2-accessors.h>
>> +#include <asm/cputype.h>
>> +#include <asm/sysreg.h>
> 
> Nit: please sort these alphabetically.

OK

> 
> [...]
> 
>> +EXPORT_SYMBOL(set_l2_indirect_reg);
> 
> The PMU driver isn't a module, so this doesn't need to be exported.
> Until there's a modular user, please get rid of EXPORT_SYMBOL.
> 
>> +EXPORT_SYMBOL(get_l2_indirect_reg);
> 
> Likewise.

OK to both of these.

> 
> Thanks,
> Mark.
> 

Thank you for the comments.
Neil

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
