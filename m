From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 10 Dec 2012 18:51:01 +0800
Subject: at91: Status of NAND flash access
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE4013765D973C9@pluto.melinkcorp.local>
References: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
 <50BDD661.7070803@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765CC3D14@pluto.melinkcorp.local>
 <50BEF0C0.7060807@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765D969EE@pluto.melinkcorp.local>
 <91586D499ADFD74FBCFB8425266A5DE4013765D96E77@pluto.melinkcorp.local>
 <50C073BD.7060604@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765D96EA5@pluto.melinkcorp.local>
 <50C1B741.9030209@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765D973C9@pluto.melinkcorp.local>
Message-ID: <50C5BE95.30609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bryan

On 12/7/2012 10:47 PM, Bryan Evenson wrote:
> Josh,
>
> Answers below.
>
> Regards,
> Bryan
>
>> -----Original Message-----
>> From: Josh Wu [mailto:josh.wu at atmel.com]
>> Sent: Friday, December 07, 2012 4:31 AM
>> To: Bryan Evenson
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: Re: at91: Status of NAND flash access
>>
>> Hi, Bryan
>>
>> Thanks for doing such test. see my comment below:
>>
>> On 12/6/2012 9:20 PM, Bryan Evenson wrote:
>>>> -----Original Message-----
>>>> From: Josh Wu [mailto:josh.wu at atmel.com]
>>>> Sent: Thursday, December 06, 2012 5:30 AM
>>>> To: Bryan Evenson
>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>> Subject: Re: at91: Status of NAND flash access
>>>>
>>>> On 12/6/2012 11:13 AM, Bryan Evenson wrote:
>>>>> Josh,
>>>>>
>>>>> I spoke too soon.  I was able to read and use the filesystem from
>>>> NAND
>>>>> flash with the patch you provided when I applied it to the Atmel
>> 3.4
>>>>> kernel fork over at https://github.com/linux4sam/linux-at91/
>> (master
>>>> branch).
>>>>> When I applied the same patch to the recent mainline kernel (3.7-
>>>> rc8),
>>>>> it's still having problems accessing flash.  The boot log shows
>> that
>>>>> it is setting up for PMECC correctly, but it has errors when it
>>>>> tries to read from the filesystem.
>>>> It is strange.  The 3.4 kernel from at91 github just have a few
>>>> changes.
>>>> so rationally it behavior the same at PMECC function. From your log,
>>>> the
>>>> 3.7-rc8 kernel says the PMECC found uncorrectable errors.
>>>>
>>>> Can you try to dump or read from the u-boot? to see whether u-boot
>>>> can recognize the same nand page that "too many errors" happened in
>> kernel?
>>>> I will do some test to see whether the 3.7-rc8 can work in my side
>> or
>>>> not.
>>> U-Boot> nand read 0x22000000 0x800000 0x1D00000
>>>
>>> NAND read: device 0 offset 0x800000, size 0x1d00000
>>> PMECC: Too many errors
>>> NAND read from offset 800000 failed -5
>>>    0 bytes read: ERROR
>>>
>>> So u-boot has the same issue.
>> seems some page are really damaged or the error correction code has
>> bugs.
>>
>>> However, changing the kernel to the linux-at91 forked kernel produced
>>> different results.  That kernel noted the PMECC errors but was still
>>> able to load the filesystem.
>> I don't find the 3.4 kernel noted the PMECC errors in your attached
>> log.
>>
>>>     My boot output from the successful
>>> filesystem load is below.  Is the 3.4 kernel performing corrections
>>> that the mainline is not,
>> no. I don't think so. The PMECC part of patch is the almost same. Only
>> some minor change are made in v3.4 for back port.
>>
>>> or is it just ignoring errors that it should not be ignoring?
>> This is more possible. I means maybe 3.4 kernel doesn't check some area
>> 3.7-rc8 checked.
>>
>>> I'm hesitant to make any filesystem changes on this board because I
>>> know test cases like this where it works one way but not the other
>> are
>>> kind of rare.  Let me know if you have similar results on your end.
>> I tested in two version of kernel my side:
>>    1. https://github.com/linux4sam/linux-at91/commits/at91-3.4-
>> trunk_merge
>>             fcf88e036fce6c382510874b1dc90e9b49608ccf (Merge branch
>> 'at91-3.4-trunk/v3.4.x_gmac' into at91-3.4-trunk_merge)
>>    2. v3.7-rc8 plus the patch I sent to you to enable PMECC in dtsi.
>>
>> I cannot reproduce the situation you met In my side. Both can boot the
>> ubi rootfs system correctly.
>>
>> So the your case is rare.
>>
>> To find out why those two kernel work differently, could you help me to
>> do:
>>
>>      1. use u-boot "nand read" to do some bisect in nand flash offset,
>> which we can narrow down the page that has uncorrectable pmecc errors.
>>
> After trial and error, I got down to this:
> nand read 0x22000000 0x865000 0x100
>
> NAND read: device 0 offset 0x865000, size 0x100
> PMECC: Too many errors
> NAND read from offset 865000 failed -5
>   0 bytes read: ERROR
>
>>      2. use u-boot "nand dump offset" to show the raw data of that page.
>> please send me the log. I can generate the same page from your log. and
>> check whether it can be corrected in my side.
> U-Boot> nand dump 0x865000
> Page 00865000 dump:
>          31 18 10 06 52 bd c6 c9  5d 44 02 00 00 00 00 00
>          00 02 00 00 07 00 00 00  04 15 00 00 00 00 00 00
>          05 00 00 00 00 00 00 00  03 00 00 00 04 00 00 00
>          0f 01 00 00 c8 5a 00 00  58 00 00 00 d8 00 00 00
>          0f 01 00 00 00 60 00 00  30 3b 0b 00 00 00 00 00
>          00 18 7a 0c 00 00 00 00  08 2f 84 00 00 00 00 00
>          c8 ad b6 01 00 00 00 00  c0 5a 02 00 00 00 00 00
>          08 06 a3 00 00 00 00 00  08 00 00 00 e2 28 00 00
>          08 00 00 00 00 30 00 00  08 00 00 00 00 28 00 00
>          00 00 00 00 00 00 00 00  67 01 00 00 6e 06 00 00
>          07 00 00 00 a8 07 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          31 18 10 06 ef de 0e ee  00 00 00 00 00 00 00 00
>          1c 00 00 00 05 00 00 00  e4 05 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>          00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> OOB:
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff ff ff ff ff
>          ff ff ff ff 3f 00 02 00

