From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 16 Jul 2015 10:51:25 +0100
Subject: [PATCH 1/3] nmi: create generic NMI backtrace implementation
In-Reply-To: <20150716093744.GI7557@n2100.arm.linux.org.uk>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
 <E1ZFTSm-0006uz-3s@rmk-PC.arm.linux.org.uk> <55A7753C.9020708@linaro.org>
 <20150716093744.GI7557@n2100.arm.linux.org.uk>
Message-ID: <55A77E9D.2030509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/15 10:37, Russell King - ARM Linux wrote:
> On Thu, Jul 16, 2015 at 10:11:24AM +0100, Daniel Thompson wrote:
>> On 15/07/15 21:39, Russell King wrote:
>>> +void nmi_trigger_all_cpu_backtrace(bool include_self,
>>> +				   void (*raise)(cpumask_t *mask))
>>> +{
>>> +	struct nmi_seq_buf *s;
>>> +	int i, cpu, this_cpu = get_cpu();
>>> +
>>> +	if (test_and_set_bit(0, &backtrace_flag)) {
>>> +		/*
>>> +		 * If there is already a trigger_all_cpu_backtrace() in progress
>>> +		 * (backtrace_flag == 1), don't output double cpu dump infos.
>>> +		 */
>>> +		put_cpu();
>>> +		return;
>>> +	}
>>> +
>>> +	cpumask_copy(to_cpumask(backtrace_mask), cpu_online_mask);
>>> +	if (!include_self)
>>> +		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
>>> +
>>> +	cpumask_copy(&printtrace_mask, to_cpumask(backtrace_mask));
>>> +
>>> +	/*
>>> +	 * Set up per_cpu seq_buf buffers that the NMIs running on the other
>>> +	 * CPUs will write to.
>>> +	 */
>>> +	for_each_cpu(cpu, to_cpumask(backtrace_mask)) {
>>> +		s = &per_cpu(nmi_print_seq, cpu);
>>> +		seq_buf_init(&s->seq, s->buffer, NMI_BUF_SIZE);
>>> +	}
>>> +
>>> +	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
>>> +		pr_info("Sending NMI to %s CPUs:\n",
>>> +			(include_self ? "all" : "other"));
>>> +		raise(to_cpumask(backtrace_mask));
>>
>> On ARM, this code could be running with IRQs locked and with raise()
>> implemented using IRQs. In such as case the IPI will not be raised until the
>> function exists (and perhaps never). Thanks to the timeout we will exit but
>> we end up needlessly failing to print a backtrace for the calling CPU.
>>
>> The solution I used for this was to special case the current CPU and call
>> nmi_cpu_backtrace() directly. Originally I made this logic arm only but I
>> can't really see any reason for this to be arch specific so the logic to do
>> that should probably be included here.
>
> That can be implemented in the arch raise() method if needed - most
> architectures shouldn't need it as if they are properly raising a NMI
> which is, by definition, deliverable with normal IRQs disabled.

Agreed. The bug certainly could be fixed in the ARM raise() function.

However I'm still curious whether there is any architecture that 
benefits from forcing the current CPU into an NMI handler? Why doesn't 
the don't-run-unnecessary-code argument apply here as well?


Daniel.
