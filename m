From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Sat, 12 Feb 2011 22:53:54 +0530
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <20110212162148.GA22402@n2100.arm.linux.org.uk>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
	<AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
	<20110212162148.GA22402@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimbQMrYqKj_FcfiOaYV=MJGpX=HvSvt-AVMdv0G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sat, Feb 12, 2011 at 9:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Feb 12, 2011 at 09:45:45PM +0530, viresh kumar wrote:

[...]

>> We are not modifying flush_cache_all. L2 cache is not flushed from there.
>> Actually as soon as L1 Cache is flushed and disabled, spin_lock is taken from
>> some other thread. This creates problem for our platform, as we do not have
>> monitors support at L2 thus failing strex instruction.
>>
>> If we disable L2 then reboot works fine, as expected.
>
> Again, this should not be happening:
>
> void smp_send_stop(void)
> {
> ? ? ? ?unsigned long timeout;
>
> ? ? ? ?if (num_online_cpus() > 1) {
> ? ? ? ? ? ? ? ?cpumask_t mask = cpu_online_map;
> ? ? ? ? ? ? ? ?cpu_clear(smp_processor_id(), mask);
>
> ? ? ? ? ? ? ? ?smp_cross_call(&mask, IPI_CPU_STOP);
> ? ? ? ?}
>
> ? ? ? ?/* Wait up to one second for other CPUs to stop */
> ? ? ? ?timeout = USEC_PER_SEC;
> ? ? ? ?while (num_online_cpus() > 1 && timeout--)
> ? ? ? ? ? ? ? ?udelay(1);
>
> ? ? ? ?if (num_online_cpus() > 1)
> ? ? ? ? ? ? ? ?pr_warning("SMP: failed to stop secondary CPUs\n");
> }
>
> void machine_shutdown(void)
> {
> #ifdef CONFIG_SMP
> ? ? ? ?smp_send_stop();
> #endif
> }
>
> void machine_restart(char *cmd)
> {
> ? ? ? ?machine_shutdown();
> ? ? ? ?arm_pm_restart(reboot_mode, cmd);
> }
>
> smp_send_stop() brings the other CPUs down to a quiescent state, waits for
> up to one second for that to happen, and then starts flushing caches etc.
> No other CPU should be active at the point where arm_pm_restart() is
> called. ?There should be no other threads active on either this or any
> other CPU.

Thanks, we got it. This was missing in linux-2.6.37 where the code was

 void smp_send_stop(void)
 {
         cpumask_t mask = cpu_online_map;
         cpu_clear(smp_processor_id(), mask);
         if (!cpus_empty(mask))
                 send_ipi_message(&mask, IPI_CPU_STOP);
 }

I would try this change and see if it works for me.

-- 
regards
Shiraz Hashim
