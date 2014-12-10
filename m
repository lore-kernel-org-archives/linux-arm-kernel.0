From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Dec 2014 15:56:39 +0100
Subject: [RFC 2/5] =?UTF-8?Q?mtd=3Afsl=5Fnfc=3A=20Add=20hardware=20=34?=
 =?UTF-8?Q?=35=20byte=20BHC-ECC=20support=20for=20=32=34=20bit=20correctio?=
 =?UTF-8?Q?ns=2E?=
In-Reply-To: <87lhphyjkg.fsf@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch> <87r3zaxgtr.fsf@nbsps.com>
 <c444059de888a661fadf3d6be598a98d@agner.ch> <87lhphyjkg.fsf@nbsps.com>
Message-ID: <0bc8cec13bcf5b9cbea9cd3345815e4a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

On 2014-09-18 00:21, Bill Pringlemeir wrote:
> On 17 Sep 2014, stefan at agner.ch wrote:
> 
>> Am 2014-09-17 20:06, schrieb Bill Pringlemeir:
>>> On 17 Sep 2014, stefan at agner.ch wrote:
> 
>>>> On one of our Colibri VF61 modules I discovered an issue using this
>>>> driver:
> 
>>>> [    0.758327] ECC failed to correct all errors (ebd9fd80)
>>>> [    0.767005] ECC failed to correct all errors (ebd9fd80)
>>>> [    0.775525] ECC failed to correct all errors (ebd9fd80)
>>>> [    0.784004] ECC failed to correct all errors (ebd9fd80)
>>>> [    0.791938] UBI error: ubi_io_read: error -74 (ECC error) while
>>>> reading 2048 bytes from PEB 28:2048,
>>>> read 2048 bytes
> 
> [snip]
> 
>>>> Also, I could not find that the reference manual states that
>>>> ecc_count represents the amount of flipped byte in a empty page. Is
>>>> this given by the ECC algorithm?
> 
>>> I was using this information.
>>>
>>> Table 31-18. ECC Status Word Field Definition
>>>
>>> 7            0 Page has been successfully corrected
>>> CORFAIL      1 Page is uncorrectable
>>>
>>> 5?0          Number of errors that have been corrected in this page
>>> ERROR_COUNT
>>>
>>> This is from the Vybrid RM, but the MPC5125RM has the same
>>> information.
>>>
>>> I have definitely tested the detection of 'erased pages'.  However, I
>>> don't know that I ever had actual bit flips.
> 
>>> The ECC controller has no idea whether the page is empty or not.  Are
>>> you saying you have an erased page with bit flips?  I have definitely
>>> not tested this.
> 
>> Yes, that's what it looks like. Note that this output is on first boot
>> after flashing the device (with the UBI auto-grow option). I guess UBI
>> is reading all pages once to verify that they are empty.
> 
>>>>> + /* If 'ecc_count' zero or less then buffer is all 0xff or
>>>>> erased. */ + flip = count_written_bits(dat, nfc->chip.ecc.size,
>>>>> ecc_count);
>>>
>>> There are two issues.
>>>
>>> 1) erased page with some physical flipped bits (zero).
>>> 2) erased page were controller flipped some bits.
> 
>> I did not know that issue 2 exists. How can 2 happen on a erased page?
>> With a 'stuck at zero' in OOB?
> 
> Issue 2 is always an issue when reading an erased page with hardware
> ECC.  So we have,
> 
>                     Main         Spare
>     Good program:   Data    OOB-data+HW-ECC
>     Good erased:    FF      FF  FF
>     Stuck erased1:  FF      FF  xx
>     Stuck erased2:  xx      xx  FF
> 
> For the 'good erased' the controller goes about like it is case 'good
> program'.  It reads a sector (raw read or software ECC case) and a the
> same time, the error corrector is running.  This examines the 'OOB
> data', which is 0xff for the erased sector and it blindly begins to
> apply the error correction to the main data section.  The 'correction'
> for an erased block will always flip '1' to '0'.  So for 'good erased',
> the 'error_count' will equal the flipped bits.
> 
> Now, your sectors aren't that bad.  I believe you only have one bit
> error on an erase.  However, it is really hairy to know what the ECC
> logic will do when you have bit flips in the ECC code.  It is also next
> to impossible to examine the buffer and know if zero bits are due to the
> ECC engine flipping the bits and/or the actual physical flash having the
> stuck bit.  It appears that the ECC engine runs from start to finish.
> So most of the ECC corrections should be at the start; use this info for
> diagnostics, but not coding!

