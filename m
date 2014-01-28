From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 28 Jan 2014 15:48:43 -0600
Subject: [RFC/PATCH] ARM: vDSO gettimeofday using generic timer
 architecture
In-Reply-To: <20140128212245.GQ15937@n2100.arm.linux.org.uk>
References: <1390926308-15581-1-git-send-email-steve.capper@linaro.org>
 <1390943213-5698-1-git-send-email-nathan_lynch@mentor.com>
 <20140128212245.GQ15937@n2100.arm.linux.org.uk>
Message-ID: <52E825BB.6010901@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 03:22 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 28, 2014 at 03:06:53PM -0600, Nathan Lynch wrote:
>> +static union {
>> +	struct vdso_data	data;
>> +	u8			page[PAGE_SIZE];
>> +} vdso_data_store __page_aligned_data;
>> +struct vdso_data *vdso_data = &vdso_data_store.data;
> 
> So this is in the kernel data segment.
> 
>> +void update_vsyscall(struct timekeeper *tk)
>> +{
>> +	struct timespec xtime_coarse;
>> +	struct timespec wall_time = tk_xtime(tk);
>> +	struct timespec *wtm = &tk->wall_to_monotonic;
>> +	u32 use_syscall = strcmp(tk->clock->name, "arch_sys_counter");
>> +
>> +	++vdso_data->tb_seq_count;
>> +	smp_wmb();
>> +
>> +	xtime_coarse = __current_kernel_time();
>> +	vdso_data->use_syscall			= use_syscall;
>> +	vdso_data->xtime_coarse_sec		= xtime_coarse.tv_sec;
>> +	vdso_data->xtime_coarse_nsec		= xtime_coarse.tv_nsec;
>> +
>> +	if (!use_syscall) {
>> +		vdso_data->cs_cycle_last	= tk->clock->cycle_last;
>> +		vdso_data->xtime_clock_sec	= wall_time.tv_sec;
>> +		vdso_data->xtime_clock_nsec	= wall_time.tv_nsec;
>> +		vdso_data->cs_mult		= tk->mult;
>> +		vdso_data->cs_shift		= tk->shift;
>> +		vdso_data->wtm_clock_sec	= wtm->tv_sec;
>> +		vdso_data->wtm_clock_nsec	= wtm->tv_nsec;
>> +	}
>> +
>> +	smp_wmb();
>> +	++vdso_data->tb_seq_count;
>> +}
>> +
>> +void update_vsyscall_tz(void)
>> +{
>> +	vdso_data->tz_minuteswest	= sys_tz.tz_minuteswest;
>> +	vdso_data->tz_dsttime		= sys_tz.tz_dsttime;
>> +}
> 
> which gets written to directly, and read from userspace.  This won't work
> with aliasing caches, of which we have VIVT caches on all ARMv4 and ARMv5
> CPUs, and VIPT caches on some ARMv6.
> 
> Either this needs to be limited to just VIPT nonaliasing caches, or it
> needs cache handling.

Thanks, I will address this.

> 
> The above also looks rather unsafe from the SMP perspective - how does
> vdso_data->tb_seq_count protect this data between CPUs?

It doesn't -- it merely provides a mechanism for signaling the
consistency of the data userspace reads from the page.  It's basically a
seqlock.

Looks like timekeeper_lock in kernel/time/timekeeping.c prevents
concurrent calls to update_vsyscall.  I could document that dependency...
