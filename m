From: koen.beel.barco@gmail.com (Koen Beel)
Date: Tue, 2 Aug 2011 09:33:49 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4E379B28.7090902@freescale.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20018.43621.688990.319528@ipc1.ka-ro>
	<CAHMSPgPXnDVO630P9fnogQ0XvPSrwz0MYzXfXZLJoJNRf1gifA@mail.gmail.com>
	<201107311551.48223.marek.vasut@gmail.com>
	<CAHMSPgMK_zM17NXgsbrzs8Zw0VXtDoP12_1V7oeROSF=aBDuYg@mail.gmail.com>
	<4E379B28.7090902@freescale.com>
Message-ID: <CAHMSPgM4K5o_aGK31yyFcGK-hH4WBeqVkA5dZU=FvAiKGmHA9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 2, 2011 at 8:37 AM, Huang Shijie <b32955@freescale.com> wrote:
> Hi,
>>
>> Hi,
>>
>> Don't think it's a hardware issue. After all it is working on the
>> mx23evk using the Freescale BSP based on 2.6.35.3.
>
> I doubt the Freescale BSP has fix the conflict, while the community kernel
> does not
> fix it.
> Anyway, I will do more test on the mx23 board myself.

Strange indeed. I suspect that the BSP used another way to mark bad blocks.

>
>
>
>> Now I tested using this kernel command line:
>> mtdparts=gpmi-nand:20m(boot),-(user) gpmi_debug_init
>> (So I removed the ubi rootfs stuff, see previous mails).
>>
>> Its booting fine now without complaining about dma timeouts.
>
> ok.

That's mainly because the ubi stuff is not done at startup.

>>
>> Have tried flash_eraseall /dev/mtd1. Now it's complaining and thinking
>> all blocks are bad. So a "flash_erase: Skipping bad block at 1db00000"
>> message for every erase block.
>> Writing 1 to /sys/devices/platform/imx23-gpmi-nand/ignorebad, makes to
>
> This is a very dangerous interface.

I know but it solved an issue here. Now flash_eraseall seems to be
working again without that ignorebad turned on (only finds one bad
erase blcok).
Again: I suspect that the BSP used another way to mark bad blocks.

>
>> go a little further giving 'only one' error but I doubt it's working
>> at all. See attached log file.
>>
>> When the trying ubiformat /dev/mtd1 its stopping with a dma timeout.
>
> echo 0x20 > /sys/devices/platform/imx23-gpmi-nand/gpmi_debug
>
> to show the GPMI register when the DMA timeout occurs.

Don't have this sysfs interface here. I also don't see where it is
registered in the driver code.
Anyway I have hardcoded GPMI_DEBUG_CRAZY in gpmi_debug_setup.

log file attached.

Regards,
Koen

>
>
> Best Regards
> Huang Shijie
>>
>> Every subsequent action (e.g. using ubiformat or flash_eraseall) using
>> that dma channel is failing.
>> I have put a printk in mxs-dma.c around line 387:
>>
>> ? ? if (mxs_chan->status == DMA_IN_PROGRESS&& ?!append)
>> ? ? {
>> ? ? ? ? pr_err("dma already in progess!\n");
>> ? ? ? ? return NULL;
>> ? ? }
>>
>> I see that printk also in the log file in attach. Seems like the
>> mxs-dma is failing at some point and for the rest of the time always
>> keeps it's status at DMA_IN_PROGRESS
>>
>> Any input or feedback is welcome.
>>
>> Regards,
>> Koen
>>
>>
>> On Sun, Jul 31, 2011 at 3:51 PM, Marek Vasut<marek.vasut@gmail.com>
>> ?wrote:
>>>
>>> On Friday, July 29, 2011 05:00:48 PM Koen Beel wrote:
>>>>
>>>> On Fri, Jul 29, 2011 at 2:41 PM, Lothar Wa?mann<LW@karo-electronics.de>
>>>
>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Koen Beel writes:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Jul 29, 2011 at 9:20 AM, Lothar
>>>>>> Wa?mann<LW@karo-electronics.de>
>>>
>>> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Koen Beel writes:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I have test on mx23evk board. Still see the same issues.
>>>>>>>>
>>>>>>>> On Wed, Jul 27, 2011 at 3:53 AM, Huang Shijie<b32955@freescale.com>
>>>
>>> wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Thanks for your test.
>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> It's not really working for me.
>>>>>>>>>> I've applied all gpmi-nand driver patches and the dma driver
>>>>>>>>>> patches.
>>>>>>>>>>
>>>>>>>>>> I have added following kernel parameters:
>>>>>>>>>> mtdparts=gpmi-nand:20m(boot),-(user) ubi.mtd=1 root=ubi0:rootfs0
>>>>>>>>>> rootfstype=ubifs gpmi_debug_init
>>>>>>>>>>
>>>>>>>>>> During boot I get already get DMA timeout:
>>>>>>>>>> [ ? ?2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout,
>>>>>>>>>> last DMA
>>>>>>>>>>
>>>>>>>>>> :1
>>>>>>>>>>
>>>>>>>>>> [ ? ?3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!
>>>>>>>>>> ...
>>>>>>>>>> (see log file in attach line 89)
>>>>>>>>
>>>>>>>> I still see this DMA timeout when booting.
>>>>>>>> What kernel parameters do you use? I still use same as above.
>>>>>>>
>>>>>>> Do you have an SD card in the system? I'm getting the same error when
>>>>>>> accessing an SD card. Without SD card I can use the flash without any
>>>>>>> errors.
>>>>>>
>>>>>> No SD card in the system. At least not on my mx23evk board.
>>>>>> My real target hardware has a SDIO wifi chip.
>>>>>>
>>>>>> Are you also testing on the mx23evk board? Really strange it is not
>>>>>> reproducible here then.
>>>>>> Anyone using mx23evk please give:
>>>>>> - revision number of board (I have tested on rev C1)
>>>>>> - kernel parameter used (see previous mail for mine)
>>>>>
>>>>> It's getting ever more strange. I only have problems with concurrent
>>>>> access to the flash and SD-card when I do file system based accessed
>>>>> to the SD card.
>>>>> A 'dd if=/dev/mmcblk0 of=/dev/null' while excessively using the flash
>>>>> works well, while mounting the SD card and doing an 'ls' produces
>>>>> immediate BCH DMA timeouts.
>>>>>
>>>>> Perhaps someone can make anything out of that.
>>>>
>>>> I have checked and the function dma_irq_callback is never called
>>>> during my tests. This means the DMA transfer does not even works once.
>>>>
>>>> Also no clue here ...
>>>
>>> Aren't you getting some undervolt on the powerrail for example ? btw the
>>> driver
>>> looks a bit crappy to me, but let's believe it works ;-)
>>>
>>>>> Lothar Wa?mann
>>>>> --
>>>>> ___________________________________________________________
>>>>>
>>>>> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
>>>>> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
>>>>> Gesch?ftsf?hrer: Matthias Kaussen
>>>>> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>>>>>
>>>>> www.karo-electronics.de | info at karo-electronics.de
>>>>> ___________________________________________________________
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: log2
Type: application/octet-stream
Size: 2896 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110802/c00871d9/attachment.obj>
