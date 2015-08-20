From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 20 Aug 2015 09:23:29 +0200
Subject: [PATCH v5 1/5] arm/arm64: add smccc ARCH32
In-Reply-To: <55D460E7.9070104@gmail.com>
References: <1439973629-19505-1-git-send-email-jens.wiklander@linaro.org>
 <1439973629-19505-2-git-send-email-jens.wiklander@linaro.org>
 <55D460E7.9070104@gmail.com>
Message-ID: <20150820072329.GA24984@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 01:56:39PM +0300, Yury wrote:
[...]
> > +++ b/include/linux/arm-smccc.h
> > @@ -0,0 +1,79 @@
> > +/*
> > + * Copyright (c) 2015, Linaro Limited
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +#ifndef __LINUX_ARM_SMCCC_H
> > +#define __LINUX_ARM_SMCCC_H
> > +
> > +#include <linux/types.h>
> > +
> > +/*
> > + * This file provideds defines common defines for ARM SMC Calling
> 
> typos here?

Thanks

> 
> > + * Convention as specified in
> > + * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> > + */
> > +
> > +#define SMCCC_SMC_32			(0 << 30)
> 
> 0 << 30 is just 0, and so meaningless.
> It's better to introduce SMCCC_IS_32() macro instead.

SMCCC_SMC_32 is used as an argument for SMCCC_CALL_VAL (example in
"[PATCH v5 4/5] tee: add OP-TEE driver" drivers/tee/optee/optee_smc.h).
Shifting 0 here is still 0 as you point out, but it connects it with the
other define SMCCC_SMC_64.

> 
> > +#define SMCCC_SMC_64			(1 << 30)
> > +#define SMCCC_FAST_CALL			(1 << 31)
> > +#define SMCCC_STD_CALL			(0 << 31)
> 
> The same
> 
> > +
> > +#define SMCCC_OWNER_MASK		0x3F
> > +#define SMCCC_OWNER_SHIFT		24
> > +
> > +#define SMCCC_FUNC_MASK			0xFFFF
> > +
> > +#define SMCCC_IS_FAST_CALL(smc_val)	((smc_val) & SMCCC_FAST_CALL)
> > +#define SMCCC_IS_64(smc_val)		((smc_val) & SMCCC_SMC_64)
> > +#define SMCCC_FUNC_NUM(smc_val)		((smc_val) & SMCCC_FUNC_MASK)
> > +#define SMCCC_OWNER_NUM(smc_val) \
> > +	(((smc_val) >> SMCCC_OWNER_SHIFT) & SMCCC_OWNER_MASK)
> > +
> > +#define SMCCC_CALL_VAL(type, calling_convention, owner, func_num) \
> > +			((type) | (calling_convention) | \
> > +			(((owner) & SMCCC_OWNER_MASK) << SMCCC_OWNER_SHIFT) | \
> > +			((func_num) & SMCCC_FUNC_MASK))
> > +
> > +#define SMCCC_OWNER_ARCH		0
> > +#define SMCCC_OWNER_CPU			1
> > +#define SMCCC_OWNER_SIP			2
> > +#define SMCCC_OWNER_OEM			3
> > +#define SMCCC_OWNER_STANDARD		4
> > +#define SMCCC_OWNER_TRUSTED_APP		48
> > +#define SMCCC_OWNER_TRUSTED_APP_END	49
> > +#define SMCCC_OWNER_TRUSTED_OS		50
> > +#define SMCCC_OWNER_TRUSTED_OS_END	63
> > +
> > +struct smccc_param32 {
> > +	u32 a0;
> > +	u32 a1;
> > +	u32 a2;
> > +	u32 a3;
> > +	u32 a4;
> > +	u32 a5;
> > +	u32 a6;
> > +	u32 a7;
> > +};
> > +
> > +/**
> > + * smccc_call32() - make ARCH32 SMC calls
> > + * @param: values to pass in registers 0 to 7
> > + *
> > + * This function is used to make SMC calls following SMC Calling
> Convention
> > + * for ARCH32 calls. The content of the supplied param are copied to
> > + * registers 0 to 7 prior to the SMC instruction. Values a0..a3
> are updated
> > + * with the content from register 0 to 3 on return from the SMC
> > + * instruction.
> > + */
> > +void smccc_call32(struct smccc_param32 *param);
> > +
> > +#endif /*__LINUX_ARM_SMCCC_H*/
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
Thanks,
Jens
