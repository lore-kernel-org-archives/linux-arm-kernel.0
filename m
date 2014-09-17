From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed, 17 Sep 2014 18:21:35 -0400
Subject: [RFC 2/5] mtd:fsl_nfc: Add hardware 45 byte BHC-ECC support for
 24 bit corrections.
In-Reply-To: <c444059de888a661fadf3d6be598a98d@agner.ch> (Stefan Agner's
 message of "Wed, 17 Sep 2014 22:08:04 +0200")
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch> <87r3zaxgtr.fsf@nbsps.com>
 <c444059de888a661fadf3d6be598a98d@agner.ch>
Message-ID: <87lhphyjkg.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 Sep 2014, stefan at agner.ch wrote:

> Am 2014-09-17 20:06, schrieb Bill Pringlemeir:
>> On 17 Sep 2014, stefan at agner.ch wrote:

>>> On one of our Colibri VF61 modules I discovered an issue using this
>>> driver:

>>> [    0.758327] ECC failed to correct all errors (ebd9fd80)
>>> [    0.767005] ECC failed to correct all errors (ebd9fd80)
>>> [    0.775525] ECC failed to correct all errors (ebd9fd80)
>>> [    0.784004] ECC failed to correct all errors (ebd9fd80)
>>> [    0.791938] UBI error: ubi_io_read: error -74 (ECC error) while
>>> reading 2048 bytes from PEB 28:2048,
>>> read 2048 bytes

[snip]

>>> Also, I could not find that the reference manual states that
>>> ecc_count represents the amount of flipped byte in a empty page. Is
>>> this given by the ECC algorithm?

>> I was using this information.
>>
>> Table 31-18. ECC Status Word Field Definition
>>
>> 7            0 Page has been successfully corrected
>> CORFAIL      1 Page is uncorrectable
>>
>> 5?0          Number of errors that have been corrected in this page
>> ERROR_COUNT
>>
>> This is from the Vybrid RM, but the MPC5125RM has the same
>> information.
>>
>> I have definitely tested the detection of 'erased pages'.  However, I
>> don't know that I ever had actual bit flips.

>> The ECC controller has no idea whether the page is empty or not.  Are
>> you saying you have an erased page with bit flips?  I have definitely
>> not tested this.

> Yes, that's what it looks like. Note that this output is on first boot
> after flashing the device (with the UBI auto-grow option). I guess UBI
> is reading all pages once to verify that they are empty.

>>>> + /* If 'ecc_count' zero or less then buffer is all 0xff or
>>>> erased. */ + flip = count_written_bits(dat, nfc->chip.ecc.size,
>>>> ecc_count);
>>
>> There are two issues.
>>
>> 1) erased page with some physical flipped bits (zero).
>> 2) erased page were controller flipped some bits.

> I did not know that issue 2 exists. How can 2 happen on a erased page?
> With a 'stuck at zero' in OOB?

Issue 2 is always an issue when reading an erased page with hardware
ECC.  So we have,

                    Main         Spare
    Good program:   Data    OOB-data+HW-ECC
    Good erased:    FF      FF  FF
    Stuck erased1:  FF      FF  xx
    Stuck erased2:  xx      xx  FF

For the 'good erased' the controller goes about like it is case 'good
program'.  It reads a sector (raw read or software ECC case) and a the
same time, the error corrector is running.  This examines the 'OOB
data', which is 0xff for the erased sector and it blindly begins to
apply the error correction to the main data section.  The 'correction'
for an erased block will always flip '1' to '0'.  So for 'good erased',
the 'error_count' will equal the flipped bits.

Now, your sectors aren't that bad.  I believe you only have one bit
error on an erase.  However, it is really hairy to know what the ECC
logic will do when you have bit flips in the ECC code.  It is also next
to impossible to examine the buffer and know if zero bits are due to the
ECC engine flipping the bits and/or the actual physical flash having the
stuck bit.  It appears that the ECC engine runs from start to finish.
So most of the ECC corrections should be at the start; use this info for
diagnostics, but not coding!

