From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 01 Apr 2015 11:21:30 +0200
Subject: [PATCH 0/5] Add standby support for the recent mvebu SoCs
In-Reply-To: <CAPv3WKew5FFsA+ZphXO1hfYcy5hi_SzEBBhyk5QtQ5zn-SAenQ@mail.gmail.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKew5FFsA+ZphXO1hfYcy5hi_SzEBBhyk5QtQ5zn-SAenQ@mail.gmail.com>
Message-ID: <551BB89A.60405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On 01/04/2015 11:02, Marcin Wojtas wrote:
> Hi Gregory,
> 
> When I run standby on A385 I get following error:
> root at localhost:~# echo standby > /sys/power/state
> [  122.889266] PM: System core suspend callback
> mvebu_mbus_suspend+0x0/0xf4 failed.
> 
> Did you see this issue in your setup?

Yes the mbus driver for the Armada 38x must be updated. As Thomas
worked on it I didn't put it in the series.

I have just create the patch needed you can try it, and I will
add it in the next version of the series.

Thanks,

Gregory


> 
> Best regards,
> Marcin
> 
> 2015-03-30 16:04 GMT+02:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
>> Hi,
>>
>> Until now only one Armada XP based board supported suspend to
>> ram. This suspend to ram mode was unusual because it involved shutting
>> down the SoC and relied on a PIC to wake up the system.
>>
>> However, most of the recent mvebu SoCs can support the standby
>> mode. Unlike for the suspend to ram, nothing special have to be done
>> for these SoCs. In this mode the SoCs go in idle mode (but they remain
>> powered up) and the devices enter in suspend mode. The support itself
>> was added in the patch 2.
>>
>> In order to wake-up the interrupt controller driver have been
>> updated. As in standby mode the interrupt controller is not shutdown,
>> any interrupt can be a wake-up source. So the MPIC (patch 4) and the
>> GIC (patch 3) now used the flags IRQCHIP_SKIP_SET_WAKE and
>> IRQCHIP_MASK_ON_SUSPEND.
>>
>> A wake up source is supposed to work in suspend _and_ in standby mode
>> but for the mvebu SoCs, no interrupt can wake up the system. The last
>> patch warns the user about it.
>>
>> The first patch is a clean-up found while working on this series
>>
>> All the patch are independents either for building or for running.
>>
>> Thanks,
>>
>> Gregory
>>
>>
>> Gregory CLEMENT (5):
>>   ARM: mvebu: Use __init for the PM initialization functions
>>   ARM: mvebu: Add standby support
>>   ARM: mvebu: Allow using the GIC for wakeup in standby mode
>>   irqchip: armada-370-xp: Allow using wakeup source
>>   ARM: mvebu: Warn about the wake-ups sources not taken into account in
>>     suspend
>>
>>  arch/arm/mach-mvebu/board-v7.c      |  7 +++++
>>  arch/arm/mach-mvebu/common.h        |  5 ++--
>>  arch/arm/mach-mvebu/pm-board.c      | 15 ++++++----
>>  arch/arm/mach-mvebu/pm.c            | 57 ++++++++++++++++++++++++++++++++-----
>>  drivers/irqchip/irq-armada-370-xp.c |  1 +
>>  5 files changed, 70 insertions(+), 15 deletions(-)
>>
>> --
>> 2.1.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-mvebu-adjust-mbus-controller-description-on-Arma.patch
Type: text/x-diff
Size: 1205 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/c5ed8db9/attachment.bin>
