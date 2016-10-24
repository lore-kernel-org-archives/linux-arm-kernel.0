From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 24 Oct 2016 20:50:56 +0200
Subject: [PATCH v3 3/3] mtd: s3c2410: parse the device configuration
 from OF node
In-Reply-To: <20161024184738.GA26671@sprado-desktop>
References: <1476999766-32526-1-git-send-email-sergio.prado@e-labworks.com>
 <1476999766-32526-4-git-send-email-sergio.prado@e-labworks.com>
 <20161024150201.01952f67@bbrezillon>
 <20161024184738.GA26671@sprado-desktop>
Message-ID: <20161024205056.1782f76e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2016 16:47:38 -0200
Sergio Prado <sergio.prado@e-labworks.com> wrote:

> On Mon, Oct 24, 2016 at 03:02:01PM +0200, Boris Brezillon wrote:
> > > +static int s3c2410_nand_setup_data_interface(struct mtd_info *mtd,
> > > +					     const struct nand_data_interface *conf,
> > > +					     bool check_only)
> > > +{
> > > +	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
> > > +	struct s3c2410_platform_nand *pdata = info->platform;
> > > +	const struct nand_sdr_timings *timings;
> > > +	int tacls;
> > > +
> > > +	timings = nand_get_sdr_timings(conf);
> > > +	if (IS_ERR(timings))
> > > +		return -ENOTSUPP;
> > > +
> > > +	tacls = timings->tCLS_min - timings->tWP_min;
> > > +	if (tacls < 0)
> > > +		tacls = 0;
> > > +
> > > +	pdata->tacls  = DIV_ROUND_UP(tacls, 1000);
> > > +	pdata->twrph0 = DIV_ROUND_UP(timings->tWP_min, 1000);
> > > +	pdata->twrph1 = DIV_ROUND_UP(timings->tCLH_min, 1000);  
> > 
> > You seem to only apply the timings in s3c2410_nand_setrate(), which is
> > only called at probe time or on a cpufreq even, but the core can change
> > timings at runtime (this is what happens each time you reset the chip).
> > 
> > To support that you have 2 options:
> >  - apply the timings in ->select_chip()
> >  - apply the timings here  
> 
> Right. As far as I understood, ->setup_data_interface() will be called
> when MTD core change timings at runtime, so it is enough to apply the
> timings in the end of ->setup_data_interface()?

If your controller does not support interfacing with multiple chips,
then yes, it should work.
