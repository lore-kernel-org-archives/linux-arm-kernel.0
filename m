From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 23 Feb 2017 12:58:43 -0800
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <58AF3E06.4030701@gmail.com>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
 <58AF3E06.4030701@gmail.com>
Message-ID: <58AF4D03.7020908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/17 11:54, Frank Rowand wrote:
> On 02/13/17 18:50, Stephen Boyd wrote:
>> The 'blob' we pass into populate_properties() is marked as const,
>> but we cast that const away when we assign the result of
>> fdt_getprop_by_offset() to pp->value. Let's mark value as const
>> instead, so that code can't mistakenly write to the value of the
>> property that we've so far advertised as const.
>>
>> Unfortunately, this exposes a problem with the fdt resolver code,
>> where we overwrite the value member of properties of phandles to
>> update them with their final value. Add a comment for now to
>> indicate where we're potentially writing over const data.
> 
> The resolver should not be over writing anything in the FDT.  I'll
> look at what is going on there.
> 
> The FDT we expose to user space should be the FDT we booted with,
> not something later modified.

It seems that /sys/firmware/fdt is not documented.  I'll look into
fixing that.

-Frank

> 
> -Frank
> 
>>
>> You can see the problem here by loading an overlay dtb into
>> the kernel via the request firmware helper method (not direct
>> loading) and then passing that tree to the resolver on an arm64
>> device. In this case, the firmware data is vmapped with KERNEL_PAGE_RO
>> and the code crashes when attempting to write to the blob to update
>> the phandle properties.
>>
>> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>> ---
>>
>> I was thinking perhaps it would work to store another __be32 variant
>> of the phandle in each device node, but then we still have a problem
>> with properties that have phandles inside them at some offset that we
>> need to update. I guess the only real solution is to deep copy the
>> property in that case and then save around some info to free the
>> duplicated property later on?
>>
>>  drivers/of/base.c     |  2 +-
>>  drivers/of/fdt.c      | 12 ++++++------
>>  drivers/of/resolver.c |  3 +++
>>  include/linux/of.h    |  2 +-
>>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> < snip >
> 
