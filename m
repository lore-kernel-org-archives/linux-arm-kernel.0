From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 10:57:12 -0600
Subject: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
In-Reply-To: <CALicx6s5NX9ZaEiiGo1A=jT+o7Lpj8Y4ubkHeeK2p3DmZpwQeg@mail.gmail.com>
References: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
 <51F2AC53.3070607@wwwdotorg.org>
 <CALicx6s5NX9ZaEiiGo1A=jT+o7Lpj8Y4ubkHeeK2p3DmZpwQeg@mail.gmail.com>
Message-ID: <51F7F068.8060509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 04:05 AM, Vijay Kilari wrote:
> On Fri, Jul 26, 2013 at 10:35 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 07/25/2013 11:41 PM, vijay.kilari at gmail.com wrote:
>>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>
>>> In case of normal kexec kernel load, all cpu's are offlined
>>> before calling machine_kexec() under kernel_kexec() function.
>>
>> I'm not sure that's true, unless perhaps you have CONFIG_KEXEC_JUMP enabled?
>>
>>> But in case crash panic cpus are relaxed in
>>> machine_crash_nonpanic_core() SMP function but not offlined.
>>>
>>> When crash kernel is loaded with kexec and on panic trigger
>>> machine_kexec() checks for number of cpus online.
>>> If more than one cpu is online machine_kexec() fails to load
>>> with below error
>>>
>>> kexec: error: multiple CPUs still online
>>>
>>> In machine_crash_nonpanic_core() SMP function, offline CPU
>>> before cpu_relax
>>
>>> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
>>
>>> @@ -73,6 +73,7 @@ void machine_crash_nonpanic_core(void *unused)
>>>       crash_save_cpu(&regs, smp_processor_id());
>>>       flush_cache_all();
>>>
>>> +     set_cpu_online(smp_processor_id(), false);
>>
>> I'm not familiar with that API, but it looks like it's just setting the
>> *current* CPU offline. That sounds problematic for two reasons:
>>
>> 1) Setting the current CPU offline sounds like a bad idea; after all,
>> code is still running on it. Presumably you want to offline all other CPUs.
>>
>    machine_crash_nonpanic_core() is a SMP call (smp_call_function) .
>    Setting cpu offline is called for all other CPUs except the caller.

Ah OK, that's what I was missing. This makes sense then.