Two errors are at the beginning, one is almost at the end.

> The best course IMHO is to do what Brian (and other) did and do a 'raw'
> read, so you take the ECC engine out of the picture and stop it from
> flipping bits.  You can experiment with always doing the raw read, but I
> believe you will see a decrease in performance (as others mentioned and
> I saw).
> 

Hm, we currently don't have a non ECC read function as we enable ECC
unconditionally. I guess this would need a read_oob_raw implementation,
where we disable ECC, read the page, and reenable ECC...

>>> Currently, the code is only handling case 2 (that is what the
>>> controller counts).  I believe that your physical page has actual
>>> 'stuck at zero' bits.  The current driver gives up.  If you want to
>>> handle this then we should replace the lines,
> 
>> I assumed that your code assumes that the controller returns the
>> flipped bit count when reading an erase page (case 1), which I did not
>> found in the documentation.
> 
>>>> +	/* ECC failed. */
>>>> +	if (flip > ecc_count)
>>>> +		return -1;
> 
>>> With something like,
>>>
>>> +	/* Not completely empty. */
>>> +	if (flip > ecc_count) {
>>> +           re_read_page_w_ecc_off();
>>> +           if (count_written_bits() > strength) /* strength/2 ? */
>>> +		return -1;
>>> +      }
>>>
>>> There is also a discussion on this here,
>>>
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052507.html
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052508.html
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052509.html
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052526.html
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052527.html
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052619.html
>>> ... etc.  Use the view thread.
>>>
>>> Especially,
>>> http://lists.infradead.org/pipermail/linux-mtd/2014-March/052647.html
>>>
>>> Here Brian says that 3b applies to SLC NAND.  I guess this is you :).
> 
>> Yes, we are using Macronix SLC NAND.
> 
> Well, it is everyone.  Sorry, I made the assumption this wouldn't
> happen, but apparently it does.
> 
>>> It is fairly common to read an erased page.  Doing 'raw reads' all
>>> the time on an erased page will slow the file system.  However, doing
>>> re-reads for an erased page with bit flips is probably fairly
>>> uncommon.  A flash in this state maybe near EOL or the sector was bad
>>> from the factory but not marked so.
> 
>> This is a new device, but its one out of several dozens. The device
>> had two factory marked bad page. This four page would then be 6 bad
>> pages. I would say that your guess is probably the case at hand
>> (should be considered bad, but were marked by factory).
> 
>>> I am chasing an DDR2 issue on another CPU and haven't had much more
>>> time to the look at the Vybrid nor follow the MTD mailing list.  I
>>> don't know if the 'NAND_ECC_NEED_CHECK_FF' feature has been merged?
>>> It may also solve the issue.
>>
>> A quick search through 3.17-rc3 didn't found that string.
> 
>> I will read the pages using raw again and check how many bit flips it
>> shows. But I guess regarding Brian's comment to 3b, the driver
>> actually behaves correct and return -1, because we have bit flips on
>> erased page which is not good...
> 
> Hmm.  No, it should be ok; I think Brian meant we should accept and
> expect this.  We had this conversation after the RFC.  However, we
> should probably only accept strength/2 zero values at most; I believe
> what to accept was kind of hanging in that conversation.  If the zeros
> are below our threshold with a raw read, then we can report the page is
> all '\xff' and return a 'bit flip' count as the number of zeros found in
> a raw read.  Also, in the 'all FFs' case we should probably memset the
> OOB data.  I see that other patches mentioned in the MTD threads above
> do this.
> 
>  +	/* Not completely empty. */
>  +	if (flip > ecc_count) {
>  +           re_read_page_w_ecc_off();
>  +           ecc_count = count_zero_bits();
>  +           if (ecc_count > strength/2)
>  +		return -1;
>  +      } else
>  +          ecc_count = 0;  /* 'normal' case all ff */
>  +
>  +	/* Erased page. */
>  +	memset(dat, 0xff, nfc->chip.ecc.size);
>  +	memset(oob, 0xff, ???);  /* ??? */
>  +	return ecc_count;
> 

