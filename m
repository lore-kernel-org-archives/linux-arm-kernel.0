From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Thu, 11 Dec 2014 11:44:30 -0500
Subject: [RFC 2/5] mtd:fsl_nfc: Add hardware 45 byte BHC-ECC support for
 24 bit corrections.
In-Reply-To: <0bc8cec13bcf5b9cbea9cd3345815e4a@agner.ch> (Stefan Agner's
 message of "Wed, 10 Dec 2014 15:56:39 +0100")
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch> <87r3zaxgtr.fsf@nbsps.com>
 <c444059de888a661fadf3d6be598a98d@agner.ch> <87lhphyjkg.fsf@nbsps.com>
 <0bc8cec13bcf5b9cbea9cd3345815e4a@agner.ch>
Message-ID: <8761dit9u9.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>>> On 17 Sep 2014, stefan at agner.ch wrote:

>>> Yes, we are using Macronix SLC NAND.

>>>> On 17 Sep 2014, stefan at agner.ch wrote:

>>> This is a new device, but its one out of several dozens. The device
>>> had two factory marked bad page. This four page would then be 6 bad
>>> pages. I would say that your guess is probably the case at hand
>>> (should be considered bad, but were marked by factory).

On 10 Dec 2014, stefan at agner.ch wrote:

> What I currently did, is just accept strength / 2 bits. This is not a
> clean solution since it will also count the ECC bits, but it works for
> now:
> --- a/drivers/mtd/nand/fsl_nfc.c
> +++ b/drivers/mtd/nand/fsl_nfc.c
> @@ -524,7 +524,7 @@ static int nfc_correct_data(struct mtd_info *mtd,
> u_char *dat,
> flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
>
> /* ECC failed. */
> -       if (flip > ecc_count)
> +       if (flip > ecc_count && flip > (nfc->chip.ecc.strength / 2))
> return -1;
>
> /* Erased page. */

> I think we are facing multiple issues here. One might contain general
> software/hardware issues (non bit-flip related). I had this issue
> again on a different module with 3.18-rc5 (without the "fix"
> above). The kernel output looks like this:

[snip]

> Interesting is that this error happens every second PEB (every 128
> page, but erase block size is 64) and it is always the second page. On
> that device, this is completely reproduceable, e.g. I can erase
> everything and flash it again, the same happens.

> I dumped the block in question:

> Page 00240800 dump:
> ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> ....
> ff ff ff ff ff ff ff ff  f7 ff ff ff ff ff ff ff
> ....
> ff ff ff ff ff ff ff ff  ff ff fb ff ff ff ff ff
> ....
> ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff f7
> ....

> I also printed flip count and ecc_count the values for all those pages
> are: flip 3, ecc_count 2

> Now the interesting part: When I erase the block, and dump that page
> again, it is completely empty! No flips, no ecc_count anymore! UBI
> attach writes something into the first page, hence it looks like this
> write into the first page influences the values of the second
> page... I verified this behavior this using U-Boot and the Linux
> kernel.

> I digged a bit deeper, and wrote just zeros into the first page. In
> the second page some bits are flipped. However, writing into the
> second page does not influence the third page. But a bit in the first
> page is flipped. And the third page influences the forth page. It
> looks like the pages behave in pairs.... Any idea what kind of issue
> we are facing here?

Hmm.  It sounds like MLC flash, but you say you have SLC.  It could be
that some bus signalling is marginal?  Could you reduce the clocks a bit
on this device and see if the behaviour changes?  I am pretty sure that
stuck-at-zero errors will stay that way.

I would love to get back to this controller code to fix some issues you
noted and bring in the changes to the u-boot review.  Unfortunately, I
keep getting stuck with legacy hw issues.

fwiw,
Bill.
