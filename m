From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Apr 2011 15:51:52 +0200
Subject: [PATCH v5 1/4] ARM: add GPMI support for imx23/imx28
In-Reply-To: <20110413114304.GA1897@S2100-06.ap.freescale.net>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-2-git-send-email-b32955@freescale.com>
	<20110413114304.GA1897@S2100-06.ap.freescale.net>
Message-ID: <20110413135152.GS18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Apr 13, 2011 at 07:43:05PM +0800, Shawn Guo wrote:
> On Wed, Apr 13, 2011 at 02:24:38PM +0800, Huang Shijie wrote:
> > +	MX23_PAD_GPMI_D01__GPMI_D01 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_D02__GPMI_D02 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_D03__GPMI_D03 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_D04__GPMI_D04 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_D05__GPMI_D05 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_D06__GPMI_D06 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_D07__GPMI_D07 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_CLE__GPMI_CLE |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_ALE__GPMI_ALE |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_WPN__GPMI_WPN |
> > +		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_WRN__GPMI_WRN |
> > +		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_RDN__GPMI_RDN |
> > +		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_RDY0__GPMI_RDY0 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_RDY1__GPMI_RDY1 |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_CE0N__GPMI_CE0N |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +	MX23_PAD_GPMI_CE1N__GPMI_CE1N |
> > +		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > +
> 
> mmc (ssp) has pin conflict with gpmi on both mx23evk and mx28evk.
hmm,

	 $ git grep GPMI linus/master -- arch/arm/mach-mxs/mach-mx23evk.c
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D08__LCD_D18 | MXS
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D09__LCD_D19 | MXS
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D10__LCD_D20 | MXS
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D11__LCD_D21 | MXS
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D12__LCD_D22 | MXS
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D13__LCD_D23 | MXS
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D08__SSP1_DATA4 |
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D09__SSP1_DATA5 |
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D10__SSP1_DATA6 |
	linus/master:arch/arm/mach-mxs/mach-mx23evk.c:  MX23_PAD_GPMI_D11__SSP1_DATA7 |

so MX23_PAD_GPMI_D08 - MX23_PAD_GPMI_D13 is used (D08-D11 twice). So the
problem is already in linus/master. Is it that what you mean?

> How do you usually handle such pin conflicts on board?
I don't understand this question. Maybe: deciding which pad mux to use?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
