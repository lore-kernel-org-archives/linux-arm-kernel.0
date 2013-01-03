From: hs@denx.de (Heiko Schocher)
Date: Thu, 03 Jan 2013 08:03:02 +0100
Subject: [PATCH v6] ARM: mtd: nand: davinci: add OF support for davinci
 nand controller
In-Reply-To: <50E48DFD.2030908@mvista.com>
References: <1343632944-25971-1-git-send-email-hs@denx.de>
 <50E48DFD.2030908@mvista.com>
Message-ID: <50E52D26.9010004@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

On 02.01.2013 20:43, Sergei Shtylyov wrote:
> Hello.
>
> On 07/30/2012 11:22 AM, Heiko Schocher wrote:
>
>> add OF support for the davinci nand controller.
>
>> Signed-off-by: Heiko Schocher<hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-mtd at lists.infradead.org
>> Cc: David Woodhouse<dwmw2@infradead.org>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Sekhar Nori<nsekhar@ti.com>
>> Cc: Wolfgang Denk<wd@denx.de>
>> Cc: Scott Wood<scottwood@freescale.com>
>
> [...]
>
>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>> index d94b03c..f386b3c 100644
>> --- a/drivers/mtd/nand/davinci_nand.c
>> +++ b/drivers/mtd/nand/davinci_nand.c
> [...]
>> @@ -518,9 +519,75 @@ static struct nand_ecclayout hwecc4_2048 __initconst = {
>>   	},
>>   };
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id davinci_nand_of_match[] = {
>> +	{.compatible = "ti,davinci-nand", },
>> +	{},
>> +}
>
>     I have only one question: have you ever try to compile this patch with
> CONFIG_OF enabled? If you have, you would have noticed:
>
> drivers/mtd/nand/davinci_nand.c:527: error: expected ?,? or ?;? before ?extern?
>
>> +MODULE_DEVICE_TABLE(of, davinci_nand_of_match);

Hmm.. maybe this crept in later after I sent the patches? They were
pending for a while ... I compiled it just yet again (based on my
tree when I posted this patch based on commit:

commit 3bf671af14d591ede9251acb0085e8017f3705e7
Merge: 1c212c6 4a5a418
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Aug 13 09:59:04 2012 +0300

     Merge branch 'fixes-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/linux-leds

and it compiled fine:

$ eldk-switch -r 5.2 armv7a
Setup for armv7a (using ELDK 5.2)
$ make -s uImage
arch/arm/kernel/return_address.c:62:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
arch/arm/kernel/return_address.c:62:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
arch/arm/mm/alignment.c: In function 'do_alignment':
arch/arm/mm/alignment.c:327:15: warning: 'offset.un' may be used uninitialized in this function [-Wuninitialized]
arch/arm/mm/alignment.c:749:21: note: 'offset.un' was declared here
drivers/mtd/chips/cfi_cmdset_0002.c: In function 'cfi_amdstd_panic_write':
include/linux/mtd/map.h:331:11: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]
drivers/mtd/chips/cfi_cmdset_0002.c: In function 'cfi_amdstd_write_words':
include/linux/mtd/map.h:331:11: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]
drivers/mtd/chips/cfi_cmdset_0001.c: In function 'cfi_intelext_write_words':
include/linux/mtd/map.h:331:11: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]
   Kernel: arch/arm/boot/Image is ready
   Kernel: arch/arm/boot/zImage is ready
Image Name:   Linux-3.6.0-rc1-01880-g0227e8b
Created:      Thu Jan  3 06:55:26 2013
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    2432040 Bytes = 2375.04 kB = 2.32 MB
Load Address: c0008000
Entry Point:  c0008000
   Image arch/arm/boot/uImage is ready
$
$ ${CROSS_COMPILE}gcc --version
arm-linux-gnueabi-gcc (GCC) 4.6.4 20120303 (prerelease)
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ grep -n CONFIG_OF .config
707:CONFIG_OF=y
713:# CONFIG_OF_SELFTEST is not set
714:CONFIG_OF_FLATTREE=y
715:CONFIG_OF_EARLY_FLATTREE=y
716:CONFIG_OF_ADDRESS=y
717:CONFIG_OF_IRQ=y
718:CONFIG_OF_DEVICE=y
719:CONFIG_OF_I2C=y
720:CONFIG_OF_NET=y
721:CONFIG_OF_MDIO=y
722:CONFIG_OF_MTD=y
1067:CONFIG_OF_GPIO=y
1629:CONFIG_OF_IOMMU=y
$

>     No need to worry now, I'll send out the trivial patch...

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
