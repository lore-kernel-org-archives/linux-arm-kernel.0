From: b32955@freescale.com (Huang Shijie)
Date: Tue, 2 Aug 2011 18:37:41 +0800
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <CAHMSPgOBhZVgjXZTWWPtwBxrF4g1tFa2E5N+Yjs+ku-0BwKPVA@mail.gmail.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>	<20018.43621.688990.319528@ipc1.ka-ro>	<CAHMSPgPXnDVO630P9fnogQ0XvPSrwz0MYzXfXZLJoJNRf1gifA@mail.gmail.com>	<201107311551.48223.marek.vasut@gmail.com>	<CAHMSPgMK_zM17NXgsbrzs8Zw0VXtDoP12_1V7oeROSF=aBDuYg@mail.gmail.com>	<4E379B28.7090902@freescale.com>	<CAHMSPgM4K5o_aGK31yyFcGK-hH4WBeqVkA5dZU=FvAiKGmHA9A@mail.gmail.com>	<4E37BA02.5030400@freescale.com>
	<CAHMSPgOBhZVgjXZTWWPtwBxrF4g1tFa2E5N+Yjs+ku-0BwKPVA@mail.gmail.com>
Message-ID: <4E37D375.7000400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi:
>
>> The following is my test environment:
>> [0] Hardware:
>>        MX23EVK PCB REV C
> I have the same hardware. But also on our own hardware (mx23, but
> different dram and different nand) it's failing with the same output
> as on the evk (see log file in previous mail).
I will check the schematic of mx23 tomorrow, and find what will cause 
conflict with GPMI.
>> [1] SW:
>>     kernel:git://git.linaro.org/people/shawnguo/linux-2.6.git mxs-gpmi
>>     .config: my_config , you can find it in my previous email.
>>     cmdline: console=ttyAMA0,115200 root=/dev/mmcblk0p1 rw rootwait
>> gpmi_debug_init mtdparts=gpmi-nand:20m(boot),-(user)
> I use that git and your config file. Only thing i have changed to the
> config is to integrate the initramfs rootfs.
> Would it be possible for you to test using rootfs in initramfs? Now
could you tell me how can i test the rootfs in initramfs?
I have no idea about how to test it.


> you are using the mmc card as rootfs which is on the dma engine and
> bus.
>
>
>> [2] test shell script:
>> ================================
>>
>> echo 0x20>  /sys/module/gpmi_nand/parameters/gpmi_debug
> As said, don't have that gpmi_debug sysfs entry. Sure you don't have
> any other modification done which are not in that git branch?
The sysfs entry does exit.
Please check carefully.
The code in gpmi-nand.c defines it.


>> flash_eraseall /dev/mtd1
>> ubiformat /dev/mtd1
>> flash_eraseall /dev/mtd1
>> ubiattach /dev/ubi_ctrl -m 1
>> ubimkvol /dev/ubi0 -N test -m
>> mount -t ubifs ubi0:test tmp
>> bonnie++ -d tmp -u 0 -s 2 -r 1
>> bonnie++ -d tmp -u 0 -s 2 -r 1
>> bonnie++ -d tmp -u 0 -s 2 -r 1
>> umount tmp
>> ubidetach /dev/ubi_ctrl -m 1
>>
>> ================================
>>
>> [3] conclusion
>>    It runs well in my mx23 board, and no DMA-TIMEOUT occur.
>> I think there is some conflict in your board.
> Don't know what conflict I would have with my board. I just use the
> board without anything (mmc, lcd, ...) attached to it.
>
>> BTW:
>>    I split the MTD to 20M and (the rest size).
> So do I.
>
>> The flash_eraseall works well.
>> If i do not split the MTD, the flash_eraseall will not work.
> That's strange because I use flash_eraseall on my mtd1 which is 108 MB.
> I don't know how you boot but my uboot is in mtd0, so don't use that
I boot the kernel by the USB with sb_loader.

Best Regards
Huang Shijie
