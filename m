From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 20 Aug 2015 13:37:29 +0200
Subject: [PATCH v5 1/5] arm/arm64: add smccc ARCH32
In-Reply-To: <20150819165009.GC10297@arm.com>
References: <1439973629-19505-1-git-send-email-jens.wiklander@linaro.org>
 <1439973629-19505-2-git-send-email-jens.wiklander@linaro.org>
 <20150819165009.GC10297@arm.com>
Message-ID: <20150820113729.GA25962@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 05:50:09PM +0100, Will Deacon wrote:
> On Wed, Aug 19, 2015 at 09:40:25AM +0100, Jens Wiklander wrote:
> > Adds helpers to do SMC based on ARM SMC Calling Convention.
> > CONFIG_HAVE_SMCCC is enabled for architectures that may support
> > the SMC instruction. It's the responsibility of the caller to
> > know if the SMC instruction is supported by the platform.
> 
> [...]
> > diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
> > new file mode 100644
> > index 0000000..3ce7fe8
> > --- /dev/null
> > +++ b/arch/arm64/kernel/smccc-call.S
> > @@ -0,0 +1,34 @@
> > +/*
> > + * Copyright (c) 2015, Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License Version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +#include <linux/linkage.h>
> > +
> > +#define SMC_PARAM_W0_OFFS      0
> > +#define SMC_PARAM_W2_OFFS      8
> > +#define SMC_PARAM_W4_OFFS      16
> > +#define SMC_PARAM_W6_OFFS      24
> > +
> > +/* void smccc_call32(struct smccc_param32 *param) */
> > +ENTRY(smccc_call32)
> > +       stp     x28, x30, [sp, #-16]!
> 
> Why are you saving lr?

Agree, no point in saving lr, but I still need to decrease sp with 16 to
maintain correct alignment. I'll do it with an str instruction instead.

> 
> > +       mov     x28, x0
> > +       ldp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
> > +       ldp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
> > +       ldp     w4, w5, [x28, #SMC_PARAM_W4_OFFS]
> > +       ldp     w6, w7, [x28, #SMC_PARAM_W6_OFFS]
> > +       smc     #0
> > +       stp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
> > +       stp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
> > +       ldp     x28, x30, [sp], #16
> > +       ret
> > +ENDPROC(smccc_call32)
> 
> Could we deal with this like we do for PSCI instead? (see
> __invoke_psci_fn_smc). We could also then rename psci-call.S to fw-call.S
> and stick this in there too.

I assume you're referring to when to use "hvc" and "smc".

I would rather consider smccc_call32() a primitive function that a
driver may use if it's configured to do so, for instance via DT. When an
"hvc" should be used instead of an "smc" up to the driver to decide
based how it's configured.

When merging psci-call.S and smccc-call.S into fw-call.S, what should I
do about smccc.c? I need to export the smccc_call32 function somewhere
as it could be used from a loadable module.

--
Thanks,
Jens
