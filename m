From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 05 Jun 2014 14:08:30 +0100
Subject: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
In-Reply-To: <20140605115116.GE23430@n2100.arm.linux.org.uk>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
 <20140605115116.GE23430@n2100.arm.linux.org.uk>
Message-ID: <53906BCE.6030507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/14 12:51, Russell King - ARM Linux wrote:
> On Thu, Jun 05, 2014 at 10:53:06AM +0100, Daniel Thompson wrote:
>>  static int fiq_def_op(void *ref, int relinquish)
>>  {
>> -	if (!relinquish)
>> +	if (!relinquish) {
>> +		unsigned offset = FIQ_OFFSET;
>> +		no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
>>  		set_fiq_handler(&no_fiq_insn, sizeof(no_fiq_insn));
>> +	}
> ...
>>  void __init init_FIQ(int start)
>>  {
>> -	unsigned offset = FIQ_OFFSET;
>> -	no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
>>  	fiq_start = start;
>>  }
> 
> This is wrong - when the default handler is "reinstalled", this change has
> the effect that we read the first instruction of the existing handler, and
> then write that same instruction back, rather than replacing the first
> instruction with the value that was there at boot.

Thanks. I'll fix this.
