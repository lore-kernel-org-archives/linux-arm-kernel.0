From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 24 Nov 2011 02:53:27 +0000 (GMT)
Subject: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <20111123230138.GL9581@n2100.arm.linux.org.uk>
Message-ID: <1322103207.2627.YahooMailClassic@web29004.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Wed, 23/11/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> So 'dev' is a driver_data structure.
> but you pass it to dev_warn().  This is not what
> dev_warn() is expecting.

Correct; alas Philipp discovered this the hard way. I'm on it.

> > +int navpoint_suspend(struct device *dev)
> 
> static?

Yes, will do.

> > +int navpoint_resume(struct device *dev)
> 
> static?

Ditto.

> > +    /* Wait until SSP port is ready
> for slave clock operations */
> > +    while (pxa_ssp_read_reg(ssp, SSSR)
> & SSSR_CSS)
> > +        msleep(1);
> 
> What if it never becomes ready?  Should this time
> out?

This loop was an early sanity check which I never removed. But I agree that broken hardware might cause it to hang. So I'll either remove it or, more usefully, add a timeout with error message.

> > +    drv_data = kzalloc(sizeof(struct
> driver_data), GFP_KERNEL);
> 
> We normally like to see sizeof(*drv_data) now.

OK.

> > +    ret = request_irq(ssp->irq,
> navpoint_int, 0, pdev->name, drv_data);
> > +    if (ret)
> > +        goto ret2;
> 
> What if you immediately receive an interrupt right now,
> after requesting
> this interrupt?  Will your handler try to dereference
> anything in
> drv_data which is -currently- NULL ?  (I think you'll
> oops when
> dereferencing drv_data->ssp->something.)

Shouldn't happen because the SSP port is not enabled until the later call to navpoint_resume(). However, Philipp has discovered spurious interrupts with the haret bootloader; perhaps it already enabled the SSP port. I'm on it.

> > +    (void)
> navpoint_resume(&pdev->dev);
> 
> That cast to 'void' is not required.

True, but that function must return a value and I was just documenting the fact that it's being intentionally ignored here. I'm happy to remove it.

> > +    (void)
> navpoint_suspend(&pdev->dev);
> 
> Cast to void is not required.

Ditto.
