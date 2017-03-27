From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 27 Mar 2017 15:02:13 +0100
Subject: [Question] firmware/psci.c: prevent registering pm_power_off
In-Reply-To: <64d01077-e2e8-01e2-f763-779a60c0fe68@topic.nl>
References: <64d01077-e2e8-01e2-f763-779a60c0fe68@topic.nl>
Message-ID: <947a7f4d-63ac-5ce4-007a-ca414cd150e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/03/17 14:36, Mike Looijmans wrote:
> Problem: The board uses gpio-poweroff to power down, because the "kill"
> signal is controlled by an I2C IO expander. This doesn't work because
> drivers/firmware/psci.c unconditionally registers pm_power_off,
> resulting in the gpio-poweroff driver to refuse to register. The PSCI
> firmware isn't actually capable of really turning off the power, but
> there appears to be no way to tell the psci driver about that.
> 

That's because {SYSTEM_OFF,RESET} functions are mandatory since v0.2 to
be compliant with a PSCI specification.

So the question is why is PSCI being advertised in the DT if the
firmware is not compliant ?

> My current workaround is to patch firmware/psci.c and remove this line:
> 
> pm_power_off = psci_sys_poweroff;
> 
> However, it would be desirable to have this under, for example,
> devicetree control. The structure of psci.c doesn't really make that an
> easy option though, but I'm willing to create a patch to do so.
> 

No, as mentioned above it's mandatory function for the firmware to
implement to be PSCI compliant, so I see no reason to patch that.

> Is this an option, or is there some ongoing effort in the kernel to make
> pm_power_off into something more managable?
> 
> An alternative approach would be to add a flag to the gpio-poweroff to
> override the pm_power_off value. Would that be a lesser evil?
> 

One approach is to implement SYSTEM_OFF in PSCI using the same GPIO. Thereby
making it compliant and allowing any secure entity running in the platform
to shutdown gracefully.

-- 
Regards,
Sudeep
