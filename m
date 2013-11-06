From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 17:36:02 -0800
Subject: [PATCH v3 13/28] mtd: nand: pxa3xx: Add bad block handling
In-Reply-To: <20131105234055.GE11759@localhost>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-14-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105182301.GN20061@ld-irv-0074.broadcom.com>
 <20131105234055.GE11759@localhost>
Message-ID: <CAN8TOE_BVQA4CHZL0=krzakw4izsaaw4_tGFwvdUAj12ZZr19w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 3:40 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Tue, Nov 05, 2013 at 10:23:01AM -0800, Brian Norris wrote:
>> On Tue, Nov 05, 2013 at 09:55:20AM -0300, Ezequiel Garcia wrote:
>> > --- a/drivers/mtd/nand/pxa3xx_nand.c
>> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> > @@ -1128,6 +1152,14 @@ KEEP_CONFIG:
>> >
>> >     if (nand_scan_ident(mtd, 1, def))
>> >             return -ENODEV;
>> > +
>> > +   if (pdata->flash_bbt) {
>> > +           chip->bbt_options |= NAND_BBT_USE_FLASH |
>> > +                                NAND_BBT_NO_OOB_BBM;
>>
>> You're using NAND_BBT_NO_OOB_BBM? So you are unable to write bad block
>> markers to flash at all? Is this related to your independent patch for
>> trying to scan BBM from the data area?
>
> Yes.
>
>> Could you instead write a
>> nand_chip.block_markbad() callback routine that would program BBM to the
>> appropriate data area?
>
> No :-)

Well given the reset of your comments, I guess you could write an
empty one (or one with a BUG() or WARN()?).

>> Or, if you really want to avoid programming new BBMs, then you should
>> probably describe this decision in the patch description more clearly.
>>
>
> Right.
>
> I'll have to describe a bunch of stuff about the controller so this
> NO_OOB_BBM makes sense. Please bare with me and keep reading :)

[snip nice description; I did read it!]

> So, there's no point in marking a block as bad, because good blocks
> are *also* mark as bad. We need to rely in the bad block table, and only
> perform the scan in on the very first time (when the device is unused).

Right. I didn't quite think through this whole process.

I think a short (few lines) comment in the code to describe the
justification for using NAND_BBT_NO_OOB_BBM is in order for v4. And
maybe include a bit of this in the commit message as well.

> We're aware this sounds kind of crappy since we'll get completely screwed
> in case the bad block table is somehow lost or corrupted, but we don't
> care about such case.
>
> Still, I'd like to know:
>
> 1. Do you think the bad block table could be corrupted or is this not
> likely to ever happen?

Yes, it can be. But no, I don't think it's likely. There are very few,
rare instances where we have to modify the BBT (and thereby make it
susceptible to corruption), and those instances have some level of
robustness to them. Of course, they still have room for improvement.
(I suppose there could as be corruption due to read disturb; but this
is also handled now, by scrubbing the affected BBT blocks that return
-EUCLEAN, refreshing them with clean data.)

Personally, I've experienced "corruption" primarily when I have boards
where I change the ECC configuration; then the BBT scan sees -EBADMSG
and has to rebuild the table.

> 2. Do you have any ideas to 'avoid' writing to the marker? or maybe to
> otherwise scan the factory markers the first time, but then use some
> other position for the kernel in-flash BB marker?

Hmm, not really. We've kind of co-opted the idea of the factory bad
block marker as a secondary, distributed bad block table in the
kernel. It's not really the expected use case, and it breaks in cases
like yours, since we don't support a third form of bad block
marker/table for post-initial-scan markers. I think the best solution
in this case is just to rely solely on the BBT after the first scan.

Brian
