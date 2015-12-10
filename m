From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 10 Dec 2015 20:42:12 +0900
Subject: [PATCH v12 12/16] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20151203041525.GG14143@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
 <20151203041525.GG14143@dhcppc13.redhat.com>
Message-ID: <56696514.3030209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush,

On 12/03/2015 01:15 PM, Pratyush Anand wrote:
> Hi Akashi,
>
> Some of the points which came while discussing with Mark Salter are worth
> including in v13.
>
> On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> [...]
>
>> +/**
>> + * machine_crash_shutdown - shutdown non-boot cpus and save registers
>
> "non-panic" would be correct in stead of "non-boot".

OK, but for consistency with other places (say, arm/kernel/machine_kexec.c)
I prefer "non-crashing cpus."

>> +	/* shutdown non-boot cpus */
>
> Ditto
>
>> +	smp_send_stop();
>> +
>> +	/* for boot cpu */
>
> "for panic cpu"

Ditto.
"for crashing cpu"

>
>
> [...]
>
>> @@ -697,6 +704,11 @@ static void ipi_cpu_stop(unsigned int cpu)
>>
>>   	local_irq_disable();
>
> We have "set_cpu_online(cpu, false);" just before it.
> Panic core is waiting for non-panic to go offline, i.e. for the above event.
>
>>
>> +#ifdef CONFIG_KEXEC
>> +	if (in_crash_kexec)
>> +		crash_save_cpu(regs, cpu);
>> +#endif /* CONFIG_KEXEC */
>
> However, we are still saving crash info for non-panic core. So, it would be good
> to move crash_save_cpu() before set_cpu_online() to avoid any race condition.

Good point, race will be very unlikely though. I will fix it.

Thanks,
-Takahiro AKASHI

> ~Pratyush
>
