From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Apr 2015 12:57:05 -0600
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <87pp6tweql.fsf@eliezer.anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <5539C5A4.5070409@wwwdotorg.org> <87pp6tweql.fsf@eliezer.anholt.net>
Message-ID: <553A9201.3080308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2015 12:41 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 04/21/2015 12:09 PM, Eric Anholt wrote:
>>> This is my first submission of a Raspberry Pi 2 port.  It can be found
>>> at https://github.com/anholt/linux/tree/bcm2836
>>>
>>> I'm using the 2835 interrupt controller support, without adding the
>>> checks for ARM local interrupts first.  That means no support for IPIs
>>> (and thus no SMP), no PMU events, and no local timer (I'm using the
>>> same 2835 peripheral one).
>>>
>>> It supports a similar featureset to Pi 1 at this point.  Serial and SD
>>> cards work.  Just one CPU supported.  USB (ethernet) works if you use
>>> U-Boot, or my mailbox series
>>> (https://github.com/anholt/linux/tree/bcm2836-mbox).
>>
>> I can't quite get this to work. I think what's happening is that U-Boot
>> is over-writing the location of the code/data that the CPU1..3 pin loop
>> uses. Do you know what that address is so I can confirm that?
>>
>> I suspect this because when I load the kernel/DT in U-Boot, or when I
>> jump to the kernel to boot it, I see lots of extra duplicated characters
>> on the UART, like all 4 CPUs are booting Linux. For example:
>
> Oops, I was just extrapolating that U-Boot would work.  I've quit using
> it because of the extra configuration work (particularly the compiled
> text files for the boot scripts).

You don't need any compiled text files if you create an extlinux.conf 
rather than a boot.scr. extlinux.conf is plain text.

To boot without U-Boot: Could you say what's in your config.txt? I 
assume I can just copy the kernel zImage as kernel.img, and the DTB from 
the kernel build tree without renaming it?

> I haven't looked into how SMP works, because I don't have the interrupt
> support necessary yet (bcm2836-irq branch for hacks in that direction).
>
> And in further testing, the USB is actually not working and I'm not sure
> what gave me the idea that it was.

It might be intermittent depending on (GPU) cache content. We need to 
fix the kernel in a similar fashion to the following U-Boot commits:

> http://git.denx.de/?p=u-boot.git;a=commit;h=79340db7f1f676b8eb5911f4993ebedf27009c0b
ARM: bcm2835: implement phys_to_bus/bus_to_phys

> http://git.denx.de/?p=u-boot.git;a=commit;h=5c0beb5c58c86d2a6d12dee6330dc85554de5c60
usb: dwc2: use phys_to_bus/bus_to_phys

> http://git.denx.de/?p=u-boot.git;a=commit;h=122426d46e31391480c4b83b1003e4feca24d491
ARM: bcm2835: use phys_to_bus() for mbox
