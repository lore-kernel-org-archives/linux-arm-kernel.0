From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Feb 2016 17:41:42 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <56C1F19F.8090100@roeck-us.net>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de> <56C1F19F.8090100@roeck-us.net>
Message-ID: <56C20DD6.8050604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/02/16 15:41, Guenter Roeck wrote:
> On 02/15/2016 02:59 AM, Uwe Kleine-K?nig wrote:
>> Hello Guenter,
>>
>> On Sun, Feb 14, 2016 at 08:50:10AM -0800, Guenter Roeck wrote:
>>> Uwe,
>>>
>>> Your patch 'driver-core: platform: probe of-devices only using list of
>>> compatibles' causes the following qemu tests to crash in -next.
>>>
>>> arm:vexpress-a9:vexpress_defconfig:vexpress-v2p-ca9
>>> arm:vexpress-a15:vexpress_defconfig:vexpress-v2p-ca15-tc1
>>> arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
>>> arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
>>>
>>> Crash log:
>>>
>>> VFS: Cannot open root device "mmcblk0" or unknown-block(0,0): error -6
>>> Please append a correct "root=" boot option; here are the available
>>> partitions:
>>> 1f00          131072 mtdblock0  (driver?)
>>> 1f01           32768 mtdblock1  (driver?)
>>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>>> unknown-block(0,0)
>>
>> Can you provide a complete boot log? This might already reveal which
>> device is failing. It might not be the mmci device but something it
>> depends on (clock, bus parent, irq).
>>
>
> Sure, something else may be failing, but why does reverting your patch
> fix the problem ?
>
> Anyway, complete logs are at http://kerneltests.org/builders.
>
> http://kerneltests.org/builders/qemu-arm-next/builds/376/steps/qemubuildcommand/logs/stdio
>
>

Sorry for missing this earlier, I could reproduce this on my TC2.
The issue is with card-detect gpio probing. It's not related to AMBA
probing as discussed on the mail thread.

mfd_add_device adds devices with of_node when cell->of_compatible is
matched, but the device created is expected to be matched based on name
which the patch under discussion clearly breaks.

One other option I see is to set driver_override for mfd devices
(something like below) but I am not sure that can be generic.

-- 
Regards,
Sudeep
