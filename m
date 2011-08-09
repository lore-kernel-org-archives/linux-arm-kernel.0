From: b32955@freescale.com (Huang Shijie)
Date: Tue, 9 Aug 2011 13:11:39 +0800
Subject: GPMI-NAND Status?
In-Reply-To: <CAHMSPgMYP+5Hpa5sC-yt=1H-S=tEER8uNzj6uMSK403_DGYJ9Q@mail.gmail.com>
References: <20110805135133.GA26981@pengutronix.de>	<4E3F8087.6070206@freescale.com>
	<CAHMSPgMYP+5Hpa5sC-yt=1H-S=tEER8uNzj6uMSK403_DGYJ9Q@mail.gmail.com>
Message-ID: <4E40C18B.7040609@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Koen:
> Hi Wolfram,
>
> Thanks for taking the initiative to summarize the current status.
> Also thanks to Huang Shijie for all the work done so far.
>
>
> On Mon, Aug 8, 2011 at 8:21 AM, Huang Shijie<b32955@freescale.com>  wrote:
>> Hi Wolfram:
>>> Hi,
>>>
>>> I am a bit uncertain how the state of the GPMI-NAND driver currently is,
>>> so
>>> I'll try to sum it up here. There is without doubt interest in getting the
>>> driver into mainline from at least Huang, Shawn, Lothar, Koen and me, so I
>>> wonder if we can join forces more effectively. First of all, I want to
>>> thank
>>> Huang Shijie for all his work so far which was already quite some effort;
>>> this
>>> sum-up is by no means meant as bashing, just trying to understand the
>>> status
>>> quo (Sidenote: I am more or less on holiday until Monday, so no time for
>>> real
>>> debugging myself. I write this mail so we hopefully gain a common
>>> understanding. When I am back to full strength, I can then start working
>>> on
>>> what seems apropriate)
>>>
>>> Issues with the current driver I am aware of:
>>>
>>> DMA timeouts [1]
>>> ================
>>>
>>> [    2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout, last DMA
>>> :1
>>> [    3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!
>>>
>>> Always reproducible by me when trying to format mtd0. Sometimes(always?)
>>> seen
>>> by Koen during boot (on read?). Never seen by Huang? It is currently
>>> unclear if
>> After I used a different .config, it never appears in my side.
> flash_eraseall of mtd1 works for me.
> ubi_format of mtd1 always gives the dma timeout
> reading/writing of mtd0/1 always gives the dma timeout
> I have seen dma timeout during boot if i try to enable ubi rootfs (so
> that's the same issue as dma time during read/write).
>
> I don't use mtd0 for testing as this contains my uboot.
>
> I tested using Huang's .config and the Linaro git but still see
> exactly the same issue.
>
>>> the bug is in the GPMI driver, or in the MXS-DMA driver. Still, I'd say
>>> the
>>> issue is a show-stopper. We can't put a driver into mainline which leads
>>> to the
>>> above failure. The fact that there is _some_ configuration which works for
>>> someone does not help, it doesn't work for Koen and me at least. We need
> On my target, the mxs-dma is working for sdio until the gpmi-nand
> gives a timeout. After that the dma for sdio is *not fully* working
> anymore.
>
>> Hi Koen, do you test my uImage?
>> Does the timeout occur?
> I was not able to test you uImage. It ended with a "Kernel panic - not
> syncing: read error". See (off list) mail from last week.
>
>
>>> reliable drivers in mainline, so the issue needs to be resolved,
>>> regardless
>>> where the bug resides.
>> ok. I will debug it too.
>>
>>
>> Please test the driver again when you back to office.
>> Pay attention to your version of /arch/arm/configs/mxs_defconfig.
>> Your mxs_defconfig may miss Shawn Guo's patches.
>>
>> thanks.
>>
>>
>>> problem overwriting all-0xff data in NAND [2]
>>> =============================================
>>>
>>> Although it occured only when writing JFFS2 images so far, this is a
>>> generic
>>> issue and needs to be fixed, right?
>>>
>> Artem said it should not change the driver, but the upper layer(jffs2).
>>
>> So I think i do not need to change the driver.
>>> ecclayout needs to be used to show that OOB is fully in use [1]
>>> ===============================================================
>>>
>>> Needed to make it work for JFFS2 and to pass the mtd-testsuite. A driver
>>> only
>>> working with UBIFS is surely not ready for mainline.
>>>
>> I programmed for mx6q in the recent days. I have no time to fix it. The mx6q
>> can runs well now.
>>
>> So I will fix the issue in the following days.
>>
>>> Pecularities
>>> ============
>>>
>>> There are a few issues which are odd. I don't know if some are mainly
>>> intended
>>> for debugging, yet they shouldn't be in a mainline driver. At least:
>>>
>>> * custom sysfs-entries
>> My sysfs-entries is in the GPMI-NAND directory.
>> Does be a mainline driver means I should not have any sysfs-entries?
>> If it does, i can remove it.
>>
>>> * custom kernel command line parameters
>> The kernel command line 'gpmi_nand' is to avoid the conflict with other
>> modules such as
>> SD.
>>
>> If it's be removed, I have to use different config to resolve the issue
>> which is not better either. :(
>>
>>> * namespacing (some functions have no prefix, some have "mil_", some have
>>> mx23)
>>>    (I think 'mil' means 'mtd interface layer', but why is that needed?)
>> The mil is used to make the gpmi_nand_data{} simple.
>> Without it, the gpmi_nand_data{} will very big.
>>
>> The functions which have mx23 prefix are only used in mx23.
>> The functions which have no prefix can used in both mx28 and mx23.
>>
>>> Complexity
>>> ==========
>>>
>>> The driver is not easy to review. I wonder if it makes sense to use
>>> incremental
>>> patches for it? maybe making it a staging driver could be a solution for
>>> that?
>> Frankly speaking, the current driver is maybe the smallest version now.
>>
>> I even do not add the on-chip BBT feature now.
>>> Huang, are you interested in accepting patches or do you prefer we just
>>> point
>>> at certain code and you then fix it? Starting with a simpler driver and
>>> then
>> Feel free to mail me the patch. it's welcome.
>>
>>
>>> adding stuff might be another option if we can't chase all the bugs in the
>>> current driver.
>>>
>>> That being said, I'd think fixing the DMA issue has prio #1 and maybe we
>>> can
>>> meet in IRC or something to work that out? Is there interest in that?
>> What about gtalk?
> Anything is good for me.
> Could also be useful to make sure we test on the same HW as much as
> possible and are using the same source tree.
> HW I have:
> - mx23evk rev C1
> - mx23evk rev B2
> - own target hw using mx23 lqfp-128 chip and different type of ddr and nand.
>
My test mx23 board is 169BGA package which is different from yours.

Could you get the 169BGA package board?

I think the DMA timeout is caused by the different package type.

Best Regards
Huang Shijie
