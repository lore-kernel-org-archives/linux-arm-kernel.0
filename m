From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Wed, 2 Mar 2011 02:49:54 +0530
Subject: [PATCH v6 1/1] PRUSS UIO driver support
In-Reply-To: <20110301183334.GC20497@local>
References: <1298926895-5294-1-git-send-email-pratheesh@ti.com>
	<1298926895-5294-2-git-send-email-pratheesh@ti.com>
	<20110228212638.GB16806@local>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF3601C@dbde02.ent.ti.com>
	<20110301183334.GC20497@local>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BF36683@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> -----Original Message-----
> From: Hans J. Koch [mailto:hjk at hansjkoch.de]
> Sent: Wednesday, March 02, 2011 12:04 AM
> To: TK, Pratheesh Gangadhar
> Cc: Hans J. Koch; linux-kernel at vger.kernel.org; gregkh at suse.de;
> tglx at linutronix.de; sshtylyov at mvista.com; arnd at arndb.de; Chatterjee, Amit;
> davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v6 1/1] PRUSS UIO driver support
> 
> On Tue, Mar 01, 2011 at 10:15:27AM +0530, TK, Pratheesh Gangadhar wrote:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Hans J. Koch [mailto:hjk at hansjkoch.de]
> > > Sent: Tuesday, March 01, 2011 2:57 AM
> > > To: TK, Pratheesh Gangadhar
> > > Cc: linux-kernel at vger.kernel.org; hjk at hansjkoch.de; gregkh at suse.de;
> > > tglx at linutronix.de; sshtylyov at mvista.com; arnd at arndb.de; Chatterjee,
> Amit;
> > > davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> > > kernel at lists.infradead.org
> > > Subject: Re: [PATCH v6 1/1] PRUSS UIO driver support
> > >
> > > On Tue, Mar 01, 2011 at 02:31:35AM +0530, Pratheesh Gangadhar wrote:
> > > > +
> > > > +		/* Register PRUSS IRQ lines */
> > > > +		p->irq = IRQ_DA8XX_EVTOUT0 + cnt;
> > > > +		p->handler = pruss_handler;
> > > > +
> > > > +		ret = uio_register_device(&dev->dev, p);
> > > > +
> > > > +		if (ret < 0)
> > > > +			goto out_free;
> > > > +	}
> > > > +
> > > > +	spin_lock_init(&lock);
> > >
> > > That's too late. uio_register_device() enables the irq, and your
> spin_lock
> > > is not ready at that time.
> >
> > This is ok in this context as "modprobe uio_pruss" is pre-requisite for
> > running PRUSS firmware and without firmware running PRUSS won't
> > generate interrupts. Actually PRUSS INTC is not setup till we start
> > user application.
> 
> What if the user application is stopped, UIO driver module unloaded
> and loaded again?
> 
This is a possible scenario - may be a buggy application. Normally when
application is stopped, PRUs are stopped by exit handler.

> Anyway, please don't use that kind of argumentation. The next newbie
> developer might copy your work as a basis for his new driver, and there
> it probably won't work.
> 
> Simply put the spin_lock_init before the loop.
> 
Agree, will fix this in next version.

Thanks,
Pratheesh
