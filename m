From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Thu, 11 Aug 2016 13:59:40 -0400
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
In-Reply-To: <20160811155409.GE8232@arm.com>
References: <20160811153744.3212-1-cov@codeaurora.org>
 <20160811155409.GE8232@arm.com>
Message-ID: <e70e4eabbd7e896abf959c0522aa7413@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-11 11:54, Will Deacon wrote:
> On Thu, Aug 11, 2016 at 11:37:44AM -0400, Christopher Covington wrote:
>> From: Brent DeGraaf <bdegraaf@codeaurora.org>
>> 
>> Prior gettimeofday code register read code is not architecturally
>> correct as there is no control flow gating logic enforced
>> immediately prior to the required isb.  Introduce explicit
>> control-flow logic prior to register read in all cases so that
>> the mrs read will always be done after all vdso data elements are
>> read, and read all data elements within the protection logic
>> provided by the sequence counter.
> 
> -ENOPARSE
> 
> Can you explain the problem that you're fixing here, please?
> 
>> Signed-off-by: Brent DeGraaf <bdegraaf@codeaurora.org>
>> ---
>>  arch/arm64/include/asm/vdso_datapage.h |   4 +-
>>  arch/arm64/kernel/vdso.c               |  11 ++--
>>  arch/arm64/kernel/vdso/gettimeofday.S  | 106 
>> +++++++++++++++------------------
>>  3 files changed, 56 insertions(+), 65 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/vdso_datapage.h 
>> b/arch/arm64/include/asm/vdso_datapage.h
>> index 2b9a637..49a0a51 100644
>> --- a/arch/arm64/include/asm/vdso_datapage.h
>> +++ b/arch/arm64/include/asm/vdso_datapage.h
>> @@ -21,6 +21,8 @@
>>  #ifndef __ASSEMBLY__
>> 
>>  struct vdso_data {
>> +	__u32 tb_seq_count;	/* Timebase sequence counter */
>> +	__u32 use_syscall;
>>  	__u64 cs_cycle_last;	/* Timebase at clocksource init */
>>  	__u64 raw_time_sec;	/* Raw time */
>>  	__u64 raw_time_nsec;
>> @@ -30,14 +32,12 @@ struct vdso_data {
>>  	__u64 xtime_coarse_nsec;
>>  	__u64 wtm_clock_sec;	/* Wall to monotonic time */
>>  	__u64 wtm_clock_nsec;
>> -	__u32 tb_seq_count;	/* Timebase sequence counter */
>>  	/* cs_* members must be adjacent and in this order (ldp accesses) */
>>  	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
>>  	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
>>  	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
>>  	__u32 tz_minuteswest;	/* Whacky timezone stuff */
>>  	__u32 tz_dsttime;
>> -	__u32 use_syscall;
>>  };
>> 
>>  #endif /* !__ASSEMBLY__ */
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 076312b..7751667 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -201,10 +201,12 @@ up_fail:
>>   */
>>  void update_vsyscall(struct timekeeper *tk)
>>  {
>> +	register u32 tmp;
>>  	u32 use_syscall = strcmp(tk->tkr_mono.clock->name, 
>> "arch_sys_counter");
>> 
>> -	++vdso_data->tb_seq_count;
>> -	smp_wmb();
>> +	tmp = smp_load_acquire(&vdso_data->tb_seq_count);
>> +	++tmp;
>> +	smp_store_release(&vdso_data->tb_seq_count, tmp);
> 
> This looks busted -- the writes to vdso_data can be reordered before 
> the
> update of tb_seq_count.
> 
> /confused
> 
> Will

The ldar/strl contain implicit barriers that will prevent the reorder, 
similar to the way they allowed removal of the explicit barriers in the 
spinlock code.

Thank you,
Brent