What I currently did, is just accept strength / 2 bits. This is not a
clean solution since it will also count the ECC bits, but it works for
now:
--- a/drivers/mtd/nand/fsl_nfc.c
+++ b/drivers/mtd/nand/fsl_nfc.c
@@ -524,7 +524,7 @@ static int nfc_correct_data(struct mtd_info *mtd,
u_char *dat,
        flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
 
        /* ECC failed. */
-       if (flip > ecc_count)
+       if (flip > ecc_count && flip > (nfc->chip.ecc.strength / 2))
                return -1;
 
        /* Erased page. */



> I don't think that UBI/UbiFs use the OOB data at all, but that is
> something that I don't think is completely correct in this path?
> 
>> UBI starts to scrub & torture those 4 pages then, but starts doing
>> this with other pages too. All the pages start to fail then! I'm still
>> investigating that issue.
> 
> Arg.  I am not quite sure.  It seems ok to have a few 'stuck at one'
> errors.  As you move closer to the ECC strength this seems a little
> crazy.  At some point the sector/erase block is becoming useless.  I am
> not sure if this is an issue with this device; it seems a little
> suspect.  Maybe you could code something that emulates the stuck bits on
> a good device and see if it still behaves the same; triggers a software
> condition.  You might also reduce the NFC bus clock just to see on the
> 'stuck zero' device.
> 

I think we are facing multiple issues here. One might contain general
software/hardware issues (non bit-flip related). I had this issue again
on a different module with 3.18-rc5 (without the "fix" above). The
kernel output looks like this:

[    1.744672] UBI: default fastmap pool size: 200
[    1.752573] UBI: default fastmap WL pool size: 25
[    1.760577] UBI: attaching mtd3 to ubi0
[    1.769093] UBI warning: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 0:2048, read only 2048 bytes, retry
[    1.787579] UBI warning: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 0:2048, read only 2048 bytes, retry
[    1.806383] UBI warning: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 0:2048, read only 2048 bytes, retry
[    1.825649] UBI error: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 0:2048, read 2048 bytes
[    1.843804] CPU: 0 PID: 1 Comm: swapper Not tainted
3.18.0-rc5-00136-g0d91606-dirty #1607
[    1.860148] Backtrace:
[    1.866779] [<80011a04>] (dump_backtrace) from [<80011ce0>]
(show_stack+0x18/0x1c)
[    1.883061]  r6:00000000 r5:00000800 r4:ffffffb6 r3:00000000
[    1.893395] [<80011cc8>] (show_stack) from [<805a5018>]
(dump_stack+0x24/0x28)
[    1.909684] [<805a4ff4>] (dump_stack) from [<8034e9ac>]
(ubi_io_read+0x130/0x300)
[    1.926615] [<8034e87c>] (ubi_io_read) from [<8034efac>]
(ubi_io_read_vid_hdr+0x50/0x220)
[    1.944255]  r10:00000000 r9:00000000 r8:8ea4c000 r7:00000000
r6:8eaa3000 r5:00000000
[    1.961788]  r4:8ea4c000
[    1.969163] [<8034ef5c>] (ubi_io_read_vid_hdr) from [<803539ec>]
(scan_peb.part.9+0x128/0x6a4)
[    1.987614]  r10:00000000 r9:8e843dec r8:8ea4c000 r7:00000000
r6:8ead2900 r5:00000000
[    2.005493]  r4:80847a4c
[    2.012847] [<803538c4>] (scan_peb.part.9) from [<80354ed4>]
(ubi_attach+0x13c/0x398)
[    2.030220]  r10:ffffffff r9:80847a4c r8:ffffffff r7:7ffff000
r6:8ead2900 r5:8ea4c000
[    2.047761]  r4:00000000
[    2.054949] [<80354d98>] (ubi_attach) from [<80349504>]
(ubi_attach_mtd_dev+0x6a8/0xd00)
[    2.072405]  r10:00000050 r9:8ea13c00 r8:000007ff r7:8ea4c000
r6:00000000 r5:8ea13c00
[    2.089965]  r4:00000990
[    2.097179] [<80348e5c>] (ubi_attach_mtd_dev) from [<807933f0>]
(ubi_init+0x214/0x2b8)
[    2.114458]  r10:00000000 r9:8ead9200 r8:807785e8 r7:8ea13c00
r6:807a9700 r5:00000000
[    2.131856]  r4:807a9704
[    2.138962] [<807931dc>] (ubi_init) from [<80008770>]
(do_one_initcall+0x94/0x1d4)
[    2.155573]  r8:807785e8 r7:8e842038 r6:807931dc r5:807b9460
r4:807b9460
[    2.167084] [<800086dc>] (do_one_initcall) from [<80778e38>]
(kernel_init_freeable+0x130/0x1d0)
[    2.185090]  r10:807a44b0 r9:807a44a8 r8:807785e8 r7:807f4b80
r6:807f4b80 r5:00000007
[    2.202418]  r4:807ad4d8
[    2.209488] [<80778d08>] (kernel_init_freeable) from [<805a1b64>]
(kernel_init+0x10/0xf0)
[    2.226946]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:805a1b54
[    2.244265]  r4:00000000
[    2.251337] [<805a1b54>] (kernel_init) from [<8000e638>]
(ret_from_fork+0x14/0x3c)
[    2.268179]  r4:00000000 r3:8e842000
[    2.297506] UBI warning: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 2:2048, read only 2048 bytes, retry
[    2.318557] UBI warning: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 2:2048, read only 2048 bytes, retry
[    2.340077] UBI warning: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 2:2048, read only 2048 bytes, retry
[    2.361438] UBI error: ubi_io_read: error -74 (ECC error) while
reading 2048 bytes from PEB 2:2048, read 2048 bytes
[    2.381479] CPU: 0 PID: 1 Comm: swapper Not tainted
3.18.0-rc5-00136-g0d91606-dirty #1607

Interesting is that this error happens every second PEB (every 128 page,
but erase block size is 64) and it is always the second page. On that
device, this is completely reproduceable, e.g. I can erase everything
and flash it again, the same happens. 


I dumped the block in question:

Page 00240800 dump:
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  f7 ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff fb ff ff ff ff ff
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
....
        ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff f7
....

I also printed flip count and ecc_count the values for all those pages
are: flip 3, ecc_count 2

Now the interesting part: When I erase the block, and dump that page
again, it is completely empty! No flips, no ecc_count anymore! UBI
attach writes something into the first page, hence it looks like this
write into the first page influences the values of the second page... I
verified this behavior this using U-Boot and the Linux kernel.

I digged a bit deeper, and wrote just zeros into the first page. In the
second page some bits are flipped. However, writing into the second page
does not influence the third page. But a bit in the first page is
flipped. And the third page influences the forth page. It looks like the
pages behave in pairs.... Any idea what kind of issue we are facing
here?

--
Stefan
