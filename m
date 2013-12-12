From: vkale@apm.com (Vinayak Kale)
Date: Thu, 12 Dec 2013 12:03:59 +0530
Subject: [PATCH V7 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <CAPrCYkfS9h_yoQMcrQDXpW_3FcSfiPz0aeNX+_gc=G4exSEVWg@mail.gmail.com>
References: <1386151791-4881-1-git-send-email-vkale@apm.com>
 <1386151791-4881-3-git-send-email-vkale@apm.com>
 <20131209165003.GJ13908@mudshark.cambridge.arm.com>
 <CAPrCYkfS9h_yoQMcrQDXpW_3FcSfiPz0aeNX+_gc=G4exSEVWg@mail.gmail.com>
Message-ID: <CAPrCYkct6XePhYEEC=x0yNQoS-z=fcp2_WKxU1Zk0eO=9+ZaLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Dec 10, 2013 at 1:00 PM, Vinayak Kale <vkale@apm.com> wrote:
> Hi Will,
>
>
> On Mon, Dec 9, 2013 at 10:20 PM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Vinayak,
>>
>> On Wed, Dec 04, 2013 at 10:09:51AM +0000, Vinayak Kale wrote:
>>> Add support for irq registration when pmu interrupt is percpu.
>>
>> Getting closer...
>>
>>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>>> Signed-off-by: Tuan Phan <tphan@apm.com>
>>> ---
>>>  arch/arm64/kernel/perf_event.c |  108 +++++++++++++++++++++++++++++-----------
>>>  1 file changed, 78 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>>> index cea1594..d8e6667 100644
>>> --- a/arch/arm64/kernel/perf_event.c
>>> +++ b/arch/arm64/kernel/perf_event.c
>>> @@ -22,6 +22,7 @@
>>>
>>>  #include <linux/bitmap.h>
>>>  #include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/export.h>
>>>  #include <linux/perf_event.h>
>>> @@ -363,26 +364,52 @@ validate_group(struct perf_event *event)
>>>  }
>>>
>>>  static void
>>> +armpmu_disable_percpu_irq(void *data)
>>> +{
>>> +     disable_percpu_irq((long)data);
>>> +}
>>
>> Given that we wait for the CPUs to finish enabling/disabling the IRQ, I
>> actually meant pass the pointer to the IRQ, which removes the horrible
>> casts in the caller.
>>
>>> +     if (irq_is_percpu(irq)) {
>>> +             cpumask_clear(&armpmu->active_irqs);
>>
>> Thanks for moving the mask manipulation out. It now makes it obvious that we
>> don't care about the mask at all for PPIs, so that can be removed (the code
>> you have is racy against hotplug anyway).
>>
>> I took the liberty of writing a fixup for you (see below). Can you test it
>> on your platform please?
>
> Below fixup works fine on APM platform.
> Do you want me to send this fixup as part of next revision of the
> patch or will you apply it yourself? (For later case, you have my ack)

Any comments? Do I need to send the fix-up in next revision of patch?

Thanks
-Vinayak
