From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Mon, 8 May 2017 13:54:44 -0600
Subject: [PATCH V15 11/11] arm/arm64: KVM: add guest SEA support
In-Reply-To: <20170508174058.5hbujeblxq5z6iwa@pd.tnic>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-12-git-send-email-tbaicar@codeaurora.org>
 <20170508174058.5hbujeblxq5z6iwa@pd.tnic>
Message-ID: <dade63eb-b231-d7a5-f307-9737d7b088f2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/8/2017 11:40 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 05:05:23PM -0600, Tyler Baicar wrote:
>> Currently external aborts are unsupported by the guest abort
>> handling. Add handling for SEAs so that the host kernel reports
>> SEAs which occur in the guest kernel.
>>
>> When an SEA occurs in the guest kernel, the guest exits and is
>> routed to kvm_handle_guest_abort(). Prior to this patch, a print
>> message of an unsupported FSC would be printed and nothing else
>> would happen. With this patch, the code gets routed to the APEI
>> handling of SEAs in the host kernel to report the SEA information.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> Acked-by: Christoffer Dall <cdall@linaro.org>
...
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>>    * Dispatch a data abort to the relevant handler.
>>    */
>>   asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 612deb3..d286248 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -812,17 +812,18 @@ static int ghes_notify_sci(struct notifier_block *this,
>>   #ifdef CONFIG_ACPI_APEI_SEA
>>   static LIST_HEAD(ghes_sea);
>>   
>> -void ghes_notify_sea(void)
>> +int ghes_notify_sea(void)
>>   {
>>   	struct ghes *ghes;
>> +	int ret = -ENOENT;
>>   
>> -	/*
>> -	 * synchronize_rcu() will wait for nmi_exit(), so no need to
>> -	 * rcu_read_lock().
>> -	 */
>> +	rcu_read_lock();
>>   	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
>> -		ghes_proc(ghes);
>> +		if(!ghes_proc(ghes))
>> +			ret = 0;
> What is the idea here: the first time ghes_proc() returns 0, ret is set
> to 0 and all errors after it will be practically ignored. Looks like it
> needs more love.
This was discussed in the v12 and v13 patch series. There is existing 
code in kvm_handle_guest_abort
for injecting an abort back into the guest. We only want to do that if 
it was an abort that was not
handled by the firmware first handling. So here we verify that at least 
one of the SEA error sources
successfully reported an error record sent from the firmware. If there 
were no errors reported by
firmware, then we want to continue with the current implementation that 
will inject the virtual
abort. (kvm_inject_vabt)

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
