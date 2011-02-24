From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Thu, 24 Feb 2011 19:24:55 +0530
Subject: [PATCH v3 1/2] PRUSS UIO driver support
In-Reply-To: <alpine.LFD.2.00.1102232057260.2701@localhost6.localdomain6>
References: <1298469161-7644-1-git-send-email-pratheesh@ti.com>
	<1298469161-7644-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1102232057260.2701@localhost6.localdomain6>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE49813@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Thursday, February 24, 2011 1:56 AM
> To: TK, Pratheesh Gangadhar
> Cc: davinci-linux-open-source at linux.davincidsp.com; hjk at hansjkoch.de;
> gregkh at suse.de; Chatterjee, Amit; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] PRUSS UIO driver support
> 
> On Wed, 23 Feb 2011, Pratheesh Gangadhar wrote:
> 
> Is it actually too much of an hassle to cc the people who spent their
> time to review previous versions of your patch ?
> 
Sorry. Will do...
> > +struct clk *pruss_clk;
> > +struct uio_info *info;
> > +void *ddr_virt_addr = NULL, *prussio_virt_addr = NULL;
> 
> Grrr. We do not initialize with NULL.
> 
> > +dma_addr_t ddr_phy_addr;
> 
> Also all of these want to be static.
> 
Ok.
> 
> > +		uio_unregister_device(p);
> > +		kfree(p->name);
> > +	}
> > +	iounmap(prussio_virt_addr);
> > +	dma_free_coherent(&dev->dev, info[0].mem[2].size,
> > +			  info[0].mem[2].internal_addr, info[0].mem[2].addr);
> 
> You sure, that iounmap and dma_free_coherent are too happy about being
> called with NULL pointers?
> 
For iounmap its ok, not ok for dma_free_coherent. Will fix.
> > +
> > +	kfree(info);
> > +	clk_put(pruss_clk);
> > +}
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
> Memory leak.
Will fix.
 

Thanks,
Pratheesh
