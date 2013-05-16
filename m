From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 12:19:48 -0600
Subject: [PATCH 0/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <1368698019.7403.10.camel@jlo-ubuntu-64.nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <51941C58.9060002@wwwdotorg.org>
 <1368698019.7403.10.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51952344.1090003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 03:53 AM, Joseph Lo wrote:
> On Thu, 2013-05-16 at 07:38 +0800, Stephen Warren wrote:
>> On 05/15/2013 04:27 AM, Joseph Lo wrote:
>>> Tegra 114 is different with other Tegra SoC chips. It using ARM Cortex-A15
>>> as CPU core and a enhanced flow controller for CPU power control. So
>>> we need to skip some code that was for Contex-A9 and some other support
>>> code that was for other Tegra SoC chips. Then adding the proper power up
>>> and hot plug control for Tegra114.
>>
>> This series mostly works OK, but I see one problem: I can't hotunplug
>> CPU0, which the commit descriptions and code changes imply I should be
>> able to do:
>>
>> root at localhost:~# echo 0 > /sys/devices/system/cpu/cpu0/online
>> -bash: echo: write error: Operation not permitted
> 
> I want to provide this function originally. But I found the
> tegra_cpu_disable() was removed recently. It was replaced by the common
> cpu_disable() function that didn't allow CPU0 to be un-plugged.

Is there a specific reason for that; is there some problem in the core
ARM code that implies CPU0 should never be disabled?

> But I had verified the CPU0 is OK to be un-plugged on the older
> linux-next branch that tegra_cpu_disable() watn't removed yet.
> 
> Do you want me to add them back to support this function for Tegra114?

If there is a problem removing CPU0 in the core code, the functionality
of this series is OK, although it's probably worth removing the parts
that attempt to make CPU0 hot-unpluggable to reduce the diff size.

If there's no problem removing CPU0, it'd be good to make it work,
although that could be done in followon patches.
