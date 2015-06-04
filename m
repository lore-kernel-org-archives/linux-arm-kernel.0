From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 4 Jun 2015 11:03:55 +0200
Subject: [PATCH v4 3/3] AHCI: Add generic MSI-X interrupt support to SATA
 PCI driver
In-Reply-To: <20150603054422.GD20091@mtj.duckdns.org>
References: <1433073319-13796-1-git-send-email-rric@kernel.org>
 <1433073319-13796-4-git-send-email-rric@kernel.org>
 <20150603054422.GD20091@mtj.duckdns.org>
Message-ID: <20150604090355.GC10428@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun,

thanks for applying first 2 patches of this series already.

I will address the comments you made on this patch in my next
submission. But see my question below.

On 03.06.15 14:44:22, Tejun Heo wrote:
> > +	/*
> > +	 * Per-port msix interrupts are not supported. Assume single
> > +	 * port interrupts for:
> > +	 *
> > +	 *  n_ports == 1, or
> > +	 *  nvec < n_ports.
> > +	 *
> > +	 * We also need to check for n_ports != 0 which is implicitly
> > +	 * covered here since nvec > 0.
> > +	 */
> > +	if (n_ports != 1 && nvec >= n_ports) {
> > +		rc = -ENOSYS;
> > +		goto fail;
> > +	}
> 
> Didn't I ask this one too the last time?  Can you explain why we can't
> initialize single IRQ mode if nvec >= n_ports?

I was hoping the comment above the code explains it. Since the code is
generic I implemented it a bit conservative wrt enabling msix. So the
above does not enable msix for devices with more than one port if the
number of interrupts is greater than the number of ports. In this case
the device could be multiple IRQ capable.

Now, after reading the section in the ahci spec about multiple IRQs
more detailed, I tend to be less stricter here. Single IRQ mode is
default for each device and multi mode must be explicitly enabled.
Thus, we could just enable single msix support for all kind of
devices.

There are 2 options now. One is to keep the above which means we need
to enable multi IRQ capable devices later. The other would be to drop
the check above completly and enable single IRQ support for all msix
devices.

I can't estimate the impact to other devices of this change (option
2). If you think this will be ok I will remove the check. But we could
leave it in for the first time and remove it later once tested on such
a device. Please let me know your opinion on this.

Thanks,

-Robert
