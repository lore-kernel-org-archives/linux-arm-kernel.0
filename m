From: jason77.wang@gmail.com (jason)
Date: Thu, 03 Jun 2010 22:36:17 +0800
Subject: [V2 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100603135705.GA25357@pengutronix.de>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>
	<20100603123908.GB3527@matterhorn.lan>
	<20100603135705.GA25357@pengutronix.de>
Message-ID: <4C07BDE1.6020404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Thu, Jun 03, 2010 at 03:39:08PM +0300, Amit Kucheria wrote:
>   
>> Two comments inline.
>>
>> On 10 Jun 03, Jason Wang wrote:
>>     
>>> 3-stack is a reference board from Freescale for their i.MX51 SoC.
>>>
>>> Add board definition, Kconfig and Makefile to enable Freescale 3-stack
>>> board.
>>>
>>> Boot tested on a i.MX51 3-stack Rev2.0 board
>>>
>>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>>> ---
>>>  arch/arm/mach-mx5/Kconfig                       |    5 +
>>>  arch/arm/mach-mx5/Makefile                      |    2 +-
>>>  arch/arm/mach-mx5/board-mx51_3ds.c              |  263 +++++++++++++++++++++++
>>>  arch/arm/plat-mxc/include/mach/board-mx51_3ds.h |   70 ++++++
>>>  arch/arm/plat-mxc/include/mach/iomux-mx51.h     |   10 +-
>>>  5 files changed, 345 insertions(+), 5 deletions(-)
>>>  create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
>>>  create mode 100644 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
>>>
>>> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
>>> index 1576d51..6d45f44 100644
>>> --- a/arch/arm/mach-mx5/Kconfig
>>> +++ b/arch/arm/mach-mx5/Kconfig
>>> @@ -15,4 +15,9 @@ config MACH_MX51_BABBAGE
>>>  	  u-boot. This includes specific configurations for the board and its
>>>  	  peripherals.
>>>  
>>> +config MACH_MX51_3DS
>>> +	bool "Support MX51PDK (3DS)"
>>> +	help
>>> +	  Include support for MX51PDK (3DS) platform. This includes specific
>>> +	  configurations for the board and its peripherals.
>>>  endif
>>> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
>>> index bf23f86..c757c59 100644
>>> --- a/arch/arm/mach-mx5/Makefile
>>> +++ b/arch/arm/mach-mx5/Makefile
>>> @@ -6,4 +6,4 @@
>>>  obj-y   := cpu.o mm.o clock-mx51.o devices.o
>>>  
>>>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
>>> -
>>> +obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
>>> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
>>> new file mode 100644
>>> index 0000000..5da90e9
>>> --- /dev/null
>>> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
>>> @@ -0,0 +1,263 @@
>>> +/*
>>> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
>>> + * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
>>> + *
>>> + * The code contained herein is licensed under the GNU General Public
>>> + * License. You may obtain a copy of the GNU General Public License
>>> + * Version 2 or later at the following locations:
>>> + *
>>> + * http://www.opensource.org/licenses/gpl-license.html
>>> + * http://www.gnu.org/copyleft/gpl.html
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/io.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/gpio.h>
>>> +#include <linux/smsc911x.h>
>>>
>>>       
<snip>
>>> +static struct platform_device smsc_lan9217_device = {
>>> +	.name = "smsc911x",
>>> +	.id = 0,
>>> +	.dev = {
>>> +		.platform_data = &smsc911x_config,
>>> +	},
>>> +	.num_resources = ARRAY_SIZE(smsc911x_resources),
>>> +	.resource = smsc911x_resources,
>>> +};
>>>       
>> You forgot to move this platform_device to devices.c
>>     
>
> No, devices.c is the place for the i.MX51 integrated peripherals, not
> for externally conntected peripherals.
>
> Sascha
>
>   
Yes, this device is board specific, not the one of i.MX51 SOC.
I think it's better to keep it in the board specific file.

Thanks,
Jason.
