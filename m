From: sonnyrao@chromium.org (Sonny Rao)
Date: Mon, 18 Apr 2011 14:02:52 -0700
Subject: [PATCH] Fix infinite loop in ARM user perf_event backtrace code
In-Reply-To: <1303148544.13157.1.camel@e102144-lin.cambridge.arm.com>
References: <1302924445-18557-1-git-send-email-sonnyrao@chromium.org>
	<1303148544.13157.1.camel@e102144-lin.cambridge.arm.com>
Message-ID: <BANLkTi=ifFfe-TO1PLf4aXYn0SJTxQ=0Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 10:42 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Sonny,
>
> On Sat, 2011-04-16 at 04:27 +0100, Sonny Rao wrote:
>> The ARM user backtrace code can get into an infinite loop if it
>> runs into an invalid stack frame which points back to itself.
>> This situation has been observed in practice. ?Fix it by capping
>> the number of entries in the backtrace. ?This is also what other
>> architectures do in their backtrace code.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> ---
>> ?arch/arm/kernel/perf_event.c | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
>> index 69cfee0..1e61d60 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -746,7 +746,8 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
>>
>> ? ? ? ? tail = (struct frame_tail __user *)regs->ARM_fp - 1;
>>
>> - ? ? ? while (tail && !((unsigned long)tail & 0x3))
>> + ? ? ? while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
>> + ? ? ? ? ? ? ?tail && !((unsigned long)tail & 0x3))
>> ? ? ? ? ? ? ? ? tail = user_backtrace(tail, entry);
>> ?}
>
> Ok. Please can you put this into Russell's patch system?
>
> Will
>

Ok, sent it to patches at arm.linux.org.uk
hope that'll be sufficient
