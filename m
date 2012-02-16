From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 16 Feb 2012 00:32:57 -0800
Subject: [PATCH] mtd: fix the wrong check condition
In-Reply-To: <4F3C74DC.1000706@freescale.com>
References: <1329302008-10228-1-git-send-email-b32955@freescale.com>
 <4F3C712A.5060406@gmail.com> <4F3C74DC.1000706@freescale.com>
Message-ID: <CAN8TOE83E8Ws3qZ=WC7XdvTzuhjc2Y-NBYy3cC-u+5B3J=9wDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Add Angus)

Hi,

On Wed, Feb 15, 2012 at 7:15 PM, Huang Shijie <b32955@freescale.com> wrote:
>> On 2/15/2012 2:33 AM, Huang Shijie wrote:
>>>
>>> If we use `||` check condition, many NAND chips which are not
>>> ONFI nands have to do the ONFI detection.
>>
>>
>> Running the ONFI detection on non-ONFI NAND should not, ideally, be a
>> problem. They should fail one or both tests included in the routine:
>> the 'O N F I' string check or the CRC calculation.
>
> NO.

Whoa, no need to shout...

> I have Hynix nand in my hand: H27UBG8T2A (page size :8192, oob:448).
> It is not an ONFI nand.
>
> But it accidentally can pass the ONFI detection, and get the result : page
> size 4192, oob:96. This is a wrong result.

Yes, this is a wrong result, and that's pretty freaky. Why have a
standard if some chips are going to totally demolish it? Uggh...
Anyway, you totally left this information out of your patch. If you
had, then I would have told you that this patch does not solve *this*
problem either; where do you expect the "OOB:448" to come from?

(BTW, your attachment didn't come through properly. I'll look for the
datasheet elsewhere, I guess...)

>>> Use `&&` here to detect the ONFI NAND when we can not find any type
>>> in the nand_flash_ids.
>>
>>
>> There are many chips whose ID might be in the NAND table but for which
>> it is preferable (or even required) to check by ONFI for one reason or
>> another. For instance, some ONFI chips might use odd-sized OOB that
>> isn't in the ID decoding algorithm.
>>
> This nand is 32Gb, but we can not parse it out from the id.
> I ever want to add a new database which use the all the 8/6 bytes id as key.
> It seems it's time to change it now.

Yes, we need some kind of new database. Angus Clark had mentioned
wanting to update the table/detection mechanisms. I can help out too.
But it needs to be intelligent, since we *can't* log the 8-byte ID for
*every* chip. I have some ideas, though, and will share a few. Feel
free to do the same.

For starters, I'm thinking expand the table(s) to 8-byte ID, with some
sort of mask (or length?) parameter to record how many of the 8 bytes
are relevant. However, we would need a table for pre-ONFI checks (to
catch exceptions like this) and one post-ONFI (for most typical
non-ONFI chips):

(1) ID table for ONFI exceptions
(2) ONFI routines
(3) ID table for standard chips

We can extend (3) to use some of the current ID decoding mechanisms
(for chips who only have 2-byte IDs in their table entry).

Angus: do you have work-in-progress that you want to share for fixing
up NAND detection? Or shall we work on something new?

Brian
