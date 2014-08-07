From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 07 Aug 2014 11:30:44 +0200
Subject: CPUIdle Armada 370
In-Reply-To: <1407341774154.51157@vitec.com>
References: <1407333701627.99622@vitec.com>
 <53E24654.6020008@free-electrons.com> <53E249A1.900@free-electrons.com>,
 <53E24D2A.50706@free-electrons.com> <1407340917231.68970@vitec.com>,
 <53E25369.60809@free-electrons.com> <1407341774154.51157@vitec.com>
Message-ID: <53E34744.6080300@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,


On 06/08/2014 18:16, Nicolas Derouineau wrote:
> Here is our dts file.
> 

A few remarks about your dts nothing really important nor relevant for your issue:

compatible = "marvell,a370-vmr1404", "marvell,armada370", "marvell,armada-370-xp";

I think this should be

compatible = "vitec,a370-vmr1404", "marvell,armada370", "marvell,armada-370-xp";

Because if I understood well the board was designed by Vitec not by Marvell.

You can also just remove the phy0 node if you don't use it.

I didn't see anything scary. If you have a reference board such as the Armada 370 RD
or the Armada 370 DB, I can suggest you to test cpuidle on it with exactly the same
kernel( only the dtb will be different).

On my side I used your dtb on the mirabox (of course some devices didn't match) and
then again the cpuidle continued to work.

However I noticed that your base register is 0xf1000000 whereas until now we only
test on platform which have 0xd0000000. Even if the cpu ilde path should not have
any hardcoded value, it could be something to explore.


Gregory


> 
> ________________________________________
> De : Gregory CLEMENT <gregory.clement@free-electrons.com>
> Envoy? : mercredi 6 ao?t 2014 18:10
> ? : Nicolas Derouineau; linux-arm-kernel at lists.infradead.org
> Cc : Thomas Petazzoni; Simon Boulay
> Objet : Re: CPUIdle Armada 370
> 
> On 06/08/2014 18:01, Nicolas Derouineau wrote:
>> Ok,
>> So here is the log of the error(using the previous config file)>
>>
>> NAND read: device 0 offset 0x240000, size 0x600000
>>  6291456 bytes read: OK
>> ## Booting kernel from Legacy Image at 02000000 ...
>>    Image Name:   Linux-3.16.0-next-20140805-dirty
>>    Created:      2014-08-06  15:56:06 UTC
>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>    Data Size:    2939920 Bytes = 2.8 MiB
>>    Load Address: 00080000
>>    Entry Point:  00080000
>>    Verifying Checksum ... OK
>> ## Flattened Device Tree blob at 01000000
>>    Booting using the fdt blob at 0x01000000
>>    Loading Kernel Image ... OK
>> OK
>>    Loading Device Tree to 00ffa000, end 00fff8a6 ... OK
>>
>> Starting kernel ...
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 3.16.0-next-20140805-dirty (nde at nde-OptiPlex-980) (gcc version 4.6.4 (Linaro GCC branch-4.6.4. Marvell GCC release 201308-2123.0cc69bb4 64K MAXPAGESIZE ALIGN) ) #13 Wed Aug 6 14
>> [    0.000000] CPU: ARMv7 Processor [561f5811] revision 1 (ARMv7), cr=10c5387d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
>> [    0.000000] Machine model: Vitec VMR-1404 (Marvell Armada 370 based)
> So this your own board with your own dts I guess. Would it possible to share it to see
> if a mistake could have slip there?
> 
> [...]
> 
>> [    0.073922] mvebu-soc-id: MVEBU SoC ID=0x6707, Rev=0x1
> 
> Interesting you use a different variant the 88F6707 whereas we only test
> this driver on the 88F6710. Maybe there is something there.
> 
> 
> Thanks,
> 
> Gregory
> 
>> ________________________________________
>> De : Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Envoy? : mercredi 6 ao?t 2014 17:43
>> ? : Nicolas Derouineau; linux-arm-kernel at lists.infradead.org
>> Cc : Thomas Petazzoni; Simon Boulay
>> Objet : Re: CPUIdle Armada 370
>>
>> Hi Nicolas,
>>
>> [..]
>>
>>>> On 06/08/2014 16:01, Nicolas Derouineau wrote:
>>>>> Hello,
>>>>> I am currently trying to use the CPUIdle driver provided by linux-next (or by the patch here https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.16/cpuidle-v3).
>>>>
>>>> I have just tested using next-20140806 and mvebu_v7_defconfig.
>>>> And it worked well on a mirabox using the Armada 370 SoC.
>>>>
>>>>>
>>>>> Everything runs fine as long as I don't select the CPU driver for the ARMADA Family. When I do, at boottime, the program is entering the __cpu_suspend save function and then get lost in it and that turns into a kernel panic. I have already made a post about this on the ARM Community Forum (http://community.arm.com/thread/6326).
>>>>>
>>>>> The "faulty" configuration file is attached to this email.
>>>>
>>>> Now I will try with this configuration
>>>
>>> Using your configuration file I didn't reproduce your issue.
>>> And according to the stat given by linux the kernel spent a lot
>>> of time in idle:
>>>
>>> cat /sys/devices/system/cpu/cpu0/cpuidle/state1/time
>>> 338822284
>>>
>>>
>>> Could you try again with next-20140806?
>>
>> Also could you send your full boot log until the crash
>> it may help us.
>>
>> Thanks,
>>
>> Gregory
>>
>> --
>> Gregory Clement, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com
>>
> 
> 
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
