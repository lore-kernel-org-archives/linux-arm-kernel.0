From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 13 Dec 2012 18:55:47 +0100
Subject: ARM realview breakages w/ 3.7 under qemu
In-Reply-To: <20121213174817.GB12946@mudshark.cambridge.arm.com>
References: <50CA0FC1.5090009@openwrt.org>
 <20121213174817.GB12946@mudshark.cambridge.arm.com>
Message-ID: <50CA16A3.4020108@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/13/12 18:48, Will Deacon a ?crit :
> On Thu, Dec 13, 2012 at 05:26:25PM +0000, Florian Fainelli wrote:
>> Hi,
> Hi Florian,
>
>> I am experiencing several issues with the ARM RealView platform under qemu:
>>
>> 1) The RealView EB MP-Core is stuck in the timer calibration, this
>> isssue was already present in all 3.6 kernels, and I have not yet been
>> able to find the root cause of this. PBX A9 with the same kernel binary
>> works flawlessly.
> Can you try picking 810883f05982 ("ARM: 7594/1: Add .smp entry for
> REALVIEW_EB") please?

I picked that up and it did not make any difference we are still stuck 
calibrating the timer.

>
>> 2) There are some strange things happening with the RAM on these
>> platforms too, for instance:
>>
>> - EB MP-Core: booting with 128MBytes of RAM does not work, booting with
>> more than 256Mbytes results in the amount of RAM seen by the kernel
>> truncated to 256Mbytes
>>
>> - PBX A9: booting with less than 1024MBytes of RAM causes this:
>> [    0.000000] Truncating RAM at 20000000-3fffffff to -3f7fffff (vmalloc
>> region overlap).
>> [    0.000000] Ignoring RAM at 80000000-8fffffff (vmalloc region overlap).
>>
>> Do these issues sounds familiar to any of you? The kernel config is
>> attached in case that helps.
> I'm afraid these memory issues don't ring any bells with me, but I do
> actually have hardware for EB MP and PBX so I can see if that works with
> your .config (although you may have to wait until next week).
>
> Can you provide your command lines please? I'm also assuming you're using
> 3.7?

The qemu command-line is the following:
qemu-system-arm -M realview-eb-mpcore -kernel 
bin/realview/openwrt-realview-vmlinux.elf -nographic -m 768 -append 
"earlyprintk console=ttyAMA0"

And the kernel command-line is:
console=ttyAMA0 mem=128M
CMDLINE_FROM_BOOTLOADER is set, so only the command-line from qemu 
actually matters.

Thanks!
--
Florian
