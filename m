From: james.morse@arm.com (James Morse)
Date: Tue, 24 Oct 2017 18:34:19 +0100
Subject: [PATCH v4 10/13] firmware: arm_sdei: Add support for CPU and
 system power states
In-Reply-To: <20171018171747.GI21820@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-11-james.morse@arm.com> <20171018171747.GI21820@arm.com>
Message-ID: <59EF799B.4040802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 18/10/17 18:17, Will Deacon wrote:
> On Tue, Oct 17, 2017 at 06:44:29PM +0100, James Morse wrote:
>> When a CPU enters an idle lower-power state or is powering off, we
>> need to mask SDE events so that no events can be delivered while we
>> are messing with the MMU as the registered entry points won't be valid.
>>
>> If the system reboots, we want to unregister all events and mask the CPUs.
>> For kexec this allows us to hand a clean slate to the next kernel
>> instead of relying on it to call sdei_{private,system}_data_reset().
>>
>> For hibernate we unregister all events and re-register them on restore,
>> in case we restored with the SDE code loaded at a different address.
>> (e.g. KASLR).
>>
>> Add all the notifiers necessary to do this. We only support shared events
>> so all events are left registered and enabled over CPU hotplug.

>>  static void sdei_smccc_smc(unsigned long function_id,
>>  			   unsigned long arg0, unsigned long arg1,
>>  			   unsigned long arg2, unsigned long arg3,
>> @@ -544,9 +742,36 @@ static int sdei_probe(struct platform_device *pdev)
>>  		return 0;
>>  	}
>>  
>> +	err = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
>> +				&sdei_cpuhp_up, &sdei_cpuhp_down);
>> +	if (err) {
>> +		pr_warn("Failed to register CPU hotplug notifier...\n");
>> +		return err;
>> +	}
> 
> What prevents CPU hotplug events coming in here?

Nothing, but what would trigger them? This is after the arch code has brought up
secondaries, but before user space is running.


No events are registered by this point, so all that could go wrong is a
freshly-arrived CPU is unmasked, then this probe method fails and assumes it
left cores masked. If you think its possible I can post a patch to bolt it down
some more.

Thanks for taking a look!


Thanks,

James
