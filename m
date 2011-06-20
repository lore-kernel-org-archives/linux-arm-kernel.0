From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 20 Jun 2011 15:49:57 +0530
Subject: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
In-Reply-To: <20110620095053.GA2082@n2100.arm.linux.org.uk>
References: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com>
	<20110620095053.GA2082@n2100.arm.linux.org.uk>
Message-ID: <4DFF1ECD.8080305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/20/2011 3:20 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2011 at 02:53:59PM +0530, Santosh Shilimkar wrote:
>> The current ARM CPU hotplug code suffers from couple of race conditions
>> in CPU online path with scheduler.
>> The ARM CPU hotplug code doesn't wait for hot-plugged CPU to be marked
>> active as part of cpu_notify() by the CPU which brought it up before
>> enabling interrupts.
>
> Hmm, why not just move the set_cpu_online() call before notify_cpu_starting()
> and add the wait after the set_cpu_online() ?
I think that's what patch is doing. Do you mean, calling hotplug
notifier chain immediately after CPU marked as online. Something
like below.

	set_cpu_online(cpu, true);
	notify_cpu_starting(cpu);
         while (!cpumask_test_cpu(smp_processor_id(), cpu_active_mask))
                 cpu_relax();

         /*
          * Enable local interrupts.
          */
                 local_irq_enable();
         local_fiq_enable();


Regards
Santosh
