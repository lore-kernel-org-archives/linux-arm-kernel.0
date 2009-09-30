From: rabin@rab.in (Rabin Vincent)
Date: Wed, 30 Sep 2009 15:37:44 +0530
Subject: Problem with mxc_nand driver
In-Reply-To: <a57e67db0909280241w61f8d8bbm88ff5d749cc946c2@mail.gmail.com>
References: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>
	<4AC0682D.6000907@eukrea.com>
	<a57e67db0909280156x686f0d26u397dc6397fd0b3a@mail.gmail.com>
	<4AC07FF9.2040002@eukrea.com>
	<a57e67db0909280241w61f8d8bbm88ff5d749cc946c2@mail.gmail.com>
Message-ID: <20090930100727.GA2365@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 11:41:39AM +0200, Jernej Turnsek wrote:
> after writing root fs image into nand partition, running the image and
> then checking the first empty block I've got following OOB data which
> is suspicious to me:
> 
> OOB:
> 	ff ff 85 19 03 20 ff ff
> 	ff 65 02 08 00 00 00 ff
> 	ff ff ff ff ff ff ff ff
> 	ff ff 03 ff ff ff ff ff
> 	ff ff ff ff ff ff ff ff
> 	ff ff 03 ff ff ff ff ff
> 	ff ff ff ff ff ff ff ff
> 	ff ff 03 ff ff ff ff ff
> 
> One can see that bytes on offset 2 to 5 are not empty and when using
> the smallpage_memorybased badblock_pattern byte 6 is not FF like it
> should be.
> 
> Anyone knows what is going on here?

85 19 03 20 08 00 00 00 is the JFFS2 cleanmarker; it's written to
indicate that the block is empty.  This is being stored in the OOB area
in the positions specified by oobfree in your ecclayout.

Your ecclayout has this:

static struct nand_ecclayout nand_hw_eccoob_64 = {
	.eccbytes = 20,
	.eccpos = {6, 7, 8, 9, 10, 22, 23, 24, 25, 26,
		   38, 39, 40, 41, 42, 54, 55, 56, 57, 58},
	.oobfree = {{2, 4}, {11, 10}, {27, 10}, {43, 10}, {59, 5}, }
};

The {2, 4} element in oobfree says that 4 bytes from position 2 (i.e,
positions 2, 3, 4, 5) are free to be used to store any OOB data.

If bad block information is supposed to be in position 5, that position
should not be included in oobfree.

Rabin
