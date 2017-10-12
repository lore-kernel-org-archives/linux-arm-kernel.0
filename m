From: jim2101024@gmail.com (Jim Quinlan)
Date: Thu, 12 Oct 2017 14:15:30 -0400
Subject: [PATCH 4/9] arm64: dma-mapping: export symbol arch_setup_dma_ops
In-Reply-To: <a8fa87e4-4d70-eb60-f1c5-94071d6394aa@arm.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-5-git-send-email-jim2101024@gmail.com>
 <a8fa87e4-4d70-eb60-f1c5-94071d6394aa@arm.com>
Message-ID: <CANCKTBuerHizxzY7BL-jP7L=z4g0=+2tfeafJnEJVkZ1zV+z-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 1:06 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/10/17 23:34, Jim Quinlan wrote:
>> The BrcmSTB driver needs to get ahold of a pointer to swiotlb_dma_ops.
>> However, that variable is defined as static.  Instead, we use
>> arch_setup_dma_ops() to get the pointer to swiotlb_dma_ops.  Since
>> we also want our driver to be a separate module, we need to
>> export this function.
>
> NAK. Retrieve the platform-assigned ops from the device via
> get_dma_ops() and stash them in your drvdata or wherever before you
> replace them. Don't go poking around arch code internals directly from a
> driver.
Will fix (and drop the commit).

>
> Robin.
>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 614af88..dae572f 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -936,3 +936,4 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>       }
>>  #endif
>>  }
>> +EXPORT_SYMBOL(arch_setup_dma_ops);
>>
>
