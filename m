From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 31 May 2012 11:03:14 +0200
Subject: [PATCH 2/2] MFD: mc13xxx workaround SPI hardware bug on i.Mx
In-Reply-To: <2358422.efTs8lXp1l@laptop>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-3-git-send-email-philippe.retornaz@epfl.ch>
 <20120530170837.GR9947@opensource.wolfsonmicro.com>
 <2358422.efTs8lXp1l@laptop>
Message-ID: <20120531090314.GB4394@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Thu, May 31, 2012 at 09:08:39AM +0200, Philippe R?tornaz wrote:
> Le mercredi 30 mai 2012 18:08:38 Mark Brown a ?crit :
> > On Tue, May 29, 2012 at 11:06:29AM +0200, Philippe R?tornaz wrote:
> > > The MC13xxx PMIC is mainly used on i.Mx SoC. On thoses SoC the SPI
> > > hardware will deassert CS line as soon as the SPI FIFO is empty.
> > > The MC13xxx hardware is very sensitive to CS line change as it
> > > corrupts the transfert if CS is deasserted in the middle of a register
> > > read or write.
> > > It is not possible to use the CS line as a GPIO on some SoC, so we
> > > need to workaround this by implementing a single SPI transfer to
> > > access the PMIC.
> > 
> > Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > 
> > though it's really sad this can't be done in the SPI controller where
> > the bug is.  You should also set use_single_rw in the regmap_config,
> > though this is less critical as currently the core won't automatically
> > generate any bulk I/O.
> 
> I already put it in struct regmap_config, should I put it elsewhere ? 
> 
> @@ -54,6 +54,67 @@ static struct regmap_config mc13xxx_regmap_spi_config = {
>         .max_register = MC13XXX_NUMREGS,
>  
>         .cache_type = REGCACHE_NONE,
> +       .use_single_rw = 1,
> +};
> 
> BTW, who will merge this patchset ? 
I will.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
