From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 29 Apr 2014 12:36:40 -0400
Subject: [RFC 1/5] mtd:fsl_nfc: Nand flash controller for VF610, MPC5125,
 etc.
In-Reply-To: <708e6f84e177e1d02310358688b44c53@agner.ch> (Stefan Agner's
 message of "Mon, 28 Apr 2014 16:41:48 +0200")
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-2-git-send-email-bpringlemeir@nbsps.com>
 <708e6f84e177e1d02310358688b44c53@agner.ch>
Message-ID: <87tx9c5bzb.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 Apr 2014, stefan at agner.ch wrote:

> The driver works fine for me using 3.14 on Colibri VF61 (8-Bit bus
> width, Samsung NAND, 2k page size). Also tested with the Hardware ECC.
> Do you plan to send an update patch of the driver?

> FYI, I ported the driver to U-Boot and will send a patch to the U-Boot
> mailing list soon.

> Some minor comments below:

> Am 2014-01-09 00:07, schrieb Bill Pringlemeir:
> <snip>
>> +static u8 bbt_pattern[] = {'B', 'b', 't', '0' }; +static u8
>> mirror_pattern[] = {'1', 't', 'b', 'B' }; + +static struct
>> nand_bbt_descr bbt_main_descr = { + .options = NAND_BBT_LASTBLOCK |
>> NAND_BBT_CREATE | NAND_BBT_WRITE | + NAND_BBT_2BIT |
>> NAND_BBT_VERSION, + .offs = 11, + .len = 4, + .veroffs = 15, +
>> .maxblocks = 4, + .pattern = bbt_pattern, +}; + +static struct
>> nand_bbt_descr bbt_mirror_descr = { + .options = NAND_BBT_LASTBLOCK |
>> NAND_BBT_CREATE | NAND_BBT_WRITE | + NAND_BBT_2BIT |
>> NAND_BBT_VERSION, + .offs = 11, + .len = 4, + .veroffs = 15, +
>> .maxblocks = 4, + .pattern = mirror_pattern, +};

> This is the same BBT descriptor as used on Timesys Vybrid BSP. Other
> than this "backward compatibility", is there another reason to use non
> default BBT descriptor? As far as I can tell, the ECC does not
> conflict with the default BBT description.

Beyond the "TimeSys", there are OpenWRT projects and others that seem to
use this BBT structure.  Myself, I don't care.  The question would be
will someone ever get to use this driver with some other system?  It is
simple enough to patch the driver; although a device tree binding
supported by the driver might be more flexible to allow both from
multi-machine builds.  This particular chip is not really a candidate as
it always seems to be used with a different architecture; PowerPC,
ColdFire/68k, ARM Cortex-A or Cortex-M.

>> +/* Write data to NFC buffers */ 
>> +static void nfc_write_buf(struct mtd_info *mtd, const u_char *buf,
>> int len)
>> +{
> ...  IMHO this type of commands are not really required, the function
> name is descriptive enough.

The comments are from the original.

https://github.com/Timesys/linux-timesys/blob/3.0-mvf/drivers/mtd/nand/fsl_nfc.c#L170

I agree they are not needed.

>> +/* Vybrid only.  MPC5125 has full RB and four CS. Assume boot loader
>> + * has set this register for now.
>> + */

> Multi-line comment style (there are some malformed multi-line comments
> in the ECC patch as well)

This is my comment.  I must of missed the advice on multi-line comments.
I did all sorts of strange things with test emails, building with
different git trees, running different scripts, re-ordering the patches
to try and make them understandable, testing different variants,
benchmarking, etc.  White space is not a riveting issue for me.  I just
cribbed some emacs code and hope it works.

   (defun linux-c-mode ()
     "C mode with adjusted defaults for use with the Linux kernel."
     (interactive)
     (c-mode)
     (c-set-style "K&R")
     (setq tab-width 8)
     (setq indent-tabs-mode t)
     (setq truncate-lines t)
     (setq show-trailing-whitespace t)
     (setq c-basic-offset 8))

I looked again, you mean that I should have the first "star" line blank
or is there more?

There are other issues, like Shawn Guo's IMX tree has a better structure
for the IOMUX bindings.  I am also concerned that people don't like the
order of the patches and I have to fsck with git to re-arrange them
(again).  However, I think that having the MTD people willing to accept
is my major hurdle on working on it further.  I don't know if they want
yet another controller?  I am glad that you can use it too and have
tested it with 8-bit flash.

Thanks,
Bill Pringlemeir.
