From: acourbot@nvidia.com (Alex Courbot)
Date: Mon, 18 Nov 2013 12:05:59 +0900
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
Message-ID: <52898417.80601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 12:59 AM, Catalin Marinas wrote:
> On 17 November 2013 08:49, Alexandre Courbot <acourbot@nvidia.com> wrote:
>> The ARM tree includes a firmware_ops interface that is designed to
>> implement support for simple, TrustZone-based firmwares but could
>> also cover other use-cases. It has been suggested that this
>> interface might be useful to other architectures (e.g. arm64) and
>> that it should be moved out of arch/arm.
>
> NAK. I'm for code sharing with arm via common locations but this API
> goes against the ARMv8 firmware standardisation efforts like PSCI,
> encouraging each platform to define there own non-standard interface.

I have to say, I pretty much agree with your NAK.

The reason for this patch is that the suggestion to move firmware_ops 
out of arch/arm is the last (I hope) thing that prevents my Trusted 
Foundation support series from being merged. Now if we can all agree:

* that ARMv8 will only use PSCI
* that there is no use-case of this interface outside of arch/arm as of 
today (and none foreseen in the near future)
* that the firmware_ops interface is quite ARMv7-specific anyway,
* that should a need to move it (for whatever reason) occur later, it 
will be easy to do (as this patch hopefully demonstrates).

... then this has indeed no reason to be. And maybe I can finally get 
Russell's blessing on my series.

>
>> --- /dev/null
>> +++ b/include/linux/platform_firmware.h
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Copyright (C) 2012 Samsung Electronics.
>> + * Kyungmin Park <kyungmin.park@samsung.com>
>> + * Tomasz Figa <t.figa@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _PLATFORM_FIRMWARE_H
>> +#define _PLATFORM_FIRMWARE_H
>> +
>> +#include <linux/bug.h>
>> +
>> +/*
>> + * struct platform_firmware_ops
>> + *
>> + * A structure to specify available firmware operations.
>> + *
>> + * A filled up structure can be registered with
>> + * register_platform_firmware_ops().
>> + */
>> +struct platform_firmware_ops {
>> +       /*
>> +        * Enters CPU idle mode
>> +        */
>> +       int (*do_idle)(void);
>
> Covered by PSCI already.
>
>> +       /*
>> +        * Sets boot address of specified physical CPU
>> +        */
>> +       int (*set_cpu_boot_addr)(int cpu, unsigned long boot_addr);
>
> Covered either by PSCI or spin-table release method (PSCI if firmware
> call is required).
>
>> +       /*
>> +        * Boots specified physical CPU
>> +        */
>> +       int (*cpu_boot)(int cpu);
>
> PSCI.
>
>> +       /*
>> +        * Initializes L2 cache
>> +        */
>> +       int (*l2x0_init)(void);
>
> No L2x0 (L210, L220, PL310) cache on ARMv8. And here I strongly
> recommend the hardware people to make proper external caches which can
> be flushed by standard CPU instructions, not MMIO. Any such caches
> must be enabled by firmware before Linux starts.
>
> The above firmware API is 32-bit ARM only. Form 64-bit ARM, you have
> the choice of PSCI so far but as I said in a long thread to Nico, I'm
> open to other standard interfaces if there are good reasons PSCI
> cannot be used. Note the _standard_ part, I don't want every SoC with
> their own firmware API for standard things like secondary CPU
> booting/hotplug/idle.
>