The best course IMHO is to do what Brian (and other) did and do a 'raw'
read, so you take the ECC engine out of the picture and stop it from
flipping bits.  You can experiment with always doing the raw read, but I
believe you will see a decrease in performance (as others mentioned and
I saw).

>> Currently, the code is only handling case 2 (that is what the
>> controller counts).  I believe that your physical page has actual
>> 'stuck at zero' bits.  The current driver gives up.  If you want to
>> handle this then we should replace the lines,

> I assumed that your code assumes that the controller returns the
> flipped bit count when reading an erase page (case 1), which I did not
> found in the documentation.

>>> +	/* ECC failed. */
>>> +	if (flip > ecc_count)
>>> +		return -1;

>> With something like,
>>
>> +	/* Not completely empty. */
>> +	if (flip > ecc_count) {
>> +           re_read_page_w_ecc_off();
>> +           if (count_written_bits() > strength) /* strength/2 ? */
>> +		return -1;
>> +      }
>>
>> There is also a discussion on this here,
>>
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052507.html
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052508.html
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052509.html
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052526.html
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052527.html
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052619.html
>> ... etc.  Use the view thread.
>>
>> Especially,
>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052647.html
>>
>> Here Brian says that 3b applies to SLC NAND.  I guess this is you :).

> Yes, we are using Macronix SLC NAND.

Well, it is everyone.  Sorry, I made the assumption this wouldn't
happen, but apparently it does.

>> It is fairly common to read an erased page.  Doing 'raw reads' all
>> the time on an erased page will slow the file system.  However, doing
>> re-reads for an erased page with bit flips is probably fairly
>> uncommon.  A flash in this state maybe near EOL or the sector was bad
>> from the factory but not marked so.

> This is a new device, but its one out of several dozens. The device
> had two factory marked bad page. This four page would then be 6 bad
> pages. I would say that your guess is probably the case at hand
> (should be considered bad, but were marked by factory).

>> I am chasing an DDR2 issue on another CPU and haven't had much more
>> time to the look at the Vybrid nor follow the MTD mailing list.  I
>> don't know if the 'NAND_ECC_NEED_CHECK_FF' feature has been merged?
>> It may also solve the issue.
>
> A quick search through 3.17-rc3 didn't found that string.

> I will read the pages using raw again and check how many bit flips it
> shows. But I guess regarding Brian's comment to 3b, the driver
> actually behaves correct and return -1, because we have bit flips on
> erased page which is not good...

Hmm.  No, it should be ok; I think Brian meant we should accept and
expect this.  We had this conversation after the RFC.  However, we
should probably only accept strength/2 zero values at most; I believe
what to accept was kind of hanging in that conversation.  If the zeros
are below our threshold with a raw read, then we can report the page is
all '\xff' and return a 'bit flip' count as the number of zeros found in
a raw read.  Also, in the 'all FFs' case we should probably memset the
OOB data.  I see that other patches mentioned in the MTD threads above
do this.

 +	/* Not completely empty. */
 +	if (flip > ecc_count) {
 +           re_read_page_w_ecc_off();
 +           ecc_count = count_zero_bits();
 +           if (ecc_count > strength/2)
 +		return -1;
 +      } else
 +          ecc_count = 0;  /* 'normal' case all ff */
 +
 +	/* Erased page. */
 +	memset(dat, 0xff, nfc->chip.ecc.size);
 +	memset(oob, 0xff, ???);  /* ??? */
 +	return ecc_count;

I don't think that UBI/UbiFs use the OOB data at all, but that is
something that I don't think is completely correct in this path?

> UBI starts to scrub & torture those 4 pages then, but starts doing
> this with other pages too. All the pages start to fail then! I'm still
> investigating that issue.

Arg.  I am not quite sure.  It seems ok to have a few 'stuck at one'
errors.  As you move closer to the ECC strength this seems a little
crazy.  At some point the sector/erase block is becoming useless.  I am
not sure if this is an issue with this device; it seems a little
suspect.  Maybe you could code something that emulates the stuck bits on
a good device and see if it still behaves the same; triggers a software
condition.  You might also reduce the NFC bus clock just to see on the
'stuck zero' device.

Hth,
Bill Pringlemeir.
