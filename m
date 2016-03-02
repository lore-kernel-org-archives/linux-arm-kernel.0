From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2016 21:38:57 +0000
Subject: [v8,2/4] arm: add implementation for arm-smccc
In-Reply-To: <20160302212628.GA12740@borg.dal.design.ti.com>
References: <1451912079-29258-3-git-send-email-jens.wiklander@linaro.org>
 <20160302212628.GA12740@borg.dal.design.ti.com>
Message-ID: <20160302213857.GI7637@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:26:28PM -0600, Andreas Dannenberg wrote:
> On Mon, Jan 04, 2016 at 01:54:37PM +0100, Jens Wiklander wrote:
> > diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
> > new file mode 100644
> > index 0000000..2e48b67
> > --- /dev/null
> > +++ b/arch/arm/kernel/smccc-call.S
> > @@ -0,0 +1,62 @@
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
> > +#include <linux/linkage.h>
> > +
> > +#include <asm/opcodes-sec.h>
> > +#include <asm/opcodes-virt.h>
> > +#include <asm/unwind.h>
> > +
> > +	/*
> > +	 * Wrap c macros in asm macros to delay expansion until after the
> > +	 * SMCCC asm macro is expanded.
> > +	 */
> > +	.macro SMCCC_SMC
> > +	__SMC(0)
> > +	.endm
> > +
> > +	.macro SMCCC_HVC
> > +	__HVC(0)
> > +	.endm
> > +
> > +	.macro SMCCC instr
> > +UNWIND(	.fnstart)
> > +	mov	r12, sp
> > +	push	{r4-r7}
> > +UNWIND(	.save	{r4-r7})
> > +	ldm	r12, {r4-r7}
> > +	\instr
> 
> Jens,
> out of curiosity, we don't need any dsb/dmb calls here? I've rummaged
> through some other code here at TI and see such barriers being included
> right before the smc call. However in all fairness I also don't see such
> memory calls included in arch/arm/kernel/psci-call.S that your other
> patch is removing, so either they are really not needed or I didn't look
> right and need to go to have my prescriptions checked.

There are no architectural requirements for a barrier here. My understanding
of the TI code is that it was there to work around buggy firmware.

Will
