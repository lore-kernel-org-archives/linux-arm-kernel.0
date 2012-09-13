From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 13 Sep 2012 18:31:35 +0530
Subject: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use cache
 LoUIS operations
In-Reply-To: <20120913125347.GD2470@linaro.org>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913125347.GD2470@linaro.org>
Message-ID: <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 6:23 PM, Dave Martin <dave.martin@linaro.org> wrote:
> On Thu, Sep 13, 2012 at 11:20:49AM +0100, Lorenzo Pieralisi wrote:
>> In processors like A15/A7 L2 cache is unified and integrated within the
>> processor cache hierarchy, so that it is not considered an outer cache
>> anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
>> all cache levels up to Level of Coherency (LoC) that includes
>> the L2 unified cache.
>>
>> When a single CPU is suspended (CPU idle) a complete L2 clean is not
>> required, so generic cpu_suspend code must clean the data cache using the
>> newly introduced cache LoUIS function.
>>
>> The context and stack pointer (context pointer) are cleaned to main memory
>> using cache area functions that operate on MVA and guarantee that the data
>> is written back to main memory (perform cache cleaning up to the Point of
>> Coherency - PoC) so that the processor can fetch the context when the MMU
>> is off in the cpu_resume code path.
>>
>> outer_cache management remains unchanged.
>
> LoUIS matches the power domain affected by turning a single CPU off
> on most (all?) current v7 SoCs where this matters, but only by coincidence.
> There is no guarantee of that.
>
> The _louis() API is useful, because this is exactly what you need to to
> I-/D-/TLB synchronisation in an SMP OS.  Using it as preparation for
> powering a CPU off feels like misuse, at least in theory.
>
> For powerdown, we would logically need a separate function,
> flush_cache_cpu() or something, whose job is precisely to flush those
> levels which will be affected by the power-down if that single CPU.
>
In the series, there is patch "[PATCH 3/6]" which adds an
API which let you operate on a specific level.

Regards
Santosh
