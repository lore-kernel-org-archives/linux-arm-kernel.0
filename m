From: zhaoxiu.zeng@gmail.com (Zeng Zhaoxiu)
Date: Fri, 8 Apr 2016 09:51:04 +0800
Subject: [PATCH] mtd: nand: s3c2410: fix bug in s3c2410_nand_correct_data()
In-Reply-To: <20160408021817.274d4e59@bbrezillon>
References: <1460047697-72830-1-git-send-email-zengzhaoxiu@163.com>
 <20160408021817.274d4e59@bbrezillon>
Message-ID: <57070E88.5020008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?04?08? 08:18, Boris Brezillon ??:
> Hi Zeng,
>
> On Fri,  8 Apr 2016 00:48:17 +0800
> zengzhaoxiu at 163.com wrote:
>
>> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>>
>> If there is only one bit difference in the ECC, the function should return 1.
>> The result of "diff0 & ~(1<<fls(diff0))" is equal to diff0, so the function
>> actually returns -1.
>>
>> Here, we can use the simple expression "(diff0 & (diff0 - 1)) == 0" to determine
>> whether the diff0 has only one 1-bit.
> Missing Signed-off-by here.
>
>> ---
>>   drivers/mtd/nand/s3c2410.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
>> index 9c9397b..c9698cf 100644
>> --- a/drivers/mtd/nand/s3c2410.c
>> +++ b/drivers/mtd/nand/s3c2410.c
>> @@ -542,7 +542,7 @@ static int s3c2410_nand_correct_data(struct mtd_info *mtd, u_char *dat,
>>   	diff0 |= (diff1 << 8);
>>   	diff0 |= (diff2 << 16);
>>   
>> -	if ((diff0 & ~(1<<fls(diff0))) == 0)
>> +	if ((diff0 & (diff0 - 1)) == 0)
> Or just
>
> 	if (hweight_long((unsigned long)diff0) == 1)
>
> which is doing exactly what the comment says.
>
> BTW, I don't understand why the current code is wrong? To me, it seems
> it's correctly detecting the case where only a single bit is different.
> What are you trying to fix exactly?
>
> Best Regards,
>
> Boris
>

For example, assuming diff0 is 1, then fls(diff0) is equal to 1, then "~(1 << fls(diff0))" is equal to 0xfffffffd,
then the result of "(diff0 & ~(1 << fls(diff0)))" is 1 , not we expected 0.

__fls(diff0) and "(fls(diff0) - 1)" are all right, but fls(diff0) is wrong.
