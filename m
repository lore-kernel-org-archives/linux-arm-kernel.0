From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Mon, 23 Nov 2015 15:42:02 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <56530769.4030403@arm.com>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
Message-ID: <5653099A.7020604@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> While running an imx6s boasrd, I got following message in boot log:
>>>>
>>>> [    0.032414] CPU1: failed to boot: -38
>>>>
>>>> This looked strange: imx6s is singe-core and kernel perfectly knows
>>>> that. However, for some reason it tries to initialize CPU 1?
>>>>
>>>> I found this to be caused by
>>>> - CONFIG_SMP_ON_UP successfully detects that system is single core,
>>>> - this causes is_smp() to return false,
>>>> - this causes setup_arch() to skip smp_init_cpus() call,
>>>> - this skips board-specific code that sets cpu_possible mask.
>>>
>>> Right, so you should end up with the possible and present masks
>>> containing just one CPU, which should prevent the kernel trying to
>>> bring any secondary CPUs online.
>>
>> Kernel that is running here still tries to init CPU 1 for some reason.
> 
> I *guess* cpus node [1] in your dts has more than one cpu entry, could
> you check please?

Indeed looks so:

# ls /proc/device-tree/cpus
#address-cells  #size-cells  cpu at 0  cpu at 1  name

But my custom device tree just includes imx6dl.dtsi

So it is imx6dl.dtsi in linux-imx tree broken?..


Still, if I apply change from the patch, issue diappears, since in this
case imx_smp_init_cpus() gets called and initializes possible_cpu mask
properly.
