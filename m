From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 1 Mar 2011 10:53:16 +0100 (CET)
Subject: [PATCH v6 1/1] PRUSS UIO driver support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BF3601C@dbde02.ent.ti.com>
References: <1298926895-5294-1-git-send-email-pratheesh@ti.com>
	<1298926895-5294-2-git-send-email-pratheesh@ti.com>
	<20110228212638.GB16806@local>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF3601C@dbde02.ent.ti.com>
Message-ID: <alpine.LFD.2.00.1103011052020.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2011, TK, Pratheesh Gangadhar wrote:
> > On Tue, Mar 01, 2011 at 02:31:35AM +0530, Pratheesh Gangadhar wrote:
> > > +
> > > +		/* Register PRUSS IRQ lines */
> > > +		p->irq = IRQ_DA8XX_EVTOUT0 + cnt;
> > > +		p->handler = pruss_handler;
> > > +
> > > +		ret = uio_register_device(&dev->dev, p);
> > > +
> > > +		if (ret < 0)
> > > +			goto out_free;
> > > +	}
> > > +
> > > +	spin_lock_init(&lock);
> > 
> > That's too late. uio_register_device() enables the irq, and your spin_lock
> > is not ready at that time.
> 
> This is ok in this context as "modprobe uio_pruss" is pre-requisite for
> running PRUSS firmware and without firmware running PRUSS won't
> generate interrupts. Actually PRUSS INTC is not setup till we start
> user application.

No, it's not. If you enable interrupts you have to be prepared for
getting one whether the device mask is enabled or not. It's that
simple.

Thanks,

	tglx
