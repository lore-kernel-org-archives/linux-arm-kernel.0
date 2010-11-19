From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Nov 2010 15:36:58 +0000
Subject: [PATCH] arm: Fix GIC distributor initialisation
In-Reply-To: <AANLkTikdQja0u0XEkv2YZ=ez3CgQZg1iVQksGOv_Qg9i@mail.gmail.com>
References: <1290178210-30791-1-git-send-email-pawel.moll@arm.com>
	<AANLkTikdQja0u0XEkv2YZ=ez3CgQZg1iVQksGOv_Qg9i@mail.gmail.com>
Message-ID: <AANLkTim4QTYaPru2b__1KXz0xJoOvRXVwbc-O=9LmbJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2010 15:33, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 19 November 2010 14:50, Pawel Moll <pawel.moll@arm.com> wrote:
>> The code checking interrupt limits was "slightly" wrong, using
>> max() instead of min() value. This hasn't been noticed before
>> because max_irq was never really higher then NR_IRQS...
>>
>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>> ---
>> ?arch/arm/common/gic.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index 772f95f..35a2a0b 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -235,8 +235,8 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
>> ? ? ? ? * Limit this to either the architected maximum, or the
>> ? ? ? ? * platform maximum.
>> ? ? ? ? */
>> - ? ? ? if (max_irq > max(1020, NR_IRQS))
>> - ? ? ? ? ? ? ? max_irq = max(1020, NR_IRQS);
>> + ? ? ? if (max_irq > min(1020, NR_IRQS))
>> + ? ? ? ? ? ? ? max_irq = min(1020, NR_IRQS);
>
> With this change and the GIC supports more than NR_IRQs, we don't
> disable all the interrupts on the GIC further down in this function.
>
> We probably need to have separate variables for the number of hardware
> interrupts and another one based on min(max_hw_irq, NR_IRQS).

Or just move this (with your 'min' change as well):

       if (max_irq > min(1020, NR_IRQS))
               max_irq = min(1020, NR_IRQS);

before the final 'for' loop.

-- 
Catalin
