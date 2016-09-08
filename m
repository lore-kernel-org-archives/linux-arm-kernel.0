From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 8 Sep 2016 10:12:43 +0200
Subject: [PATCH 3/7] mtd: nand: automate NAND timings selection
In-Reply-To: <20160908075530.e4o2gecxxlmedtlx@pengutronix.de>
References: <1473250902-31139-1-git-send-email-s.hauer@pengutronix.de>
 <1473250902-31139-4-git-send-email-s.hauer@pengutronix.de>
 <20160907154114.1aae0462@bbrezillon>
 <20160907143615.cholyvh6zyk7rnfj@pengutronix.de>
 <20160907165951.51f15505@bbrezillon>
 <20160907175917.2a4791d3@bbrezillon>
 <20160908075530.e4o2gecxxlmedtlx@pengutronix.de>
Message-ID: <20160908101243.60db3eaa@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2016 09:55:30 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Wed, Sep 07, 2016 at 05:59:17PM +0200, Boris Brezillon wrote:
> > On Wed, 7 Sep 2016 16:59:51 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >   
> > > On Wed, 7 Sep 2016 16:36:15 +0200
> > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > >   
> > > > Ok, I think now we are understanding each other. So I keep two timing
> > > > instances in struct nand_chip, one for initialization and one optimized
> > > > timing. They both get initialized once during chip detection and can be
> > > > reused when needed.    
> > > 
> > > Hm, not sure we need to keep 2 instances around, all we need to save is
> > > the 'best_onfi_timing_mode', or we can just update  
> > > ->default_onfi_timing_mode based on the result of the timing mode    
> > > detection, so that, when nand_setup_data_interface() is called, all we
> > > have to do is:
> > > 
> > > 	conf = chip->data_iface_conf;
> > > 	conf->type = NAND_SDR_IFACE,
> > > 	conf->timings.sdr = *onfi_async_timing_mode_to_sdr_timings(chip->default_onfi_timing_mode);
> > > 	chip->setup_data_interface(mtd, conf, false);
> > >   
> > 
> > After the discussion we had on IRC, I want to reconsider what I said.
> > How about having a global nand_default_data_iface_config that would
> > work will all chips (probably exposing mode 0 timings and an SDR
> > interface).
> > This one will be used even for DDR NANDs, because after a reset they
> > return back to SDR mode, timing mode 0.
> > 
> > Now, I keep thinking that other timing modes should not be directly
> > exposed.  
> 
> sounds good. How do you think the default iface_config should be
> exposed? Should I turn the onfi_sdr_timings array to struct
> nand_data_interface like done before and add a accessor function for the
> first element, something like:
> 
> const struct nand_data_interface *nand_default_data_interface(void);

Sounds goods. Sorry if I changed my mind to finally get back to
something close to your initial proposal, but I must admit I didn't
know what I wanted exactly, and only realized when seeing your
implementation.

Thanks for your patience ;-).
