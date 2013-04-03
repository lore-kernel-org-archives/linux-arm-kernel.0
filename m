From: pavel@denx.de (Pavel Machek)
Date: Wed, 3 Apr 2013 22:32:35 +0200
Subject: [PATCHv2 1/2] ARM: socfpga: Enable soft reset
In-Reply-To: <20130403185232.GA11360@quad.lixom.net>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <20130320152915.GA32083@amd.pavel.ucw.cz>
 <20130403185232.GA11360@quad.lixom.net>
Message-ID: <20130403203234.GA7643@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +struct socfpga_rstmgr_hw {
> > +	u32 unk;
> > +	u32 ctrl;		/* 0x04 */
> > +	u32 unk2, unk3;
> > +/* MPU Module Reset Register */
> > +#define RSTMGR_MPUMODRST_CPU0	0x1	/* CPU0 Reset */
> > +#define RSTMGR_MPUMODRST_CPU1	0x2	/* CPU1 Reset */
> > +#define RSTMGR_MPUMODRST_WDS	0x4	/* Watchdog Reset */
> > +#define RSTMGR_MPUMODRST_SCUPER	0x8	/* SCU and periphs reset */
> > +#define RSTMGR_MPUMODRST_L2	0x10	/* L2 Cache reset */
> > +	u32 mpumodrst; 		/* 0x10 */
> > +	u32 modperrst;		/* 0x14 */
> > +	u32 unk5;
> > +	u32 bgrmodrst;		/* 0x1c */
> > +};
> 
> As Russell already replied, struct used to represent register layout is
> normally frowned upon in drivers.

Well... as Russell also said, this is arch-specific code, so it is
actually ok.

> If you want to tighten up the code in this case, make a local helper
> function that just takes the register offset instead, i.e.:
> 
> > -	temp = __raw_readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
> > +	temp = readl(&rst_manager_base_addr->ctrl);
> 
> 	temp = rst_readl(SOCFPGA_RSTMGR_CTRL);
> 
> (and then have rst_readl/rst_writel do the math based on base
> address).

That does not prevent mistake such as
rst_readl(SOCFPGA_SYSMGR_CTRL)... and with number of different
subsystems on socfpga (each with separate base address), I fear that
might be an issue.

Unfortunately, C does not check type of enums, so they can't be used
to solve that.

Any other ideas?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
