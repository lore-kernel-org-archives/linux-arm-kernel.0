From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 07 Mar 2013 13:41:44 -0800
Subject: [PATCH 01/10] clocksource: add generic dummy timer driver
In-Reply-To: <alpine.LFD.2.02.1303071457300.22263@ionos>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-2-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.02.1303071457300.22263@ionos>
Message-ID: <51390998.3090303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/13 06:00, Thomas Gleixner wrote:
> On Wed, 6 Mar 2013, Stephen Boyd wrote:
>
>> +static int __init dummy_timer_register(void)
>> +{
>> +	int err = register_cpu_notifier(&dummy_timer_cpu_nb);
>> +	if (err)
>> +		return err;
>> +
>> +	/* We won't get a call on the boot CPU, so register immediately */
>> +	dummy_timer_setup();
>> +
>> +	return 0;
>> +}
>> +device_initcall(dummy_timer_register);
> Are you sure that you want that to be installed unconditionally? What
> about multi-platform kernels?
>

A dummy timer is already installed unconditionally on devices with an
arm architected timer, so if this is breaking something then those
devices have been broken in the 3.9 merge window. I suppose we may need
to make the rating even lower if there is somebody using a clockevent
with a rating below 100. My grep of the tree shows 125 as the lowest,
but perhaps we want to set the rating to 1 to be safe?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
