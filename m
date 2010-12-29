From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 13:45:06 +0100
Subject: [PATCH 09/10] ARM: mx28: read fec mac address from ocotp
In-Reply-To: <20101229121354.GJ19347@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-10-git-send-email-shawn.guo@freescale.com>
	<20101229105328.GX14221@pengutronix.de>
	<20101229121354.GJ19347@freescale.com>
Message-ID: <20101229124506.GE14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 29, 2010 at 08:13:55PM +0800, Shawn Guo wrote:
> On Wed, Dec 29, 2010 at 11:53:28AM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Dec 28, 2010 at 10:55:54PM +0800, Shawn Guo wrote:
> > > Read fec mac address from ocotp and save it into fec_platform_data
> > > mac field for fec driver to use.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > >  arch/arm/mach-mxs/devices/platform-fec.c        |    2 +-
> > >  arch/arm/mach-mxs/include/mach/devices-common.h |    2 +-
> > >  arch/arm/mach-mxs/mach-mx28evk.c                |   31 +++++++++++++++++++++++
> > >  3 files changed, 33 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-mxs/devices/platform-fec.c b/arch/arm/mach-mxs/devices/platform-fec.c
> > > index c08168c..dc978ee 100644
> > > --- a/arch/arm/mach-mxs/devices/platform-fec.c
> > > +++ b/arch/arm/mach-mxs/devices/platform-fec.c
> > > @@ -31,7 +31,7 @@ const struct mxs_fec_data mx28_fec_data[] __initconst = {
> > >  
> > >  struct platform_device *__init mxs_add_fec(
> > >  		const struct mxs_fec_data *data,
> > > -		const struct fec_platform_data *pdata)
> > > +		struct fec_platform_data *pdata)
> > >  {
> > >  	struct resource res[] = {
> > >  		{
> > > diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> > > index fca0551..d206e0a 100644
> > > --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> > > +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> > > @@ -38,4 +38,4 @@ struct mxs_fec_data {
> > >  };
> > >  struct platform_device *__init mxs_add_fec(
> > >  		const struct mxs_fec_data *data,
> > > -		const struct fec_platform_data *pdata);
> > > +		struct fec_platform_data *pdata);
> > Why that?
> > 
> pdata->mac needs to get assigned by ocotp read function.
... which is done before mxs_add_fec is called.

> > > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> > > index def6519..d133733 100644
> > > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > > @@ -129,6 +129,36 @@ static struct fec_platform_data mx28_fec_pdata[] = {
> > >  	},
> > >  };
> > >  
> > > +static int __init mx28evk_fec_get_mac(void)
> > > +{
> > > +	int i, ret;
> > > +	u32 val;
> > > +
> > > +	/*
> > > +	 * OCOTP only stores the last 4 octets for each mac address,
> > > +	 * so hard-coding the first two octets as Freescale OUI (00:04:9f)
> > > +	 * is needed.
> > > +	 */
> > > +	for (i = 0; i < 2; i++) {
> > > +		ret = mxs_read_ocotp(0x20 + i * 0x10, 1, &val);
> > > +		if (ret)
> > > +			goto error;
> > > +
> > > +		mx28_fec_pdata[i].mac[0] = 0x00;
> > > +		mx28_fec_pdata[i].mac[1] = 0x04;
> > > +		mx28_fec_pdata[i].mac[2] = (val >> 24) & 0xff;
> > > +		mx28_fec_pdata[i].mac[3] = (val >> 16) & 0xff;
> > > +		mx28_fec_pdata[i].mac[4] = (val >> 8) & 0xff;
> > > +		mx28_fec_pdata[i].mac[5] = (val >> 0) & 0xff;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +error:
> > > +	pr_err("%s: timeout when reading fec mac from OCOTP\n", __func__);
> > > +	return -ETIMEDOUT;
> > return ret please.
> > 
> OK.
> 
> > > +}
> > I think this should be defined in a more generic place.
> > 
> Necessary?
I just rechecked with the reference manual and it's not documented that
0x20 and 0x30 are used to hold the mac address.  Then it's probably OK
to keep this function machine-local.

> > > +
> > >  static void __init mx28evk_init(void)
> > >  {
> > >  	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
> > > @@ -136,6 +166,7 @@ static void __init mx28evk_init(void)
> > >  	mx28_add_duart();
> > >  
> > >  	mx28evk_fec_reset();
> > > +	mx28evk_fec_get_mac();
> > You ignore the return value here.  Intended?
> > 
> Not intended.  Will check and give a warning.
> 
> > >  	mx28_add_fec(0, &mx28_fec_pdata[0]);
... and maybe skip the call to add_fec?  Up to you.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
