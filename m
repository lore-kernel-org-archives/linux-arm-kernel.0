From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 4 Oct 2013 01:32:14 +0300
Subject: [RFC PATCH] ARM: Flush L2 cache on soft_restart
In-Reply-To: <20131002173131.GC30298@mudshark.cambridge.arm.com>
References: <1380713656-24752-1-git-send-email-taras.kondratiuk@linaro.org>
 <20131002124902.GB29213@mudshark.cambridge.arm.com>
 <CAArO44ufGbRxX8oWR8AFh5_iw0F4CodVp8M07e3FJ09EixpUOA@mail.gmail.com>
 <20131002173131.GC30298@mudshark.cambridge.arm.com>
Message-ID: <CAArO44tgdqusadwRvKEh+wC9vvoYWcmUxHjBoi9+qTAT2-Ga7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2013 20:31, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Oct 02, 2013 at 06:19:30PM +0100, Taras Kondratiuk wrote:
>> On 2 October 2013 15:49, Will Deacon <will.deacon@arm.com> wrote:
>> > On Wed, Oct 02, 2013 at 12:34:16PM +0100, Taras Kondratiuk wrote:
>> >> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> >> index 94f6b05..e359b62 100644
>> >> --- a/arch/arm/kernel/process.c
>> >> +++ b/arch/arm/kernel/process.c
>> >> @@ -103,9 +103,11 @@ void soft_restart(unsigned long addr)
>> >>       local_irq_disable();
>> >>       local_fiq_disable();
>> >>
>> >> -     /* Disable the L2 if we're the last man standing. */
>> >> -     if (num_online_cpus() == 1)
>> >> +     /* Flush and disable the L2 if we're the last man standing. */
>> >> +     if (num_online_cpus() == 1) {
>> >> +             outer_flush_all();
>> >>               outer_disable();
>> >
>> > l2x0_disable already contains a flush, so this doesn't change anything.
>>
>> Unfortunately not everybody uses l2x0_disable().
>> SoC's that use SMC calls for L2 cache maintenance have its own implementation
>> of outer_cache.disable which usually doesn't flush cache implicitly.
>
> In which case, we should probably fix the disabling code to make a flush
> then update callers not to bother with redundant flushing. The flushing
> during the disable code is likely required anyway if there's any
> synchronisation going on.

It makes sense, but a history of the current code looks a bit confusing.
Implicit flush was added in l2x0_disable() as a "side effect" of
commit 38a8914f9ac2379293944f613e6ca24b61373de8
"ARM: 6987/1: l2x0: fix disabling function to avoid deadlock",
while initially disable was just a disable.

Maybe it worth to explicitly document that .disable callback must flush cache?

-- 
Regards,
Taras Kondratiuk
