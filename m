From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Aug 2015 13:35:58 +0200
Subject: [PATCH v5 1/5] arm/arm64: add smccc ARCH32
In-Reply-To: <20150819165009.GC10297@arm.com>
References: <1439973629-19505-1-git-send-email-jens.wiklander@linaro.org>
 <1439973629-19505-2-git-send-email-jens.wiklander@linaro.org>
 <20150819165009.GC10297@arm.com>
Message-ID: <55D5BB9E.3020304@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2015 06:50 PM, Will Deacon wrote:
> On Wed, Aug 19, 2015 at 09:40:25AM +0100, Jens Wiklander wrote:
>> Adds helpers to do SMC based on ARM SMC Calling Convention.
>> CONFIG_HAVE_SMCCC is enabled for architectures that may support
>> the SMC instruction. It's the responsibility of the caller to
>> know if the SMC instruction is supported by the platform.
> 
> [...]
>> diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
>> new file mode 100644
>> index 0000000..3ce7fe8
>> --- /dev/null
>> +++ b/arch/arm64/kernel/smccc-call.S
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Copyright (c) 2015, Linaro Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License Version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +#include <linux/linkage.h>
>> +
>> +#define SMC_PARAM_W0_OFFS      0
>> +#define SMC_PARAM_W2_OFFS      8
>> +#define SMC_PARAM_W4_OFFS      16
>> +#define SMC_PARAM_W6_OFFS      24
>> +
>> +/* void smccc_call32(struct smccc_param32 *param) */
>> +ENTRY(smccc_call32)
>> +       stp     x28, x30, [sp, #-16]!
> 
> Why are you saving lr?
> 
>> +       mov     x28, x0
>> +       ldp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
>> +       ldp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
>> +       ldp     w4, w5, [x28, #SMC_PARAM_W4_OFFS]
>> +       ldp     w6, w7, [x28, #SMC_PARAM_W6_OFFS]
>> +       smc     #0
>> +       stp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
>> +       stp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
>> +       ldp     x28, x30, [sp], #16
>> +       ret
>> +ENDPROC(smccc_call32)
> 
> Could we deal with this like we do for PSCI instead? (see
> __invoke_psci_fn_smc). We could also then rename psci-call.S to fw-call.S
> and stick this in there too.

I think that make sense to make smc, hvc calling more generic. Remove
psci name from __invoke_psci_fn_smc and just use it in other drivers.

Thanks,
Michal
