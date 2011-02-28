From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Mon, 28 Feb 2011 09:32:54 +0530
Subject: [PATCH v5 1/2] PRUSS UIO driver support
In-Reply-To: <alpine.LFD.2.00.1102251049090.2701@localhost6.localdomain6>
References: <1298623530-10294-1-git-send-email-pratheesh@ti.com>
	<1298623530-10294-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1102251049090.2701@localhost6.localdomain6>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BF358B3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Friday, February 25, 2011 3:24 PM
> To: TK, Pratheesh Gangadhar
> Cc: davinci-linux-open-source at linux.davincidsp.com; hjk at hansjkoch.de;
> gregkh at suse.de; sshtylyov at mvista.com; arnd at arndb.de; Chatterjee, Amit;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v5 1/2] PRUSS UIO driver support
> 
> On Fri, 25 Feb 2011, Pratheesh Gangadhar wrote:
> > +static irqreturn_t pruss_handler(int irq, struct uio_info *dev_info)
> > +{
> > +	void __iomem *base = dev_info->mem[0].internal_addr;
> > +	void __iomem *intren_reg = base + PINTC_HIER;
> > +	void __iomem *intrstat_reg = base + PINTC_HIPIR + ((irq - 1) << 2);
> > +	int val = ioread32(intren_reg), intr_mask = (1 << (irq - 1));
> > +
> > +	/* Is interrupt enabled and active ? */
> > +	if (!(val & intr_mask) && (ioread32(intrstat_reg) & HIPIR_NOPEND))
> > +		return IRQ_NONE;
> > +
> > +	/* Disable interrupt */
> > +	iowrite32((val & ~intr_mask), intren_reg);
> > +	return IRQ_HANDLED;
> > +}
> 
> Hmm, just noticed, that you fiddle with the interrupt enable register
> here totally unprotected. So on a SMP system you might haandle two
> different interrupts at the same time. That wants locking.
> 
> And even on UP, you have a problem as you reenable that thing from
> user space which requires a read modify write. Racy as hell.
> 
> Please look at the other UIO drivers which have the same problem.
> Sorry for not noticing earlier!

Thanks for pointing this out. Yes - this is a problem especially since we have more than one interrupt for PRUSS which is enabled/disabled in this register. I will fix this and resubmit along with fixes addressing Sergei's comments on platform specific portion.

Thanks,
Pratheesh
