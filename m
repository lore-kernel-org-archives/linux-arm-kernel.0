From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 6 Jul 2016 10:39:53 -0600
Subject: [PATCH V2 05/10] firmware: tegra: add BPMP support
In-Reply-To: <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-6-josephl@nvidia.com>
 <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
Message-ID: <577D3459.8080107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 05:39 AM, Alexandre Courbot wrote:
> Sorry, I will probably need to do several passes on this one to
> understand everything, but here is what I can say after a first look:
>
> On Tue, Jul 5, 2016 at 6:04 PM, Joseph Lo <josephl@nvidia.com> wrote:
>> The Tegra BPMP (Boot and Power Management Processor) is designed for the
>> booting process handling, offloading the power management tasks and
>> some system control services from the CPU. It can be clock, DVFS,
>> thermal/EDP, power gating operation and system suspend/resume handling.
>> So the CPU and the drivers of these modules can base on the service that
>> the BPMP firmware driver provided to signal the event for the specific PM
>> action to BPMP and receive the status update from BPMP.
>>
>> Comparing to the ARM SCPI, the service provided by BPMP is message-based
>> communication but not method-based. The BPMP firmware driver provides the
>> send/receive service for the users, when the user concerns the response
>> time. If the user needs to get the event or update from the firmware, it
>> can request the MRQ service as well. The user needs to take care of the
>> message format, which we call BPMP ABI.
>>
>> The BPMP ABI defines the message format for different modules or usages.
>> For example, the clock operation needs an MRQ service code called
>> MRQ_CLK with specific message format which includes different sub
>> commands for various clock operations. This is the message format that
>> BPMP can recognize.
>>
>> So the user needs two things to initiate IPC between BPMP. Get the
>> service from the bpmp_ops structure and maintain the message format as
>> the BPMP ABI defined.

>> diff --git a/include/soc/tegra/bpmp_abi.h b/include/soc/tegra/bpmp_abi.h

>> +#ifndef _ABI_BPMP_ABI_H_
>> +#define _ABI_BPMP_ABI_H_
>> +
>> +#ifdef LK
>> +#include <stdint.h>
>> +#endif
>> +
>> +#ifndef __ABI_PACKED
>> +#define __ABI_PACKED __attribute__((packed))
>> +#endif
>> +
>> +#ifdef NO_GCC_EXTENSIONS
>> +#define EMPTY char empty;
>> +#define EMPTY_ARRAY 1
>> +#else
>> +#define EMPTY
>> +#define EMPTY_ARRAY 0
>> +#endif
>> +
>> +#ifndef __UNION_ANON
>> +#define __UNION_ANON
>> +#endif
>> +/**
>> + * @file
>> + */
>> +
>> +
>> +/**
>> + * @defgroup MRQ MRQ Messages
>> + * @brief Messages sent to/from BPMP via IPC
>> + * @{
>> + *   @defgroup MRQ_Format Message Format
>> + *   @defgroup MRQ_Codes Message Request (MRQ) Codes
>> + *   @defgroup MRQ_Payloads Message Payloads
>> + *   @defgroup Error_Codes Error Codes
>> + * @}
>> + */
>
> ...
>
> There is a lot of stuff in this file, most of which we are not using
> now - this is ok, but unless this is a file synced from an outside
> resource maybe we should trim the structures we don't need and add
> them as we make use of them? It helps dividing the work in bite-size
> chunks.
>
> Regarding the documentation format of this file, is this valid kernel
> documentation since the adoption of Sphynx? Or is it whatever the
> origin is using?

This file is an ABI document published by the BPMP FW team. I believe it 
would be best to use it unmodified.
