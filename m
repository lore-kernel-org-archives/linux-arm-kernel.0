From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 15:54:49 +0100
Subject: [RFC PATCH v1] ARM: Import tango4_defconfig
In-Reply-To: <9bbc2fa7-fce4-73c2-898e-a2f780e55d1f@sigmadesigns.com>
References: <5c615aa5-678e-63b8-ecae-f5f0bd8a6f2c@sigmadesigns.com>
 <4729631.76bAWajetU@wuerfel>
 <9bbc2fa7-fce4-73c2-898e-a2f780e55d1f@sigmadesigns.com>
Message-ID: <CAK8P3a2ySbZRt5R3VBG=B-aAYM5XzxVSEBn=jHU2__nW=-or9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 3:33 PM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> On 25/01/2017 14:35, Arnd Bergmann wrote:
>
>> On Tuesday, January 24, 2017 4:11:31 PM CET Marc Gonzalez wrote:
>>
>>> Import minimal defconfig for tango4 boards.
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>>  arch/arm/configs/tango4_defconfig | 96 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 96 insertions(+)
>>>  create mode 100644 arch/arm/configs/tango4_defconfig
>>>
>>> diff --git a/arch/arm/configs/tango4_defconfig b/arch/arm/configs/tango4_defconfig
>>> new file mode 100644
>>> index 000000000000..aab931fc0e03
>>> --- /dev/null
>>> +++ b/arch/arm/configs/tango4_defconfig
>>> @@ -0,0 +1,96 @@
>>> +CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"
>>
>> This may cause problems with build bots, please remove that line
>
> Am I supposed to always export CONFIG_CROSS_COMPILE in my environment?

I think what most people do is to have a way to call "make" with
CROSS_COMPILE=...
and O=... set as arguments to 'make'.

>>> +CONFIG_HZ_300=y
>>
>> Any specific reason for HZ=300?
>
> Are you concerned that this particular HZ setting gets too little testing?
>
> I was convinced by the Kconfig help blurb.
>
>         300 Hz is a good compromise choice allowing server performance
>         while also showing good interactive responsiveness even
>         on SMP and NUMA systems and exactly dividing by both PAL and
>         NTSC frame rates for video and multimedia work.
>
> Since the SoC is mostly used for television, I thought the "video and
> multimedia" argument made sense.

makes sense.

> Also, one dev complained that the previous kernel had "bad latency
> when we sleep in user-space, therefore we must instead busy loop".
> I told him about HIGH_RES_TIMERS, but IIUC some user-space sleep
> functions don't go through the hrt-enabled syscalls.
>
> So a 3 ms error seemed like an improvement over a 10 ms error.

This may have changed recently, I don't remember the details but
I think nanosleep() uses highres timers these days unlike on older
kernels.

>>> +CONFIG_AEABI=y
>>> +CONFIG_HIGHMEM=y
>>> +# CONFIG_ATAGS is not set
>>> +CONFIG_ARM_APPENDED_DTB=y
>>> +CONFIG_ARM_ATAG_DTB_COMPAT=y
>>> +CONFIG_CMDLINE="console=ttyS0,115200 mem=256M"
>>
>> You shouldn't need the command line override, as both the console port
>> and the memory size can reliably be found in the DTB
>
> I actually override that parameter in Uboot, but I didn't consider
> what happens when we don't have Uboot, or leave the parameter intact.
>
> The DT says:
>
>         memory at 80000000 {
>                 device_type = "memory";
>                 reg = <0x80000000 0x80000000>; /* 2 GB */
>         };
>
> 2 GB is the actual memory on the board, but Linux is only allowed
> to manage a fraction of this. I've been told that the exact amount
> may even be a run-time value on some customer setups.
>
> Is the boot-loader supposed to set the correct mem parameter?

Yes, whatever gets passed to the kernel should be correct, either
by having the right board specific value in the dtb to start with,
by having the bootloader detect the memory and override the dtb,
or by the atags compat code taking the amount of memory from
the atags.

>
>         chosen {
>                 stdout-path = "serial:115200n8";
>         };
>
> Is this supposed to be equivalent to console=ttyS0,115200 ?
>

Yes, but you may need to specify "earlycon" (don't remember where
we are on that front these days).

>> Please also make sure that any hardware specific drivers are enabled in
>> multi_v7_defconfig along with your platform specific one, and check
>> that multi_v7_defconfig works as well as your own config.
>
> Isn't CONFIG_ARM_APPENDED_DTB=y incompatible with multi_v7_defconfig ?

No:
arch/arm/configs/multi_v7_defconfig:CONFIG_ARM_APPENDED_DTB=y

    Arnd
