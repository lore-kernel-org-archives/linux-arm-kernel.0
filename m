From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 21 Feb 2017 09:13:40 +0100
Subject: [RESEND PATCH 2/3] mtd: nand: atmel: Add
 ->setup_data_interface() hooks
In-Reply-To: <4db51424-0e59-bad7-45ff-92516424dead@gmail.com>
References: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487625149-7234-3-git-send-email-boris.brezillon@free-electrons.com>
 <4db51424-0e59-bad7-45ff-92516424dead@gmail.com>
Message-ID: <20170221091340.2d6d3fdf@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Feb 2017 23:47:10 +0100
Marek Vasut <marek.vasut@gmail.com> wrote:

> On 02/20/2017 10:12 PM, Boris Brezillon wrote:
> > The NAND controller IP can adapt the NAND controller timings dynamically.
> > Implement the ->setup_data_interface() hook to support this feature.
> > 
> > Note that it's not supported on at91rm9200 because this SoC has a
> > completely different SMC block, which is not supported yet.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/nand/atmel/nand-controller.c | 333 ++++++++++++++++++++++++++++++-
> >  1 file changed, 328 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> > index 4207c0d37826..ae46ef711d67 100644
> > --- a/drivers/mtd/nand/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/atmel/nand-controller.c
> > @@ -57,6 +57,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/mfd/syscon/atmel-matrix.h>
> > +#include <linux/mfd/syscon/atmel-smc.h>
> >  #include <linux/module.h>
> >  #include <linux/mtd/nand.h>
> >  #include <linux/of_address.h>
> > @@ -147,6 +148,8 @@ struct atmel_nand_cs {
> >  		void __iomem *virt;
> >  		dma_addr_t dma;
> >  	} io;
> > +
> > +	struct atmel_smc_cs_conf smcconf;
> >  };
> >  
> >  struct atmel_nand {
> > @@ -190,6 +193,8 @@ struct atmel_nand_controller_ops {
> >  	void (*nand_init)(struct atmel_nand_controller *nc,
> >  			  struct atmel_nand *nand);
> >  	int (*ecc_init)(struct atmel_nand *nand);
> > +	int (*setup_data_interface)(struct atmel_nand *nand, int csline,
> > +				    const struct nand_data_interface *conf);
> >  };
> >  
> >  struct atmel_nand_controller_caps {
> > @@ -1144,6 +1149,293 @@ static int atmel_hsmc_nand_ecc_init(struct atmel_nand *nand)
> >  	return 0;
> >  }
> >  
> > +static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
> > +					const struct nand_data_interface *conf,
> > +					struct atmel_smc_cs_conf *smcconf)
> > +{
> > +	u32 ncycles, totalcycles, timeps, mckperiodps;
> > +	struct atmel_nand_controller *nc;
> > +	int ret;
> > +
> > +	nc = to_nand_controller(nand->base.controller);
> > +
> > +	/* DDR interface not supported. */
> > +	if (conf->type != NAND_SDR_IFACE)
> > +		return -ENOTSUPP;
> > +
> > +	/*
> > +	 * tRC < 30ns implies EDO mode. This controller does not support this
> > +	 * mode.
> > +	 */
> > +	if (conf->timings.sdr.tRC_min < 30)
> > +		return -ENOTSUPP;
> > +
> > +	atmel_smc_cs_conf_init(smcconf);
> > +
> > +	mckperiodps = NSEC_PER_SEC / clk_get_rate(nc->mck);
> > +	mckperiodps *= 1000;  
> 
> You probably want to multiply before dividing to retain precision.

Doing the multiplication first implies using an u64, and nanosecond
granularity is fine here (AFAIR, mck <= 166MHz).

> 
> > +	/*
> > +	 * Set write pulse timing. This one is easy to extract:
> > +	 *
> > +	 * NWE_PULSE = tWP
> > +	 */
> > +	ncycles = DIV_ROUND_UP(conf->timings.sdr.tWP_min, mckperiodps);
> > +	totalcycles = ncycles;
> > +	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NWE_SHIFT,
> > +					  ncycles);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * The write setup timing depends on the operation done on the NAND.
> > +	 * All operations goes through the same data bus, but the operation
> > +	 * type depends on the address we are writing to (ALE/CLE address
> > +	 * lines).
> > +	 * Since we have no way to differentiate the different operations at
> > +	 * the SMC level, we must consider the worst case (the biggest setup
> > +	 * time among all operation types):
> > +	 *
> > +	 * NWE_SETUP = max(tCLS, tCS, tALS, tDS) - NWE_PULSE
> > +	 */
> > +	timeps = max3(conf->timings.sdr.tCLS_min, conf->timings.sdr.tCS_min,
> > +		      conf->timings.sdr.tALS_min);
> > +	timeps = max(timeps, conf->timings.sdr.tDS_min);
> > +	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
> > +	ncycles = ncycles > totalcycles ? ncycles - totalcycles : 0;  
> 
> Ew, that's totally cryptic here ...

totalcycles contains the NWE_PULSE value (see above), and we don't want
to end up with a negative value in ncycles, hence the
ncycles > totalcycles test before doing the subtraction.

> 
> > +	totalcycles += ncycles;
> > +	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NWE_SHIFT,
> > +					  ncycles);
> > +	if (ret)
> > +		return ret;  
> 
> [...]
> 
> > +static const struct atmel_nand_controller_caps atmel_sam9260_nc_caps = {
> > +	.ale_offs = 1 << 21,
> > +	.cle_offs = 1 << 22,  
> 
> BIT(22) ?

Yep. Actually, this should be changed in [1].

[1]https://www.spinics.net/lists/arm-kernel/msg563780.html
