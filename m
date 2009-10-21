From: gianlucarenzi@eptar.com (Gianluca Renzi)
Date: Wed, 21 Oct 2009 13:30:37 +0200
Subject: About the mxc nand driver
In-Reply-To: <20091020131157.GR8818@pengutronix.de>
References: <20091020131157.GR8818@pengutronix.de>
Message-ID: <200910211330.38141.gianlucarenzi@eptar.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 October 2009 15:11:58 Sascha Hauer wrote:
> Hi all,
>
> I frequently get reports about bugs in the Freescale mxc nand driver.
> Juergen Beisert and me invested some time to see what's going on in this
> driver, so here are some results.

The problem is caused by the fact the FreeScale's NAND Core Controller manages 
the 2K Largepage NAND as 4 SmallPage pages joined with their own ECC codes and 
badblock markers positions i.e. the smallpage badblock marker is located at 
6th byte of the oobpage data (offset 5) (repeated for each page).
To keep this NAND Controller fancy situation under kernel/mtd's control there 
are 2 ways:
1- Keep the location of the badblock marker at the first byte of oobpage data 
(offset 0) as mtd driver expects to be the badblock marker, but the mxc_nand 
driver MUST swap those locations *before* sending them to mtd.
2- Tell to mtd through its badblock descriptors to use 6th location (offset 5) 
as a badblock marker instead of the standard offset 0 (for each smallpage page 
area).
In the latter case, the hardware NAND Flash vendor MUST follow the same 
badblock marker layout (i.e.: Numonyx NAND02G-B2D 2-Gbit, 2112-byte/1056-word 
page, multiplane architecture, 1.8 V or 3 V, SLC NAND flash memories is using 
both locations as badblock marker (offset 0 and offset 5) of oobpage data)

In the first case we need to have a code like this to act the swap:
/*
 * This function does the trick of swapping the 464th byte in the last RAM
 * buffer in the main area with the 0th byte in the spare area. This seems
 * to be the optimal way of addressing the NFC imcompatibility problem with
 * the NAND flash out of factory in terms of BI field.
 * Note: this function only operates on the NFC's internal RAM buffers and
 * for 2K page only.
 */
static void mxc_swap_2k_bi_main_sp(void)
{
	u16 tmp1, tmp2, new_tmp1;
	tmp1 = BAD_BLK_MARKER_464;
	tmp2 = BAD_BLK_MARKER_SP_0;

	new_tmp1 = (tmp1 & 0xFF00) | (tmp2 >> 8);
	tmp2 = (tmp1 << 8) | (tmp2 & 0xFF);
	BAD_BLK_MARKER_464 = new_tmp1;
	BAD_BLK_MARKER_SP_0 = tmp2;
}
and you can use the standard layout of mtd.

We are using the second case, and to make it works we had to use the following 
ECCLayout as suggested by FreeScale using the HWECC:

/*
 * OOB placement block for use with hardware ecc generation
 */
static struct nand_ecclayout nand_hw_eccoob_8 = {
	.eccbytes = 5,
	.eccpos = {6, 7, 8, 9, 10},
	.oobfree = {{0, 5}, {11, 5}}
};

static struct nand_ecclayout nand_hw_eccoob_16 = {
	.eccbytes = 5,
	.eccpos = {6, 7, 8, 9, 10},
	.oobfree = {{0, 6}, {12, 4}}
};

static struct nand_ecclayout nand_hw_eccoob_2k = {
	.eccbytes = 20,
	.eccpos = {6, 7, 8, 9, 10, 22, 23, 24, 25, 26,
		   38, 39, 40, 41, 42, 54, 55, 56, 57, 58},
	.oobfree = {
		    {.offset = 0,
		     .length = 5},

		    {.offset = 11,
		     .length = 10},

		    {.offset = 27,
		     .length = 10},

		    {.offset = 43,
		     .length = 10},

		    {.offset = 59,
		     .length = 5}
		    }
};

We hope to see a common way to ensure this NAND Controller in the next kernel 
release, hopefully selected by a Kconfig entry (so to keep both cases valid).

Best regards,
-- 
           ,,,
          (o o)
======oOO==(_)==OOo======

Gianluca Renzi
R&D
phone: +39.0542.609120
fax: +39.0542.609212

      .oooO  Oooo.
======(   )==(   )=======
       \ (    ) /
        \_)  (_/
