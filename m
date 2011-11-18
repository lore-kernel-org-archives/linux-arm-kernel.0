From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 18 Nov 2011 06:40:48 +0000
Subject: [alsa-devel] [PATCH v5 2/3] ARM: mx28evk: add platform data for
 saif
In-Reply-To: <201111180558.14836.marek.vasut@gmail.com>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
 <1321003855-13430-3-git-send-email-b29396@freescale.com>
 <201111180558.14836.marek.vasut@gmail.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E47DC@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Marek Vasut [mailto:marek.vasut at gmail.com]
> Sent: Friday, November 18, 2011 12:58 PM
> To: alsa-devel at alsa-project.org
> Cc: Dong Aisheng-B29396; linux-arm-kernel at lists.infradead.org;
> s.hauer at pengutronix.de; broonie at opensource.wolfsonmicro.com;
> w.sang at pengutronix.de; kernel at pengutronix.de; u.kleine-
> koenig at pengutronix.de; lrg at ti.com; Guo Shawn-R65073
> Subject: Re: [alsa-devel] [PATCH v5 2/3] ARM: mx28evk: add platform data
> for saif
> 
> > This is for supporting saif record function.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> >
> > ---
> > Changes since v4:
> >  * Using the new added master_id and master_mode in platfrom_data No
> > changes since v3:
> > Changes since v2:
> >  * separate clkmux code into another patch
> >  * A few minus fixes suggested by Uwe & Wolfram.
> > Changes since v1:
> >  * move saif clkmux code into mach-specific part
> > ---
> >  arch/arm/mach-mxs/devices-mx28.h                |    3 ++-
> >  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +++--
> >  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +++-
> >  arch/arm/mach-mxs/mach-mx28evk.c                |   18
> ++++++++++++++++--
> >  4 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/devices-mx28.h
> > b/arch/arm/mach-mxs/devices-mx28.h index c888710..4f50094 100644
> > --- a/arch/arm/mach-mxs/devices-mx28.h
> > +++ b/arch/arm/mach-mxs/devices-mx28.h
> > @@ -47,6 +47,7 @@ struct platform_device *__init mx28_add_mxsfb(
> >  		const struct mxsfb_platform_data *pdata);
> >
> >  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
> > -#define mx28_add_saif(id)
> mxs_add_saif(&mx28_saif_data[id])
> > +#define mx28_add_saif(id, pdata) \
> > +	mxs_add_saif(&mx28_saif_data[id], pdata)
> >
> >  struct platform_device *__init mx28_add_rtc_stmp3xxx(void); diff
> > --git a/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> > b/arch/arm/mach-mxs/devices/platform-mxs-saif.c index 1ec965e..f6e3a60
> > 100644
> > --- a/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> > +++ b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
> > @@ -32,7 +32,8 @@ const struct mxs_saif_data mx28_saif_data[]
> > __initconst = { };  #endif
> >
> > -struct platform_device *__init mxs_add_saif(const struct
> > mxs_saif_data
> > *data) +struct platform_device *__init mxs_add_saif(const struct
> > mxs_saif_data *data, +				const struct
> mxs_saif_platform_data *pdata)
> >  {
> >  	struct resource res[] = {
> >  		{
> > @@ -56,5 +57,5 @@ struct platform_device *__init mxs_add_saif(const
> > struct mxs_saif_data *data) };
> >
> >  	return mxs_add_platform_device("mxs-saif", data->id, res,
> > -					ARRAY_SIZE(res), NULL, 0);
> > +				ARRAY_SIZE(res), pdata, sizeof(*pdata));
> 
> Wasn't there some ARRAY_AND_SIZE() macro somewhere? I checked and it's
> now used in three instances -- PXA, MMP, UX500 and maybe somewhere else -
> - can you move it to common header and use here?
> 
Yes, could it be another patch since many place may need to update?
BTW, I also wonder why each platform defines this same micro respectively.
I mean that couldn't it be in the common code kernel.h as ARRAY_SIZE?
Anyway, that's another question and not much to do with this patch series.

> >  }
> > diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h
> > b/arch/arm/mach-mxs/include/mach/devices-common.h index
> > a8080f4..dc369c1
> > 100644
> > --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> > +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> > @@ -94,6 +94,7 @@ struct platform_device *__init mxs_add_mxs_pwm(
> >  		resource_size_t iobase, int id);
> >
> >  /* saif */
> > +#include <sound/saif.h>
> 
> It looks weird to intermix includes and code :-(
> 
I just follow the convention this file is using.

> >  struct mxs_saif_data {
> >  	int id;
> >  	resource_size_t iobase;
> > @@ -103,4 +104,5 @@ struct mxs_saif_data {  };
> >
> >  struct platform_device *__init mxs_add_saif(
> > -		const struct mxs_saif_data *data);
> > +		const struct mxs_saif_data *data,
> > +		const struct mxs_saif_platform_data *pdata);
> > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c
> > b/arch/arm/mach-mxs/mach-mx28evk.c index 4a3cca3..cfe7910 100644
> > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > @@ -28,6 +28,7 @@
> >
> >  #include <mach/common.h>
> >  #include <mach/iomux-mx28.h>
> > +#include <mach/digctl.h>
> >
> >  #include "devices-mx28.h"
> >
> > @@ -417,6 +418,18 @@ static void __init mx28evk_add_regulators(void)
> > static void __init mx28evk_add_regulators(void) {}  #endif
> >
> > +static const struct mxs_saif_platform_data
> > +			mx28evk_mxs_saif_pdata[] __initconst = {
> > +	/* working on EXTMSTR0 mode (saif0 master, saif1 slave) */
> > +	{
> > +		.master_mode = 1;
> > +		.master_id = 0;
> > +	}, {
> > +		.master_mode = 0;
> > +		.master_id = 0;
> > +	},
> > +};
> > +
> >  static void __init mx28evk_init(void)  {
> >  	int ret;
> > @@ -457,8 +470,9 @@ static void __init mx28evk_init(void)
> >
> >  	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
> >
> > -	mx28_add_saif(0);
> > -	mx28_add_saif(1);
> > +	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
> > +	mx28_add_saif(0, &mx28evk_mxs_saif_pdata[0]);
> > +	mx28_add_saif(1, &mx28evk_mxs_saif_pdata[1]);
> >
> >  	mx28_add_mxs_i2c(0);
> >  	i2c_register_board_info(0, mxs_i2c0_board_info,
> 
> Otherwise,
> 
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Thanks for the review.

Regards
Dong Aisheng
