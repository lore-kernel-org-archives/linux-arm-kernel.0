From: b32955@freescale.com (Huang Shijie)
Date: Wed, 20 Jul 2011 12:55:54 +0800
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <20005.21635.427202.49313@ipc1.ka-ro>
References: <20004.12663.29494.339601@ipc1.ka-ro>	<20110718164354.GA3328@S2100-06.ap.freescale.net>	<4E24E804.10002@freescale.com>	<20005.7677.145955.789329@ipc1.ka-ro>	<4E252C51.8070900@freescale.com>
	<20005.21635.427202.49313@ipc1.ka-ro>
Message-ID: <4E265FDA.5090306@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> Hi,
>
> Huang Shijie writes:
>> ? 2011?07?19? 14:02, Lothar Wa?mann ??:
>>> Hi,
>>>
>>> Huang Shijie writes:
>>>> hi  Lothar:
>>>>> On Mon, Jul 18, 2011 at 03:13:27PM +0200, Lothar Wa?mann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> with the gpmi-nfc driver for imx28 from Shawn Guo on a TX28 I
>>>>> To be clear, the author of gpmi-nfc driver is Huang Shijie (Cc-ed).
>>>>>
>>>>> Regards,
>>>>> Shawn
>>>>>
>>>>>> encountered some problems with jffs2 when overwriting pages that have
>>>>>> been written with 0xff (e.g. from padding from the file system image
>>>>>> file).
>>>> The GPMI driver now does not support the JFFS2 very well.
>>>> The JFFS2 will write the OOB, while the BCH of GPMI will use the OOB too.
>>>>
>>> I have applied a patch (from the Freescale BSPs) that prevents JFFS2
>>> from using the OOB area. But this still doesn't help.
>>>
>> Could you show the log ?
>>
> On the host:
>    mkfs.jffs2 -o ../rootfs.img -n -e 0x20000 -p -r .
> The last block gets padded with a stretch of 91840 bytes of 0xff.
> On the target:
>    flash_eraseall  /dev/mtd2
>    nandwrite /dev/mtd2 /rootfs-jffs2.image
> The raw data of the last used block in flash looks like this
> afterwards:
>    nanddump -n -p -l 0x800 -s 0x889800 /dev/mtd2
> |Block size 131072, page size 2048, OOB size 64
> |Dumping data starting at 0x00889800 and ending at 0x0088a000...
> |0x00889800: ff ff ff ff ff ff ff ff ff ff b7 00 00 00 f2 00
> |0x00889810: 00 00 06 00 00 00 7f ca a1 e3 e4 1f e9 24 78 5e
> |0x00889820: 34 8f 41 0e 83 30 0c 04 ef 7d 85 25 ae 6d f3 8e
> |0x00889830: de fb 81 10 0c b1 08 76 e4 18 10 bf af 83 d4 93
> |0x00889840: 2d 6b 67 77 3d c0 37 53 83 99 0a 82 cf 76 6d 85
> |0x00889850: 78 c5 09 4c 20 a0 a5 a0 d8 a4 1c ef 24 3c 3f 06
> |0x00889860: f8 58 57 ad 58 7d 32 84 23 6a d0 9d c3 94 53 4d
> |0x00889870: a1 33 23 42 1c dd cb d7 4d 76 36 b0 8c a0 22 36
> |0x00889880: 37 c7 15 e3 f4 12 2e 17 9c b9 27 56 77 47 3d 88
> |0x00889890: 97 5b 57 a5 35 1a a9 90 5d dd 20 c7 c3 4b 99 53
> |0x008898a0: a7 92 19 b2 3b 8c 17 dc 61 d3 13 68 be 21 46 3b
> |0x008898b0: 45 57 e8 0d 69 d9 35 1a 09 f7 96 ff 83 3f f3 13
> |0x008898c0: 40 69 f9 45 0a 2e 1e ce 01 7a 5c ca 5c 00 01 06
> |0x008898d0: 00 2b 56 54 c6 ff 85 19 01 e0 2f 00 00 00 b1 f9
> |0x008898e0: 44 f2 c2 03 00 00 d5 03 00 00 c8 03 00 00 a7 ac
> |0x008898f0: e3 4d 07 08 00 00 55 81 af 84 e8 5f 94 39 79 70
> |0x00889900: 2e 63 6f 6e 66 ff 85 19 02 e0 44 00 00 00 1d fb
> |0x00889910: f7 98 c8 03 00 00 01 00 00 00 a4 81 00 00 00 00
> |0x00889920: 00 00 00 00 00 00 a7 ac e3 4d a7 ac e3 4d a7 ac
> |0x00889930: e3 4d 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> |0x00889940: 00 00 00 00 00 00 13 77 d1 ba ff ff ff ff ff ff
> |0x00889950: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [...]
> |0x00889a00: ff ff ff ff ff ff ff ff ff ff 27 21 37 1b 06 87
> |0x00889a10: 70 f1 00 0e 6a 8e 57 ff ff ff ff ff ff ff ff ff
> |0x00889a20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [...]
> |0x00889c10: ff ff ff ff ff ff ff 08 75 8b 6f 48 36 a6 bc 16
> |0x00889c20: 61 58 db 52 ff ff ff ff ff ff ff ff ff ff ff ff
> |0x00889c30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [...]
> |0x00889e20: ff ff ff ff 08 75 8b 6f 48 36 a6 bc 16 61 58 db
> |0x00889e30: 52 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> |0x00889e40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> [...]
> |  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> |  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> |  OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> |  OOB Data: ff 08 75 8b 6f 48 36 a6 bc 16 61 58 db 52 00 00
>
> The remaining pages of this block are all-FF except for the ecc
> pattern as above.
>
> Checking the readability of the whole flash partition shows no errors:
>    dd if=/dev/mtdblock2 of=/dev/null
> |32768+0 records in
> |32768+0 records out
> |16777216 bytes (17 MB) copied, 18.6754 s, 898 kB/s
>
> Mounting the partition and writing some file produces ecc errors upon
> successive reads:
>    mount -t jffs2 /dev/mtdblock2 /mnt
>    touch /mnt/xxx
It seems the writing of JFFS2 corrupted something.
So the following commands will fail.

