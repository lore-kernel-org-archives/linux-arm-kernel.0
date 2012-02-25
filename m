From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 25 Feb 2012 11:14:14 +0100
Subject: [PATCH] gic : check if there are pending interrupts
In-Reply-To: <20120224182712.GI22562@n2100.arm.linux.org.uk>
References: <1330091148-15291-1-git-send-email-daniel.lezcano@linaro.org>
 <20120224182712.GI22562@n2100.arm.linux.org.uk>
Message-ID: <4F48B476.3090300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2012 07:27 PM, Russell King - ARM Linux wrote:
> On Fri, Feb 24, 2012 at 02:45:48PM +0100, Daniel Lezcano wrote:
>> The following patch checks if there are pending interrupts on the gic.
>>
>> This function is needed for example for the ux500 cpuidle driver.
>> When the A9 cores and the gic are decoupled from the PRCMU, the idle
>> routine has to check if an interrupt is pending on the gic before entering
>> in retention mode.
>
> So what happens if an interrupt becomes pending after you've checked it
> but before you've gone into retention mode?  This basically sounds like
> one big racy idea to me.

The retention mode for the ux500 SoC is the following:

1 - the gic is decoupled : no interrupts will occur and wake up the 
second core if it is in WFI

2 - the gic settings are copied to the PRCMU which is in charge to wake 
up the cores and recouple the gic. We have to check here if an 
interrupts occurred between 1 and 2 in order to abort the retention mode 
and recouple the gic.

3 - we go to retention mode where the PRCMU waits for both cores to be 
in WFI, then if an interrupt is pending (the interrupt occurred between 
2 -3), or occurs, it recouples the gic and wakes the cores.

Here is the implementation to illustrate this.

static inline int ux500_enter_arm_retention(struct cpuidle_device *dev,
					    struct cpuidle_driver *drv,
						int index)
{
	int this_cpu = smp_processor_id();
	bool recouple = false;

	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &this_cpu);

	if (atomic_inc_return(&master) == num_online_cpus()) {

		/* With this lock, we prevent the other cpu to exit and enter
		 * this function again and become the master */
		if (!spin_trylock(&master_lock))
			goto wfi;

		WARN_ONCE(prcmu_gic_decouple(), "Failed to decouple gic from prcmu");

		/* If an abort occurs, we will have to recouple the gic
		 * manually */
		recouple = true;

		/* At this state, as the gic is decoupled, if the other
		 * cpu is in WFI, we have the guarantee it won't be wake
		 * up, so we can safely go to retention */
		if (!ux500_pm_other_cpu_wfi(this_cpu))
			goto out;

		/* The prcmu will be in charge of watching the interrupts
		 * and wake up the cpus */
		ux500_pm_prcmu_copy_gic_settings();

		/* Check in the meantime an interrupt did
		 * not occur on the gic ... */
		if (gic_pending_irq(0))
			goto out;

		/* ... and the prcmu */
		if (ux500_pm_prcmu_pending_interrupt())
			goto out;

		/* Go to the retention state, the prcmu will wait for the
		 * cpu to go WFI and this is what happens after exiting this
		 * 'master' critical section */
		if (prcmu_set_power_state(PRCMU_AP_IDLE, true, true))
			goto out;

		/* When we switch to retention, the prcmu is in charge
		 * of recoupling the gic automatically */
		recouple = false;

		spin_unlock(&master_lock);
	}
wfi:
	cpu_do_idle();
out:
	atomic_dec(&master);

	if (recouple) {
		WARN_ONCE(prcmu_gic_recouple(), "Failed to recouple gic to prcmu");
		spin_unlock(&master_lock);
	}

	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &this_cpu);

	return index;
}


The function to check if there are pending interrupts on the gic is 
needed for the cpuidle driver, as well as a function to copy the gic 
settings to the PRCMU. Maybe this is too SoC specific and the function 
could moved to the ux500 with some information exported from gic.c, no ?


> Hardware which allows you to go into retention mode with interrupts
> pending which should prevent it (or at least cause it to re-awake) just
> sounds like a massive fail to me.

Well, I don't have an opinion on this :)

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
