From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 17 Feb 2012 11:07:44 +0800
Subject: [PATCH] mtd: fix the wrong check condition
In-Reply-To: <4F3CE2D4.4070506@freebox.fr>
References: <1329302008-10228-1-git-send-email-b32955@freescale.com>
 <4F3C712A.5060406@gmail.com> <4F3C7433.5030306@freescale.com>
 <4F3CE2D4.4070506@freebox.fr>
Message-ID: <CAMiH66GRD97y4mK-9TCRqsQkTOoqqwVp4gREv3=0qiX_vrueGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Thu, Feb 16, 2012 at 7:04 PM, Florian Fainelli <ffainelli@freebox.fr> wrote:
> Hi,
>
> On 02/16/12 04:12, Huang Shijie wrote:
>>
>> Hi,
>>>
>>> (Add Florian and Matthieu)
>>>
>>> On 2/15/2012 2:33 AM, Huang Shijie wrote:
>>>>
>>>> If we use `||` check condition, many NAND chips which are not
>>>> ONFI nands have to do the ONFI detection.
>>>
>>>
>>> Running the ONFI detection on non-ONFI NAND should not, ideally, be a
>>> problem. They should fail one or both tests included in the routine:
>>> the 'O N F I' string check or the CRC calculation.
>>
>> NO.
>
>
> Can you please post the dump of the ONFI page as read by your controller? Is
> the CRC check passing? The ONFI crc function is made so that a page full of
> zeroes or 0xff won't generate a respectively 0 or ff checksum, so we should
> catch this during the CRC check.
>
Sorry. I did not check the log carefully.

the Hynix nand does _not_ pass the CRC check, but it passed the "ONFI"
string check.

The log "ONFI flash detected" made me misunderstood.

BR
Huang Shijie


>>
>> I have Hynix nand in my hand: H27UBG8T2A (page size :8192, oob:448).
>> It is not an ONFI nand. See the datasheet in the attachment.
>> But it accidentally can pass the ONFI detection, and get the result :
>> page size 4192, oob:96. This is a wrong result.
>
>
> I have already seen a Hynix chip answering to the READID command too, and
> this was highly confusing our bootloader, however, I suppose that we should
> be able to circumvent this issue anyway.
>
>>
>>
>>
>>
>>>
>>>> Use `&&` here to detect the ONFI NAND when we can not find any type
>>>> in the nand_flash_ids.
>>>
>>>
>>> There are many chips whose ID might be in the NAND table but for which
>>> it is preferable (or even required) to check by ONFI for one reason or
>>> another. For instance, some ONFI chips might use odd-sized OOB that
>>> isn't in the ID decoding algorithm.
>>>
>> This nand is 32Gb, but we can not parse it out from the id.
>> I ever want to add a new database which use the all the 8/6 bytes id as
>> key.
>> It seems it's time to change it now.
>
>
> You have said that already, but we have yet to see patches for this, I guess
> if you can post your database patch that will be easier to comment on.
> --
> Florian
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
