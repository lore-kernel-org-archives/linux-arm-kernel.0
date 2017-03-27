From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 27 Mar 2017 18:25:27 +0200
Subject: [Question] firmware/psci.c: prevent registering pm_power_off
In-Reply-To: <947a7f4d-63ac-5ce4-007a-ca414cd150e7@arm.com>
References: <64d01077-e2e8-01e2-f763-779a60c0fe68@topic.nl>
 <947a7f4d-63ac-5ce4-007a-ca414cd150e7@arm.com>
Message-ID: <58D93CF7.8090409@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 27-03-17 16:02, Sudeep Holla wrote:
>
>
> On 27/03/17 14:36, Mike Looijmans wrote:
>> Problem: The board uses gpio-poweroff to power down, because the "kill"
>> signal is controlled by an I2C IO expander. This doesn't work because
>> drivers/firmware/psci.c unconditionally registers pm_power_off,
>> resulting in the gpio-poweroff driver to refuse to register. The PSCI
>> firmware isn't actually capable of really turning off the power, but
>> there appears to be no way to tell the psci driver about that.
>>
>
> That's because {SYSTEM_OFF,RESET} functions are mandatory since v0.2 to
> be compliant with a PSCI specification.
>
> So the question is why is PSCI being advertised in the DT if the
> firmware is not compliant ?

The PSCI firmware doesn't have access to the GPIO to turn off power. It 
can start/stop CPUs and similar things that got moved to there.

>> My current workaround is to patch firmware/psci.c and remove this line:
>>
>> pm_power_off = psci_sys_poweroff;
>>
>> However, it would be desirable to have this under, for example,
>> devicetree control. The structure of psci.c doesn't really make that an
>> easy option though, but I'm willing to create a patch to do so.
>>
>
> No, as mentioned above it's mandatory function for the firmware to
> implement to be PSCI compliant, so I see no reason to patch that.
>
>> Is this an option, or is there some ongoing effort in the kernel to make
>> pm_power_off into something more managable?
>>
>> An alternative approach would be to add a flag to the gpio-poweroff to
>> override the pm_power_off value. Would that be a lesser evil?
>>
>
> One approach is to implement SYSTEM_OFF in PSCI using the same GPIO. Thereby
> making it compliant and allowing any secure entity running in the platform
> to shutdown gracefully.

Cannot practically do that. The GPIO to switch the power off is on a IO 
expander on an I2C bus behind a I2C multiplexer on the I2C controller of 
the CPU with a dozen other I2C devices. The PSCI would somehow need 
access to the I2C controller without interfering with the kernel, change 
the multiplexer (again without interfering) and then set the IO in the 
expander chip. The kernel on the other hand has everything it needs to 
do this in just a single device-tree entry.

I'd expect other boards to have similar issues, especially if they're 
modules on a carrier board like this one. The PSCI could turn off the 
CPU, but having it turn off the board completely, even if it could, 
would require board-unique firmware for each board. Hey, that's like 
moving back to the "platform data and code" times like before the 
devicetree was introduced.

-- 
Mike Looijmans


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
