From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Thu, 24 Feb 2011 19:26:28 +0530
Subject: [PATCH v3 1/2] PRUSS UIO driver support
In-Reply-To: <20110223173724.GA2801@local>
References: <1298469161-7644-1-git-send-email-pratheesh@ti.com>
	<1298469161-7644-2-git-send-email-pratheesh@ti.com>
	<20110223173724.GA2801@local>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE49816@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Hans J. Koch [mailto:hjk at hansjkoch.de]
> Sent: Wednesday, February 23, 2011 11:07 PM
> To: TK, Pratheesh Gangadhar
> Cc: davinci-linux-open-source at linux.davincidsp.com; hjk at hansjkoch.de;
> gregkh at suse.de; Chatterjee, Amit; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] PRUSS UIO driver support
> 
> On Wed, Feb 23, 2011 at 07:22:40PM +0530, Pratheesh Gangadhar wrote:
> > This patch implements PRUSS (Programmable Real-time Unit Sub System)
> > UIO driver which exports SOC resources associated with PRUSS like
> > I/O, memories and IRQs to user space. PRUSS is dual 32-bit RISC
> > processors which is efficient in performing embedded tasks that
> > require manipulation of packed memory mapped data structures and
> > efficient in handling system events that have tight real time
> > constraints. This driver is currently supported on Texas Instruments
> > DA850, AM18xx and OMAPL1-38 devices.
> > For example, PRUSS runs firmware for real-time critical industrial
> > communication data link layer and communicates with application stack
> > running in user space via shared memory and IRQs.
> >
> > Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> > ---
> >  drivers/uio/Kconfig     |   17 ++++
> >  drivers/uio/Makefile    |    1 +
> >  drivers/uio/uio_pruss.c |  223
> +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 241 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/uio/uio_pruss.c
> >
> 
> [...]
> 
> > +
> > +static int __devinit pruss_probe(struct platform_device *dev)
> > +{
> > +	int ret = -ENODEV, count = 0;
> > +	struct resource *regs_prussio, *regs_l3ram, *regs_ddr;
> > +	struct uio_info *p;
> > +
> > +	info = kzalloc(sizeof(struct uio_info) * MAX_PRUSS_EVTOUT_INSTANCE,
> > +		       GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	/* Power on PRU in case its not done as part of boot-loader */
> > +	pruss_clk = clk_get(&dev->dev, "pruss");
> > +	if (IS_ERR(pruss_clk)) {
> > +		dev_err(&dev->dev, "Failed to get clock\n");
> > +		ret = PTR_ERR(pruss_clk);
> > +		return ret;
> 
> You leak memory here. What about freeing "info"?

Ok. Will fix.

Thanks,
Pratheesh
