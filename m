From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Sep 2012 17:08:31 -0500
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5050E965.5080405@linutronix.de>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
 <5050CE33.9060909@ti.com> <5050E965.5080405@linutronix.de>
Message-ID: <505107DF.5020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 02:58 PM, Sebastian Andrzej Siewior wrote:
> On 09/12/2012 08:02 PM, Cyril Chemparathy wrote:
>>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>>> unsigned long end)
>>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>>
>>> Why not phys_addr_t?
>>>
>>
>> The rest of the memory specific bits of the device-tree code use u64 for
>> addresses, and I kept it the same for consistency.
> 
> Geert is right here. If it is a physical address, it should be
> phys_addr_t.

While generally true, for the DT specific code I think it should be a
fixed u64. The size of the address is defined by the FDT, not the
kernel. It is very likely we could have a FDT that specifies addresses
in 64-bit values, but then we boot a kernel is compiled for !LPAE.
phys_addr_t is currently sized based on LPAE setting.

Also, this is how the memory and reserved nodes are handled currently,
so we should be consistent.

Rob