If we enable 2 bits PMECC with sector size "512", then this page is 
uncorrectable.
in this case, all PMECC byte should be last 16 bytes in the end of oob. 
Every sector (512 bytes) has 4 bytes pmecc bytes
And "0xff 0xff 0xff 0xff" means the whole sector is "0xff".
so in your page's ecc value, the first 3 sector are all "0xff", but the 
the first 3 sector data are not "0xff".

I write same data in my nand flash with 2bit PMECC, the oob should be:

U-Boot> nand dump b0000
Page 000b0000 dump:
         31 18 10 06 52 bd c6 c9  5d 44 02 00 00 00 00 00
         00 02 00 00 07 00 00 00  04 15 00 00 00 00 00 00
         05 00 00 00 00 00 00 00  03 00 00 00 04 00 00 00
         0f 01 00 00 c8 5a 00 00  58 00 00 00 d8 00 00 00
         0f 01 00 00 00 60 00 00  30 3b 0b 00 00 00 00 00
         00 18 7a 0c 00 00 00 00  08 2f 84 00 00 00 00 00
         c8 ad b6 01 00 00 00 00  c0 5a 02 00 00 00 00 00
         08 06 a3 00 00 00 00 00  08 00 00 00 e2 28 00 00
         08 00 00 00 00 30 00 00  08 00 00 00 00 28 00 00
         00 00 00 00 00 00 00 00  67 01 00 00 6e 06 00 00
         07 00 00 00 a8 07 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         31 18 10 06 ef de 0e ee  00 00 00 00 00 00 00 00
         1c 00 00 00 05 00 00 00  e4 05 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
OOB:
         ff ff ff ff ff ff ff ff
         ff ff ff ff ff ff ff ff
         ff ff ff ff ff ff ff ff
         ff ff ff ff ff ff ff ff
         ff ff ff ff ff ff ff ff
         ff ff ff ff ff ff ff ff
         20 02 b8 03 a3 e6 97 01
         00 00 00 00 00 00 00 00

So I wondering that the pmecc is set correctly or not.

>>      3. in 3.4 kernel, use dd command to read that page, to see any
>> uncorrectable pmecc error happen.
>>            if no error happens in 3.4, then it means it correct that
>> v3.7-rc8 cannot. There mush be something different in 3.4 kernel pmecc
>> between mainline.
>>            if error happens, that means 3.4 kernel skips those area but
>> 3.7-rc8 does not. So I suspect it maybe caused by some code of UBI part
>> changes.
> root at at91sam9x5ek:~# dd if=/dev/mtd1 of=/var/log/dump.bin bs=1k count=1 skip=65
> 1+0 records in
> 1+0 records out
> 1024 bytes (1.0KB) copied, 0.001962 seconds, 509.7KB/s
>
> If I understand dd correctly, that should be reading 1KB of data starting at
> 0x865000 (/dev/mtd1 starts at 0x800000, plus offset of 65 1KB blocks).

hmm, the 0x1000 is not 1k, it is 4k.
and the skip block number should be 0x65, that means 101.
so the command line in your case should be:

dd if=/dev/mtd1 of=/var/log/dump.bin bs=4k count=1 skip=101

the better idea is, use following command to check the result to make 
sure your dump right offset.
   hexdump -C /var/log/dump.bin


>   If I
> read the wrong block, let me know what the correct command line should be.
>
>> Best Regards,
>> Josh Wu
>>
>>> -Bryan
>>>
>>>
[snip]

I my thought, the situation in your side is:
    1. The same board and the nand flash rootfs is the same. same 
bootargs for the mtd partitions.
    2. Only use tftp to load different dtb and uImage via u-boot. (3.4 
and 3.7-rc8)
    3. Different kernel cause different result.

So my suggested test is base on above assumption.

But since you flush the dtb into nand flash (in your readme file of the 
dropbox), so it is not like the situation as I list above.

Since I already got your shared file in dropbox, so I will test your 
kernel in my 9g25ek board tomorrow in Shanghai time zone to see what 
will happen in my side. :)

Best Regards,
Josh Wu
