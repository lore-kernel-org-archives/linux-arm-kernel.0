From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 6 Sep 2016 15:46:22 +0200
Subject: [PATCH 2/7] mtd: nand: Introduce nand_data_interface
In-Reply-To: <20160906133444.7rwncblrgqsfw7ee@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
 <1473158355-22451-3-git-send-email-s.hauer@pengutronix.de>
 <20160906132118.17e2e8f8@bbrezillon>
 <20160906133444.7rwncblrgqsfw7ee@pengutronix.de>
Message-ID: <20160906154622.7ec5f281@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016 15:34:44 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Tue, Sep 06, 2016 at 01:21:18PM +0200, Boris Brezillon wrote:
> > On Tue,  6 Sep 2016 12:39:10 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> > > Currently we have no data structure to fully describe a NAND timing.
> > > We only have struct nand_sdr_timings for NAND timings in SDR mode,
> > > but nothing for DDR mode and also no container to store both types
> > > of timing.
> > > This patch adds struct nand_data_interface which stores the timing
> > > type and a union of different timings. This can be used to pass to
> > > drivers in order to configure the timing.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  include/linux/mtd/nand.h | 109 ++++++++++++++++++++++++++---------------------
> > >  1 file changed, 60 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> > > index 9af9575..19c73ef 100644
> > > --- a/include/linux/mtd/nand.h
> > > +++ b/include/linux/mtd/nand.h
> > > @@ -568,6 +568,66 @@ struct nand_buffers {
> > >  	uint8_t *databuf;
> > >  };
> > >  
> > > +/*
> > > + * struct nand_sdr_timings - SDR NAND chip timings
> > > + *
> > > + * This struct defines the timing requirements of a SDR NAND chip.
> > > + * These information can be found in every NAND datasheets and the timings
> > > + * meaning are described in the ONFI specifications:
> > > + * www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf (chapter 4.15 Timing
> > > + * Parameters)
> > > + *
> > > + * All these timings are expressed in picoseconds.
> > > + */
> > > +
> > > +struct nand_sdr_timings {
> > > +	u32 tALH_min;
> > > +	u32 tADL_min;
> > > +	u32 tALS_min;
> > > +	u32 tAR_min;
> > > +	u32 tCEA_max;
> > > +	u32 tCEH_min;
> > > +	u32 tCH_min;
> > > +	u32 tCHZ_max;
> > > +	u32 tCLH_min;
> > > +	u32 tCLR_min;
> > > +	u32 tCLS_min;
> > > +	u32 tCOH_min;
> > > +	u32 tCS_min;
> > > +	u32 tDH_min;
> > > +	u32 tDS_min;
> > > +	u32 tFEAT_max;
> > > +	u32 tIR_min;
> > > +	u32 tITC_max;
> > > +	u32 tRC_min;
> > > +	u32 tREA_max;
> > > +	u32 tREH_min;
> > > +	u32 tRHOH_min;
> > > +	u32 tRHW_min;
> > > +	u32 tRHZ_max;
> > > +	u32 tRLOH_min;
> > > +	u32 tRP_min;
> > > +	u32 tRR_min;
> > > +	u64 tRST_max;
> > > +	u32 tWB_max;
> > > +	u32 tWC_min;
> > > +	u32 tWH_min;
> > > +	u32 tWHR_min;
> > > +	u32 tWP_min;
> > > +	u32 tWW_min;
> > > +};
> > > +
> > > +enum nand_data_interface_type {
> > > +	NAND_SDR_IFACE,
> > > +};
> > > +  
> > 
> > I know this is my code, and I'm the one to blame here, but can you
> > document the nand_data_interface fields (kerneldoc format)?  
> 
> Sure, can do. Do you know what tCEH is? This one is not documented in
> the ONFI spec.

Maybe you're not looking at the latest ONFI spec ;). Anyway, I was not
asking you to document the nand_sdr_timings fields (pointing to the
spec should be enough), just the nand_data_interface ones.
