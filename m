From: koen.beel.barco@gmail.com (Koen Beel)
Date: Tue, 26 Jul 2011 16:29:25 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4E292FCF.6010608@freescale.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20110721215020.GA25344@pengutronix.de>
	<4E28EEE1.2050008@freescale.com>
	<20110722055731.GI26837@S2100-06.ap.freescale.net>
	<4E292FCF.6010608@freescale.com>
Message-ID: <CAHMSPgMHrqWcJ=BThDLgQ=XyTBDCMvNS4SVjQWfk=Jf682TEig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It's not really working for me.
I've applied all gpmi-nand driver patches and the dma driver patches.

I have added following kernel parameters:
mtdparts=gpmi-nand:20m(boot),-(user) ubi.mtd=1 root=ubi0:rootfs0
rootfstype=ubifs gpmi_debug_init

During boot I get already get DMA timeout:
[    2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout, last DMA :1
[    3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!
...
(see log file in attach line 89)

When trying flash_erraseall /dev/mtd1 I get:
Erasing 128 Kibyte @ 20000 --  0 % complete [   16.700000] [
gpmi_read_data : 832 ] step 1 error
[   16.700000] [ gpmi_send_command : 749 ] step 1 error
[   16.700000] [ mil_cmd_ctrl : 894 ] Chip: 0, Error -1
[   16.700000] [ gpmi_send_command : 749 ] step 1 error
[   16.700000] [ mil_cmd_ctrl : 894 ] Chip: 0, Error -1
[   16.700000] [ gpmi_send_command : 749 ] step 1 error
[   16.700000] [ mil_cmd_ctrl : 894 ] Chip: 0, Error -1
[   16.700000] [ gpmi_read_data : 832 ] step 1 error
libmtd: error!: MEMERA[   16.740000] [ gpmi_send_command : 749 ] step 1 error
SE64 ioctl failed for eraseblock[   16.750000] [ mil_cmd_ctrl : 894 ]
Chip: 0, Error -1
 1 (mtd1)
        error 5 (Input/output error)
flash_erase: error!: /dev/mtd1: MTD Erase failure
             error 5 (Input/output error)
...
(see log file in attach line 128 and further)

Environment:
- patches on a 2.6.39.1 kernel (needed to modify the patch a little
for changed mtd add/del interface).
- using this on our own mx23 based board, so also added some board
init code for that.


On Fri, Jul 22, 2011 at 10:07 AM, Huang Shijie <b32955@freescale.com> wrote:
> Hi Wolfram:
>>
>> On Fri, Jul 22, 2011 at 11:30:41AM +0800, Huang Shijie wrote:
>>>
>>> Hi,
>>>>>
>>>>> The general-purpose media interface(GPMI) controller is a flexible
>>>>> interface
>>>>> to up to several NAND flashs.
>>>>
>>>> ...
>>>>>
>>>>> To Walfram& ?Artem:
>>>>> ? ? About how to disable the JFFS2 to use the OOB:
>>>>> ? ? I read the code, and I still have no idea about how to use the
>>>>> ecclayout
>>>>> ? ? to do the job. Could you give me some hint? thanks.
>>>>
>>>> Have you checked mxc_nand.c for example? There is
>>>>
>>>> static struct nand_ecclayout nandv1_hw_eccoob_smallpage = {
>>>> ? ? ? ? .eccbytes = 5,
>>>> ? ? ? ? .eccpos = {6, 7, 8, 9, 10},
>>>> ? ? ? ? .oobfree = {{0, 5}, {12, 4}, }
>>>> }
>>>>
>>>> defined as one layout. Now, you could define one where oobfree is empty
>>>> and
>>>> eccbytes as big as the oob-area.
>>>>
>>> thanks. I will check the code.
>>>>>
>>>>> The driver depends on another GPMI-NAND device patch set, you can find
>>>>> them at :
>>>>> ? ? ? ?[1]
>>>>> http://lists.infradead.org/pipermail/linux-mtd/2011-July/037033.html
>>>>> ? ? ? ?[2]
>>>>> http://lists.infradead.org/pipermail/linux-mtd/2011-July/037031.html
>>>>> ? ? ? ?[3]
>>>>> http://lists.infradead.org/pipermail/linux-mtd/2011-July/037032.html
>>>>> ? ? ? ?[4]
>>>>> http://lists.infradead.org/pipermail/linux-mtd/2011-July/037034.html
>>>>>
>>>>> The driver also depends on another DMA patch by Shawn:
>>>>> ? ? ? ?[0]
>>>>> http://lists.infradead.org/pipermail/linux-mtd/2011-June/036820.html
>>>>
>>>> This makes it difficult for testers/reviewers. Please try to get a
>>>> git-branch
>>>> from Freescale or Linaro.
>>>>
>>> Shawn will merge my patches to his Linaro branch.

I don't see the DMA patch in the git?

>>>
>> git://git.linaro.org/people/shawnguo/linux-2.6.git mxs-gpmi
>
> Please test the GPMI driver based this git tree.

I will try that on an mx23evk board.

>
> I tested, and the DMA-timeout does not occur any more.
>
> I notice that Shawn added two more patched to
> /arch/arm/config/mxs_defconfig:
> [1] ARM: mxs_defconfig: Add mx23evk and mx28evk build
> [2] ARM: mxs_defconfig: Change CONFIG_RTC_CLASS 'm' to 'y'
>
> Please check it. Maybe your kernel code misses them.

I don't see any of this in the git?

>
> Of course, you can use the my_config (i sent you last mail) for .config.
>
> Best Regards
> Huang Shijie
>
>
>> Shijie, please check and test it. ?I only did a build test.
>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
