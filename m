From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 25 Jan 2017 15:33:16 +0100
Subject: [RFC PATCH v1] ARM: Import tango4_defconfig
In-Reply-To: <4729631.76bAWajetU@wuerfel>
References: <5c615aa5-678e-63b8-ecae-f5f0bd8a6f2c@sigmadesigns.com>
 <4729631.76bAWajetU@wuerfel>
Message-ID: <9bbc2fa7-fce4-73c2-898e-a2f780e55d1f@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Thanks for taking a look.

On 25/01/2017 14:35, Arnd Bergmann wrote:

> On Tuesday, January 24, 2017 4:11:31 PM CET Marc Gonzalez wrote:
>
>> Import minimal defconfig for tango4 boards.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>>  arch/arm/configs/tango4_defconfig | 96 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>  create mode 100644 arch/arm/configs/tango4_defconfig
>>
>> diff --git a/arch/arm/configs/tango4_defconfig b/arch/arm/configs/tango4_defconfig
>> new file mode 100644
>> index 000000000000..aab931fc0e03
>> --- /dev/null
>> +++ b/arch/arm/configs/tango4_defconfig
>> @@ -0,0 +1,96 @@
>> +CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"
> 
> This may cause problems with build bots, please remove that line

Am I supposed to always export CONFIG_CROSS_COMPILE in my environment?


>> +# CONFIG_SWAP is not set
>> +CONFIG_SYSVIPC=y
>> +CONFIG_NO_HZ_IDLE=y
>> +CONFIG_HIGH_RES_TIMERS=y
>> +# CONFIG_COMPAT_BRK is not set
>> +CONFIG_SLAB=y
>> +CONFIG_MODULES=y
>> +CONFIG_MODULE_UNLOAD=y
>> +CONFIG_MODVERSIONS=y
>> +CONFIG_ARCH_TANGO=y
>> +# CONFIG_ARM_ERRATA_643719 is not set
>> +CONFIG_SMP=y
>> +CONFIG_PREEMPT=y
>> +CONFIG_HZ_300=y
> 
> Any specific reason for HZ=300?

Are you concerned that this particular HZ setting gets too little testing?

I was convinced by the Kconfig help blurb.

	300 Hz is a good compromise choice allowing server performance
	while also showing good interactive responsiveness even
	on SMP and NUMA systems and exactly dividing by both PAL and
	NTSC frame rates for video and multimedia work.

Since the SoC is mostly used for television, I thought the "video and
multimedia" argument made sense.

Also, one dev complained that the previous kernel had "bad latency
when we sleep in user-space, therefore we must instead busy loop".
I told him about HIGH_RES_TIMERS, but IIUC some user-space sleep
functions don't go through the hrt-enabled syscalls.

So a 3 ms error seemed like an improvement over a 10 ms error.


>> +CONFIG_AEABI=y
>> +CONFIG_HIGHMEM=y
>> +# CONFIG_ATAGS is not set
>> +CONFIG_ARM_APPENDED_DTB=y
>> +CONFIG_ARM_ATAG_DTB_COMPAT=y
>> +CONFIG_CMDLINE="console=ttyS0,115200 mem=256M"
> 
> You shouldn't need the command line override, as both the console port
> and the memory size can reliably be found in the DTB

I actually override that parameter in Uboot, but I didn't consider
what happens when we don't have Uboot, or leave the parameter intact.

The DT says:

	memory at 80000000 {
		device_type = "memory";
		reg = <0x80000000 0x80000000>; /* 2 GB */
	};

2 GB is the actual memory on the board, but Linux is only allowed
to manage a fraction of this. I've been told that the exact amount
may even be a run-time value on some customer setups.

Is the boot-loader supposed to set the correct mem parameter?


	chosen {
		stdout-path = "serial:115200n8";
	};

Is this supposed to be equivalent to console=ttyS0,115200 ?


> Please also make sure that any hardware specific drivers are enabled in
> multi_v7_defconfig along with your platform specific one, and check
> that multi_v7_defconfig works as well as your own config.

Isn't CONFIG_ARM_APPENDED_DTB=y incompatible with multi_v7_defconfig ?

Regards.
