From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 27 Aug 2015 09:34:21 -0700
Subject: [PATCH v10 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <bf1ed158fe08b51c4668faffde44083f@agner.ch>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-2-git-send-email-stefan@agner.ch>
 <20150825201631.GK81844@google.com>
 <bf1ed158fe08b51c4668faffde44083f@agner.ch>
Message-ID: <20150827163421.GX81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 06:02:31PM -0700, Stefan Agner wrote:
> On 2015-08-25 13:16, Brian Norris wrote:
> > On Mon, Aug 03, 2015 at 11:27:26AM +0200, Stefan Agner wrote:
> >> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> >> new file mode 100644
> >> index 0000000..5c8dfe8
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/vf610_nfc.c
> >> @@ -0,0 +1,645 @@
> > 
> > ...
> > 
> >> +/*
> >> + * This function supports Vybrid only (MPC5125 would have full RB and four CS)
> >> + */
> >> +static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
> >> +{
> >> +#ifdef CONFIG_SOC_VF610
> > 
> > Why the #ifdef? I don't see anything compile-time specific to SOC_VF610.
> > 
> > If this is trying to handle the comment above ("This function supports
> > Vybrid only (MPC5125 would have full RB and four CS)") then that's the
> > wrong way of doing it, as you need to support multiplatform kernels.
> > You'll need to have a way to differentiate the different platform
> > support at runtime, not compile time.
> 
> Yes it is trying to handle the comment above. Well, the other two
> platforms I am aware of are also different architectures... (PowerPC and
> ColdFire). I think we won't have a multi-architecture kernel anytime
> soon,

Ha, right. Sorry, I don't really know this particular IP.

> hence I think removing the code at compile time is the right thing
> todo.

I don't believe that conclusion follows though.

> However, probably CONFIG_SOC_VF610 is the wrong symbol then, I could
> just use CONFIG_ARM and add a comment that this might be different on
> another other ARM SoC than VF610.
> 
> Just checked CodingStyle, and I see that IS_ENABLED is the preferred way
> for conditional compiling.
> 
> So my suggestion:
> 
> static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
> {
> 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> 	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
> 
> 	if (!IS_ENABLED(CONFIG_ARM))
> 		return;
> 
> 	/*
> 	 * This code is only tested on the ARM platform VF610
> 	 * PowerPC based MPC5125 would have full RB and four CS
> 	 */
> ....
> 
> With that the compiler should be able to remove this (currently) ARM
> VF610 specific code on the other supported architectures...
> 
> What do you think?

The code structure isn't bad, and yes, IS_ENABLED() would be preferable,
as it removes some of the problems with #ifdef, but I still don't think
the processor architecture has much to do with the version of the IP.
The canonical way of distiguishing per-IP revisions is to key on the
compatible property. So you'd have some kind of enum, which would
currently only have an entry for VF610. i.e.:

	/* MPC5125 not yet supported */
	if (nfc->revision != NAND_VFC610)
		return;

> >> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> >> +	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
> >> +
> >> +	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
> >> +	tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
> >> +
> >> +	if (chip == 0)
> >> +		tmp |= 1 << ROW_ADDR_CHIP_SEL_SHIFT;
> >> +	else if (chip == 1)
> >> +		tmp |= 2 << ROW_ADDR_CHIP_SEL_SHIFT;
> > 
> > 	else ... ?
> > 
> > Maybe you can write this as a formulaic pattern (e.g.:
> > 
> > 	tmp |= (chip + 1) << ROW_ADDR_CHIP_SEL_SHIFT;
> > 
> > ) and just do the "max # of chips" checks on a per-platform basis in the
> > probe(). Then I'm guessing this same function can apply to both
> > platforms. (I'm not looking at HW datasheets for this, BTW, just
> > guessing based on the context here.)
> 
> It seems that MCP5125 is different than VF610. MCP5125 has 4 chip
> selects and 4 R/B signals, whereas VF610 has only 2 chip selects and
> just 1 R/B signals...

OK I don't presume to know what the different IP versions look like. And
if you just note they are unsupported/untested, you're fine.

Brian
