From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 12 Jun 2012 08:40:08 +0000
Subject: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
In-Reply-To: <4FD66666.8060002@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
 <4FD66666.8060002@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 03:13:02, Hunter, Jon wrote:

> > +static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
> > +{
> > +	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> 
> Why is it necessary to read the register first? I thought you wanted to
> get away from relying on bootloader settings?

This is not trying to depend on bootloader, it is to alter bits
that are only meant for configuration. There are other bits in 
the same register configured as part of time setting.

> 
> > +	l &= ~(GPMC_CONFIG1_MUXADDDATA |
> > +		GPMC_CONFIG1_WRITETYPE_SYNC |
> > +		GPMC_CONFIG1_WRITEMULTIPLE_SUPP |
> > +		GPMC_CONFIG1_READTYPE_SYNC |
> > +		GPMC_CONFIG1_READMULTIPLE_SUPP |
> > +		GPMC_CONFIG1_WRAPBURST_SUPP |
> > +		GPMC_CONFIG1_DEVICETYPE(~0) |
> > +		GPMC_CONFIG1_DEVICESIZE(~0) |
> > +		GPMC_CONFIG1_PAGE_LEN(~0));
> > +
> > +	l |= conf & GPMC_CONFIG1_DEVICETYPE_NAND;
> > +	l |= conf & GPMC_CONFIG1_DEVICESIZE_16;
> 
> I can see that it works to use the above definitions as masks because of
> the possible values that can be programmed into these fields. However,
> from a read-ability standpoint this is unclear and requires people to
> review the documentation to understand what you are doing here.
> Furthermore, if any new device-types or sizes were added in the future
> this could lead to bugs. Hence, it would be better to define a mask for
> these fields.

I had thought about it initially, but then it was felt it will
lead to a less simple code, that path was not taken, let me
revisit this.

Regards
Afzal
