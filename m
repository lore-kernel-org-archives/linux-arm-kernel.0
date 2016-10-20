From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 20 Oct 2016 14:38:32 +0100
Subject: [PATCH v2] drivers: psci: PSCI checker module
In-Reply-To: <e57565e8-bec9-0460-32d5-fb9f868cc4f8@arm.com>
References: <20160921143905.36197-1-kevin.brodsky@arm.com>
 <e57565e8-bec9-0460-32d5-fb9f868cc4f8@arm.com>
Message-ID: <613e4387-0ed5-ad58-7b74-a31b648f81e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Philippe,

On 18/10/16 20:21, Jean-Philippe Brucker wrote:
> Hi Kevin,
>
> On 21/09/16 15:39, Kevin Brodsky wrote:
>> On arm and arm64, PSCI is one of the possible firmware interfaces
>> used for power management. This includes both turning CPUs on and off,
>> and suspending them (entering idle states).
>>
>> This patch adds a PSCI checker module that enables basic testing of
>> PSCI operations during startup. There are two main tests: CPU
>> hotplugging and suspending.
>>
>> In the hotplug tests, the hotplug API is used to turn off and on again
>> all CPUs in the system, and then all CPUs in each cluster, checking
>> the consistency of the return codes.
>>
>> In the suspend tests, a high-priority thread is created on each core
>> and uses low-level cpuidle functionalities to enter suspend, in all
>> the possible states and multiple times. This should allow a maximum
>> number of CPUs to enter the same sleep state at the same or slightly
>> different time.
>>
>> In essence, the suspend tests use a principle similar to that of the
>> intel_powerclamp driver (drivers/thermal/intel_powerclamp.c), but the
>> threads are only kept for the duration of the test (they are already
>> gone when userspace is started).
>>
>> While in theory power management PSCI functions (CPU_{ON,OFF,SUSPEND})
>> could be directly called, this proved too difficult as it would imply
>> the duplication of all the logic used by the kernel to allow for a
>> clean shutdown/bringup/suspend of the CPU (the deepest sleep states
>> implying potentially the shutdown of the CPU).
>>
>> Note that this file cannot be compiled as a loadable module, since it
>> uses a number of non-exported identifiers (essentially for
>> PSCI-specific checks and direct use of cpuidle) and relies on the
>> absence of userspace to avoid races when calling hotplug and cpuidle
>> functions.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>> Changelog v1..v2:
>> * Do not count tick_broadcast_enter() failures as errors, as they may
>>    be unavoidable. When it happens, fall back to WFI.
>> * Do not count unexpected sleep states as errors (currently, the only
>>    case is when falling back to WFI). Instead, report the number of
>>    times it happens before the suspend thread exits.
>> * Use usecs_to_jiffies() to compute the suspend timeout. The previous
>>    version resulted in a zero timeout if the target residency was
>>    shorter than a jiffy.
>> * Various cleanup.
>>
>> Thanks to Lorenzo for his help with improving this patch!
>>
>> Kevin
> [...]
>> +
>> +static int suspend_tests(void)
>> +{
>> +    int i, cpu, err = 0;
>> +    struct task_struct **threads;
>> +    int nb_threads = 0;
>> +
>> +    threads = kmalloc_array(nb_available_cpus, sizeof(*threads),
>> +                            GFP_KERNEL);
>> +    if (!threads)
>> +            return -ENOMEM;
>> +
>> +    for_each_online_cpu(cpu) {
>> +            struct task_struct *thread;
>> +            /* Check that cpuidle is available on that CPU. */
>> +            struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
>> +            struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> +
>> +            if (cpuidle_not_available(drv, dev)) {
>> +                    pr_warn("cpuidle not available on CPU %d, ignoring\n",
>> +                            cpu);
>> +                    continue;
>> +            }
>> +
>> +            thread = kthread_create_on_cpu(suspend_stress_thread,
>> +                                           (void *)(long)cpu, cpu,
>> +                                           "psci_suspend_stress");
>> +            if (IS_ERR(thread))
>> +                    pr_err("Failed to create kthread on CPU %d\n", cpu);
>> +            else
>> +                    threads[nb_threads++] = thread;
>> +    }
>> +    if (nb_threads < 1) {
>> +            kfree(threads);
>> +            return -ENODEV;
>> +    }
>> +
>> +    atomic_set(&nb_active_threads, nb_threads);
>> +
>> +    /*
>> +     * Stop cpuidle to prevent the idle tasks from entering a deep sleep
>> +     * mode, as it might interfere with the suspend threads on other CPUs.
>> +     * This does not prevent the suspend threads from using cpuidle (only
>> +     * the idle tasks check this status).
>> +     */
>> +    cpuidle_pause();
>> +
>> +    /*
>> +     * Unpark the suspend threads. To avoid the main thread being preempted
>> +     * before all the threads have been unparked, the suspend threads will
>> +     * wait for the completion of suspend_threads_started.
>> +     */
>> +    for (i = 0; i < nb_threads; ++i)
>> +            kthread_unpark(threads[i]);
> Just a heads up: this doesn't work anymore, since a65d4096
> (kthread/smpboot: do not park in kthread_create_on_cpu()), in 4.9-rc1. I
> think that the unpark call could be replaced by wake_up_process. The
> comment of kthread_create_on_cpu is now misleading.
>
> Thanks,
> Jean-Philippe
>

Thanks for the heads-up! I'll rebase on 4.9-rc1 and see what needs to be done.

Thanks,
Kevin

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
