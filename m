From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 27 Mar 2017 15:36:53 +0200
Subject: [Question] firmware/psci.c: prevent registering pm_power_off
Message-ID: <64d01077-e2e8-01e2-f763-779a60c0fe68@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Problem: The board uses gpio-poweroff to power down, because the "kill" signal 
is controlled by an I2C IO expander. This doesn't work because 
drivers/firmware/psci.c unconditionally registers pm_power_off, resulting in 
the gpio-poweroff driver to refuse to register. The PSCI firmware isn't 
actually capable of really turning off the power, but there appears to be no 
way to tell the psci driver about that.

My current workaround is to patch firmware/psci.c and remove this line:

pm_power_off = psci_sys_poweroff;

However, it would be desirable to have this under, for example, devicetree 
control. The structure of psci.c doesn't really make that an easy option 
though, but I'm willing to create a patch to do so.

Is this an option, or is there some ongoing effort in the kernel to make 
pm_power_off into something more managable?

An alternative approach would be to add a flag to the gpio-poweroff to 
override the pm_power_off value. Would that be a lesser evil?


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
