From: b32955@freescale.com (Huang Shijie)
Date: Thu, 15 Sep 2011 10:21:17 +0800
Subject: [PATCH V3 3/6] MTD : add the database for the NANDs
In-Reply-To: <CAN8TOE9-iEPyWXLsxddeofazgrCWDWKgrx6eBkr7vdKErfgeCA@mail.gmail.com>
References: <1301474413-28821-1-git-send-email-b32955@freescale.com>	<1301474413-28821-4-git-send-email-b32955@freescale.com>	<201103301046.04357.ffainelli@freebox.fr>	<4D92F277.7060607@freescale.com>	<1301566248.2828.40.camel@localhost>	<AANLkTi=59br1KueZupGevB4DgP7UqBKRgbGgRvsjgH-8@mail.gmail.com>
	<CAN8TOE9-iEPyWXLsxddeofazgrCWDWKgrx6eBkr7vdKErfgeCA@mail.gmail.com>
Message-ID: <4E71611D.7030508@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian:
> Hi,
>
> I see nothing has happened with this thread recently. It doesn't
> deserve to die though.
>
> On Thu, Mar 31, 2011 at 10:17 AM, Huang Shijie<shijie8@gmail.com>  wrote:
>> 2011/3/31 Artem Bityutskiy<dedekind1@gmail.com>:
>>>>> If you have new chips to support in the future, you should add them in
>>>>> drivers/mtd/nand/nand_ids.c and not keep this file.
>>>>>
>>>> The data structure  nand_flash_dev{} does not contain enough information.
>>>> So I want to the nand_device_info{} to replace it in future.
>>> Just add this information, if it is of generic nature (like SLC/MLC
>>> flag, required ECC strength, etc).
> Are SLC/MLC and ECC strength necessary to track? I don't see a good
> benefit to cost ratio of trying to detect ECC strength especially,
> since the levels specified in data sheets vary without much pattern
> and nobody provides a way for decoding this from ID; do you really
> want to have to make separate chip entries for every single chip that
> comes around?
I do not need the SLC/MCL info. But i do need the ECC strength for the BCH.
Currently i compute it myself based on the ECC chunk size to be 512 bytes.
It's ok now.

But the ONFI nand MAYBE has its own requirements, such as some ONFI nand
requires '24-bit ECC per 1080 bytes of data'(see 
MT29F64G08CBAAA,MT29F128G08CEAAA).
In this case, setting the ECC chunk size to 512 bytes maybe is not 
proper. It's better to
set the ECC chunk size to 1k, and set ECC strength to 24bit.

So, add the ECC strength to nand is worthful ( at least, it's useful for 
ONFI nand) .



>>>>> I still do not understand why this would be needed, is it because the generic
>>>>> code does not provide enough informations for your driver?
>>>>>
>>>> yes.
>>>>
>>>> IMHO, the generic code is somehow trapped in a wrong way. :(
> I may agree, but can you be more specific on the trap?
>
I meant the parsing id code is not good.
Maybe i am wrong.
>>>> Paring the id bytes is not sufficient to get all the information you
>>>> need which is faced by me.
> What's an alternative to "paring the id bytes"?
>
I meant the the code can not get sufficient info for ONFI nand.

But the current code can parse out the info for ONFI nand now.
though it does not parse out all the info.

>>>> What's more, I think the paring code is ugly, see the nand_get_flash_type().
>>> You are welcome to fix this. There is _a lot_ of ugly code in MTD
>>> because no one loves it. Give it some love :-)
> While I agree that a lot of this is ugly, it is mostly a matter of
> necessity. NAND manufacturers do not have a standard (ONFI doesn't
> really count, since there's basically 1 manufacturer using it), and so
> the most "generic" code is to have different code paths for different
> manufacturers (often with exceptions to each rule, since even a single
> manufacturer changes its standards arbitrarily). Then you find
> manufacturers like Toshiba that recently don't have any (published)
> pattern at all for detecting OOB size generically.
>
> Thus, it seems to me like we will need some form of the approach
> provided by Huang. As I've found, there are some things that just
> can't be decoded from the ID these days, so our ID table will need to
> be able to track:
> * full ID string (not just the 2nd byte "Device ID")
The same idea as mine. :)   I also thought it's better to store all the 
ID bytes.
> * relevant bad block scanning options
>
> FWIW, we already implement an exception table in our own driver that
> includes the above 2 items, for chips that can't be handled with the
> table/detection structure as-is. We don't particularly need SLC/MLC
> but I don't object to recording it if we can determine it reliably,
> and while ECC level could be useful, it is difficult to discover
> generically, as I mentioned above.
>
at least the ECC strength is needed.
>>>> Why not create a new database which contains all the necessary
>>>> information for a nand, and can be easy
>>>> find by the id bytes as the keyword?
>>> You can create this database by extending/improving/cleaning up the
>>> existing code base with a nice series of patches.
>>>
>> ok. I will try to fix the generic code before my driver is submitted.
> What happened to this statement? I see that your driver was submitted,
> but no efforts were made for chip detection cleanup. Were you
> satisfied with the current detection?
I am not satisfied with the current code.
I wish I could add the  code to parsing out  the ECC strength of ONFI, 
and something else.
But I have no time to do this. :(
feel bad.
> While we're on the subject, I'll direct your attention to this NAND
> data table that I've worked on. It should provide a decent summary of
> most of the data sheets I have sorted through. It should also show you
> that certain things are going to be very hard to detect (e.g., ECC
only the ONFI nand's ECC strength is useful now.
You can ignore the normal NANDs, i can compute it myself.
> level). It should also show that while some chips are not supported by
> standard code (e.g., weird bad block scanning features that haven't
> been supported, non-standard OOB sizes with no given pattern in the
> datasheets), the vast majority of the chips I've come across should be
> detected properly:
>
> http://linux-mtd.infradead.org/nand-data/nanddata.html
>
very good!

Huang Shijie

> And of course, please contribute to
> git://git.infradead.org/mtd-www.git if you have additions or edits for
> the table. It's not perfect, but it can help for sorting through
> different chips.
>
> Brian
>
