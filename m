From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 19 Apr 2012 23:59:13 -0700
Subject: [PATCH 01/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <1334660025-20442-2-git-send-email-bryan.wu@canonical.com>
References: <1334660025-20442-1-git-send-email-bryan.wu@canonical.com>
 <1334660025-20442-2-git-send-email-bryan.wu@canonical.com>
Message-ID: <4F910941.4000702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2012 3:53 AM, Bryan Wu wrote:
> +static int __init ledtrig_cpu_init(void)
> +{
> +	int cpu;
> +
> +	/* Supports up to 9999 cpu cores */
> +	BUILD_BUG_ON(CONFIG_NR_CPUS > 9999);
> +
> +	/*
> +	 * Registering CPU led trigger for each CPU cores here
> +	 * ignores CPU hotplug, but after this CPU hotplug works
> +	 * fine with this trigger.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct led_trigger *trig;
> +		char *name = per_cpu(trig_name, cpu);
> +		struct rw_semaphore *lock = &per_cpu(trig_lock, cpu);
> +
> +		init_rwsem(lock);

What is this lock protecting?

> +
> +		snprintf(name, MAX_NAME_LEN, "cpu%d", cpu);
> +
> +		down_write(lock);
> +		led_trigger_register_simple(name, &trig);
> +		per_cpu(cpu_trig, cpu) = trig;
> +		up_write(lock);

This is the only place it is locked and unlocked.

I think the previous comment was about how led_trigger_register_simple()
exposed a live trigger but it wasn't assigned to the per_cpu variable
yet. Can we not just reorder the assignment so we have

  struct led_trigger *trig = NULL;
  ...
  per_cpu(cpu_trig, cpu) = trig;
  led_trigger_register_simple();

?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
