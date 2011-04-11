From: b32955@freescale.com (Huang Shijie)
Date: Mon, 11 Apr 2011 11:08:41 +0800
Subject: [PATCH V4 0/4] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <19870.59289.913018.127715@ipc1.ka-ro>
References: <19869.40520.368078.270732@ipc1.ka-ro>	<4D9E75FF.6090603@freescale.com>
	<19870.59289.913018.127715@ipc1.ka-ro>
Message-ID: <4DA270B9.6030700@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar:

> Hi,
>
> Huang Shijie writes:
>> Hi Lothar:
>>> Hi,
>>>
>>> Huang Shijie writes:
>>>> Does some one have any comments about this driver?
>>>>
>>> I'm still not happy with the rom-helper code that IMO does not belong
>>> in this driver.
>> Could you tell me which part of the rom-helper code is not belong the
>> driver?
>>
> All of it. I don't see a point in having it, when all that it does can
> be achieved with standard functions already.
>
I am afraid most of the rom-help code can not be removed, the  reasons are:
[1] imx23 does not need the swap-block-mark feature. The swap-block-mark 
feature is used
    by the BCH hardware ecc-correction module. But the imx28 does need 
the swap-block-mark feature.
    Why? the firmwares in both chips are a little different. The 
rom-help code is used to distinguish
    this, and _DO_ some necessary initializations. After the 
initialization, the NAND_SCAN will works.

[2] In the NAND boot mode, we also need to check the swap-block-mark to 
do the right ECC read pages.



BUT the default partition layout code really can be removed. It somehow 
can be regards as not belonged to
the driver.

thanks.
>>> Also, I would integrate the code from the hal-*.c files into the main
>>> file and remove all the function hooks, since the functions are the
>> thanks for your advice.
>>
>> This driver will serve for many platforms, not only the imx23 and imx28.
>> I am merging the imx508 code to the driver.
>> I feel lucky that i did not merge all the code into the main file, which
>> will
>> make the code mess.
>>
> You would probably end up with some more functions that are
> implemented for the different variants. They could be prefixed with
> the SoC name and selected in the probe() function depending on the
> platform id. I don't see why this should get messy.
>
I really do not like to package all the code into one file which makes 
the file bigger and bigger.
Frankly speaking, I regard it as a bad idea. I think it's messy.

imx508 will support DDR mode for ONFI NAND and TOGGLE nand which need to 
do lot of TIMING initialization for both mode.
It is a long initialization code. Keep the code in separate file is to 
make the code tidy. Do you think it's a
grace method to keep it in one file? I do not think so. :)

yes, I can use the PREFIXED name for different variants. But I think 
that will create more code.
The current *hal.c only contains the different implementation for variants.


> If the imx508 driver is so much different from the other variants,
> that merging it gets too messy, it's probably better to not merge it
> with the other variants anyway.
>
It just needs a separate hal-508.c file.
> Lothar Wa?mann

Thanks a lot.

Best Regards
Huang Shijie
