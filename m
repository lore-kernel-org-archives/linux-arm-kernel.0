From: elder@linaro.org (Alex Elder)
Date: Wed, 14 Nov 2018 20:48:45 -0600
Subject: [RFC PATCH 07/12] soc: qcom: ipa: IPA register abstraction
In-Reply-To: <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-8-elder@linaro.org>
 <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com>
Message-ID: <e9114caf-0c92-7cac-33cd-6bea548b0375@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 9:00 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>> diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
>> new file mode 100644
>> index 000000000000..5e0aa6163235
>> --- /dev/null
>> +++ b/drivers/net/ipa/ipa_reg.c
>> @@ -0,0 +1,972 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (C) 2018 Linaro Ltd.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/io.h>
>> +#include <linux/bitfield.h>
>> +
>> +#include "ipa_reg.h"
>> +
>> +/* I/O remapped base address of IPA register space */
>> +static void __iomem *ipa_reg_virt;
> 
> This should of course be part of the device structure.

Yes, this should have been be in that structure to begin with.

I'm working through doing a comprehensive replacement of
global variables like this with values passed around as
arguments.  I've intended to do it all along but your nudge
pushed it to the top of my list.  It's a *lot* of work, much
more than I realized.  But I'm making rapid progress.

>> +/* struct ipa_reg_desc - descriptor for an abstracted hardware register
>> + *
>> + * @construct - fn to construct the register value from its field structure
>> + * @parse - function to parse register field values into its field structure
>> + * @offset - register offset relative to base address
>> + * @n_ofst - size multiplier for "N-parameterized" registers
>> + */
>> +struct ipa_reg_desc {
>> +       u32 (*construct)(enum ipa_reg reg, const void *fields);
>> +       void (*parse)(enum ipa_reg reg, void *fields, u32 val);
>> +       u32 offset;
>> +       u16 n_ofst;
>> +};
> 
> Indirect function pointers can be a bit expensive in the post-spectre
> days. It's probably not overly important if these are always part of
> an MMIO access function, but you should be careful about using
> these in the data path.

OK.

There used to be a more elaborate scheme for supporting
lots of versions, and I have tried to preserve at least part
of the underlying mechanism (the parse and construct functions).
Not all of these registers use the indirect functions, and
it looks to me like none of them are in the data path.

The most important registers for the fast path are found in
the GSI code.  And that doesn't use this construct--it only
reads and writes 32-bit registers.  (I think it differs
because it was originally developed by a different team.)

> How many different versions do we have to support in practice
I don't know for sure how many versions really were used,
but the original code had about 10 distinct version values,
many of which shared most (but not all) register definitions
(offset and bit field widths) with older versions.

With the upstream code the decision was made to ignore anything
older than IPA version 3 (and 3.5.1 in particular, which is
found in the SDM845 SoC).  

It may be that this parse/construct mechanism isn't justified
at this point.  I thought the way it presented a generic
interface was useful, but with just one (initial) hardware
target we don't (yet) realize its potential benefit.  It could
be added back later, as support for new versions is added.

As of now I don't plan to change this, but if you or someone
else feels it would be better without it I can do that.

					-Alex


>        Arnd
> 
