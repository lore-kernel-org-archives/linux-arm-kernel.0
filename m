From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Jun 2016 09:19:17 +0100
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <57737F24.5050906@huawei.com>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
 <57737F24.5050906@huawei.com>
Message-ID: <57738485.4010602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/16 08:56, Hanjun Guo wrote:
> Hello Scott,
> 
> On 2016/5/13 12:37, Scott Wood wrote:
> [...]
>>  
>> +#ifdef CONFIG_ARM64
>> +static __always_inline void rewrite_tval(const int access,
>> +		unsigned long evt, struct clock_event_device *clk)
>> +{
>> +	u64 cval_old, cval_new;
>> +	int timeout = 200;
>> +
>> +	do {
>> +		cval_old = __arch_counter_get_cntvct();
>> +		arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
> 
> For not memory mapped timer, it will call arch_timer_reg_write_cp15() which has
> isb() at the end of arch_timer_reg_write_cp15()...
> 
>> +		cval_new = __arch_counter_get_cntvct();
> 
> So there is isb() between counter retry read, I think it's likely cval_new will
> not be equal with cval_old when the cntvct is correct (time lapse is more than
> one arch timer cycle).

Are you saying that the isb will delay the execution of the read so much
that your timer will always change? Well, if your timer is in the GHz
range, maybe. But that also implies that it is out of spec (it should be
in the 1-50MHz range).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
