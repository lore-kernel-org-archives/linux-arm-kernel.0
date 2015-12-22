From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue, 22 Dec 2015 10:46:08 +0100
Subject: [PATCH v6] arm/arm64: add arm-smccc
In-Reply-To: <20151221111455.GA11145@red-moon>
References: <1449667495-23091-1-git-send-email-jens.wiklander@linaro.org>
 <20151221111455.GA11145@red-moon>
Message-ID: <20151222094606.GA30272@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 11:14:55AM +0000, Lorenzo Pieralisi wrote:
> On Wed, Dec 09, 2015 at 02:24:55PM +0100, Jens Wiklander wrote:
> > Adds helpers to do SMC and HVC based on ARM SMC Calling Convention.
> > CONFIG_HAVE_ARM_SMCCC is enabled for architectures that may support the
> > SMC or HVC instruction. It's the responsibility of the caller to know if
> > the SMC instruction is supported by the platform.
> > 
> > This patch doesn't provide an implementation of the declared functions.
> > Later patches will bring in implementations and set
> > CONFIG_HAVE_ARM_SMCCC for ARM and ARM64 respectively.
> > 
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > 
> > v6:
> > * Move HAVE_ARM_SMCCC from init/Kconfig
> > 
> >  arch/Kconfig              |  3 ++
> >  include/linux/arm-smccc.h | 98 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 101 insertions(+)
> >  create mode 100644 include/linux/arm-smccc.h
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 4e949e5..ce3c0b0 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -564,4 +564,7 @@ config OLD_SIGACTION
> >  config COMPAT_OLD_SIGACTION
> >  	bool
> >  
> > +config HAVE_ARM_SMCCC
> > +	bool
> 
> It is ok by me to move it there, probably we do not want it at the end of
> the "ABI hall of shame" list :)
> 
> Or drivers/firmware/Kconfig ?

You tell me, I'm too new here to have a feeling for this.

> 
> Strictly speaking, since PSCI uses this by default, you should also
> enforce an ARM_PSCI_FW dependency on HAVE_ARM_SMCCC.

ARM_PSCI depends on CPU_V7 and ARM_PSCI_FW doesn't really depend on
anything today.

Would it be OK if I changed ARM_PSCI to depend on HAVE_ARM_SMCCC instead
of CPU_V7 in the "drivers: psci: replace psci firmware calls" patch?
At the same time I would move the "select HAVE_ARM_SMCCC if CPU_V7" line
to the "config ARM" block instead in the
"arm: add implementation for arm-smccc" patch.

I'll include this change in the v7 patch set if I don't hear anything.

> 
> >  source "kernel/gcov/Kconfig"
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > new file mode 100644
> > index 0000000..dea68a9
> > --- /dev/null
> > +++ b/include/linux/arm-smccc.h
> > @@ -0,0 +1,98 @@
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
> > +#include <linux/linkage.h>
> 
> Nit: alphabetical order please.
> 
> > +
> > +/*
> > + * This file provides common defines for ARM SMC Calling Convention as
> > + * specified in
> > + * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> > + */
> > +
> > +#define ARM_SMCCC_SMC_32		(0 << 30)
> > +#define ARM_SMCCC_SMC_64		(1 << 30)
> > +#define ARM_SMCCC_FAST_CALL		(1 << 31)
> > +#define ARM_SMCCC_STD_CALL		(0 << 31)
> > +
> > +#define ARM_SMCCC_OWNER_MASK		0x3F
> > +#define ARM_SMCCC_OWNER_SHIFT		24
> > +
> > +#define ARM_SMCCC_FUNC_MASK		0xFFFF
> > +
> > +#define ARM_SMCCC_IS_FAST_CALL(smc_val)	((smc_val) & ARM_SMCCC_FAST_CALL)
> > +#define ARM_SMCCC_IS_64(smc_val)	((smc_val) & ARM_SMCCC_SMC_64)
> > +#define ARM_SMCCC_FUNC_NUM(smc_val)	((smc_val) & ARM_SMCCC_FUNC_MASK)
> > +#define ARM_SMCCC_OWNER_NUM(smc_val) \
> > +	(((smc_val) >> ARM_SMCCC_OWNER_SHIFT) & ARM_SMCCC_OWNER_MASK)
> > +
> > +#define ARM_SMCCC_CALL_VAL(type, calling_convention, owner, func_num) \
> > +	((type) | (calling_convention) | \
> 
> Nit: if you use a shift macro for some fields it would be clearer if you use
> for all of them (I am referring to type/calling_convention here), it can
> be changed later.
> 
> Other than that:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks for the review.
--
Jens