You can add some log in the functions 
mil_ecc_write_page()/mil_ecc_read_page()
to check what kind of error occurs.


Best Regards
Huang Shijie



>    umount /mnt
>    dd if=/dev/mtdblock2 of=/dev/null
> |end_request: I/O error, dev mtdblock2, sector 17488
> |Buffer I/O error on device mtdblock2, logical block 2186
> |end_request: I/O error, dev mtdblock2, sector 17488
> |Buffer I/O error on device mtdblock2, logical block 2186
> |dd: reading `/dev/mtdblock2': Input/output error
> |17488+0 records in
> |17488+0 records out
> |8953856 bytes (9.0 MB) copied, 10.243 s, 874 kB/s
>
> Remounting the file system:
>    mount -t jffs2 /dev/mtdblock2 /mnt
> |mtd->read(0x1fdfc bytes from 0x880204) returned ECC error
> |mtd->read(0x166bc bytes from 0x889944) returned ECC error
> |Empty flash at 0x00889940 ends at 0x0088a000
>
>>>> So I have to disable the JFFS2 to use the OOB. I have not finish the
>>>> code about it now.
>>>>
>>>> I recommend you use the UBIFS. But the latest version of GPMI driver
>>>> meets a DMA bug.
>>>> I am debugging the DMA bug now. and I will send it out when i fix it.
>>>>
>>> What sort of DMA bug?
>>>
>> The DMA may time-out. :(
>>
>> The DMA time-out may occur in two situations:
>> [1] send a command DMA descriptor, see the nfc->send_command() function.
>> [2] read the non-ecc data from nand, see the nfc->read_data() function.
>>
>> I don't know why. Maybe caused by the timing, or something else.
>>
> Maybe you are missing this patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/049105.html
> I sent it in April, but apparently it has not been integrated in
> mainline or the pengutronix git.
>
>
> Lothar Wa?mann
