From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed, 17 Sep 2014 14:06:08 -0400
Subject: [RFC 2/5] mtd:fsl_nfc: Add hardware 45 byte BHC-ECC support for
 24 bit corrections.
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch>
Message-ID: <87r3zaxgtr.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 Sep 2014, stefan at agner.ch wrote:

> On one of our Colibri VF61 modules I discovered an issue using this
> driver:

> [    0.758327] ECC failed to correct all errors (ebd9fd80)
> [    0.767005] ECC failed to correct all errors (ebd9fd80)
> [    0.775525] ECC failed to correct all errors (ebd9fd80)
> [    0.784004] ECC failed to correct all errors (ebd9fd80)
> [    0.791938] UBI error: ubi_io_read: error -74 (ECC error) while
> reading 2048 bytes from PEB 28:2048, 
> read 2048 bytes

> That page supposed to be empty, and I got several of this messages.
> Hence I did not believe that they have really ECC errors, so I digged
> a bit deeper:

>>> -673,11 +673,13 @@ static int fsl_nfc_check_ecc_status(struct
> mtd_info *mtd, u_char *dat)
> return ecc_count;

> /* If 'ecc_count' zero or less then buffer is all 0xff or
> erased. */
> -       flip = count_written_bits(dat, chip->ecc.size, ecc_count);
> +       flip = count_written_bits(dat, chip->ecc.size, 100);

> if (flip > ecc_count) {
> -               printk("ECC failed to correct all errors (%08x)\n",
> ecc_status);
> +               printk("ECC failed to correct all errors (%08x, flips
> %d)\n",
> +                               ecc_status, flip);
> return -1;
> }

> [    0.758624] ECC failed to correct all errors (ebdded80, flips 1)
> [    0.768123] ECC failed to correct all errors (ebdded80, flips 1)
> [    0.777468] ECC failed to correct all errors (ebdded80, flips 1)
> [    0.786773] ECC failed to correct all errors (ebdded80, flips 1)
> [    0.795535] UBI error: ubi_io_read: error -74 (ECC error) while
> reading 2048 bytes from PEB 28:2048, read 2048 bytes

[snip]

> Interesting thought, the returned ecc_count is exactly one below the
> actual flipped bytes counted...
>
> One comment below regarding this...

[snip]

>> +
>> +	/* If 'ecc_count' zero or less then buffer is all 0xff or erased. */
>> +	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);

> Also, I could not find that the reference manual states that ecc_count
> represents the amount of flipped byte in a empty page. Is this given
> by the ECC algorithm?

I was using this information.

   Table 31-18. ECC Status Word Field Definition

   7            0 Page has been successfully corrected
   CORFAIL      1 Page is uncorrectable

   5?0          Number of errors that have been corrected in this page
   ERROR_COUNT

This is from the Vybrid RM, but the MPC5125RM has the same information.

I have definitely tested the detection of 'erased pages'.  However, I
don't know that I ever had actual bit flips.

The ECC controller has no idea whether the page is empty or not.  Are
you saying you have an erased page with bit flips?  I have definitely
not tested this.

>> +	/* If 'ecc_count' zero or less then buffer is all 0xff or erased. */
>> +	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);

There are two issues.

 1) erased page with some physical flipped bits (zero).
 2) erased page were controller flipped some bits.

Currently, the code is only handling case 2 (that is what the controller
counts).  I believe that your physical page has actual 'stuck at zero'
bits.  The current driver gives up.  If you want to handle this then we
should replace the lines,

> +	/* ECC failed. */
> +	if (flip > ecc_count)
> +		return -1;

With something like,

 +	/* Not completely empty. */
 +	if (flip > ecc_count) {
 +           re_read_page_w_ecc_off();
 +           if (count_written_bits() > strength) /* strength/2 ? */
 +		return -1;
 +      }

There is also a discussion on this here,

http://lists.infradead.org/pipermail/linux-mtd/2014-March/052507.html
http://lists.infradead.org/pipermail/linux-mtd/2014-March/052508.html
http://lists.infradead.org/pipermail/linux-mtd/2014-March/052509.html
http://lists.infradead.org/pipermail/linux-mtd/2014-March/052526.html
http://lists.infradead.org/pipermail/linux-mtd/2014-March/052527.html
http://lists.infradead.org/pipermail/linux-mtd/2014-March/052619.html
... etc.  Use the view thread.

Especially,
http://lists.infradead.org/pipermail/linux-mtd/2014-March/052647.html

Here Brian says that 3b applies to SLC NAND.  I guess this is you :).

It is fairly common to read an erased page.  Doing 'raw reads' all the
time on an erased page will slow the file system.  However, doing
re-reads for an erased page with bit flips is probably fairly uncommon.
A flash in this state maybe near EOL or the sector was bad from the
factory but not marked so.

I am chasing an DDR2 issue on another CPU and haven't had much more time
to the look at the Vybrid nor follow the MTD mailing list.  I don't know
if the 'NAND_ECC_NEED_CHECK_FF' feature has been merged?  It may also
solve the issue.

Regards,
Bill Pringlemeir.
