From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 14 Sep 2011 17:47:23 +0100
Subject: [RFC 1/2] virtio: Add AMBA bus driver for virtio device
In-Reply-To: <87ehzkht7x.fsf@rustcorp.com.au>
References: <1314966257-7503-1-git-send-email-pawel.moll@arm.com>
	<1314966257-7503-2-git-send-email-pawel.moll@arm.com>
	<877h5e5yxp.fsf@rustcorp.com.au>
	<1315845956.3297.7.camel@hornet.cambridge.arm.com>
	<87hb4h408d.fsf@rustcorp.com.au>
	<1315906832.3297.41.camel@hornet.cambridge.arm.com>
	<87ehzkht7x.fsf@rustcorp.com.au>
Message-ID: <1316018843.3297.96.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 2. "Select word -> read flags" interface:
> > 
> >  *  0x010   32  HostFeaturesFlags  Features supported by the host
> >  *  0x014   32  HostFeaturesWord   Set of features to access
> > 
> >  *  0x020   32  GuestFeaturesFlags Features activated by the guest
> >  *  0x024   32  GuestFeaturesWord  Set of features to set
> > 
> > In this case the algorithm would be:
> > 
> > 	writel(0, HostFeaturesWord);
> > 	bits_0_31 = readl(HostFeaturesFlags);
> > 	writel(1, HostFeaturesWord);
> > 	bits_32_63 = readl(HostFeaturesFlags);
> > 	<etc>
> > 
> > The latter seems more "future-proof" to me, if slightly more complex...
> > Any other suggestions?
> 
> The former is almost certainly sufficient (remember, we can abuse the
> final feature bit to indicate there are extended features somewhere
> else, if we really have to).  But agree the latter is preferable: this
> isn't time-critical.

Ok, I'll do this in v3 then.

> > > We can sort that out later... the Guest may try some ambitious large
> > > allocation and fall back if it fails.
> > 
> > So, to my mind, the negotiations could look like this (from the Guest's
> > point of view):
> > 
> > 1. (optional) The Guest is asking what size is "suggested" by the Host:
> > 
> > 	size = readl(QueueNum);
> > 
> > 2. The Guest requests size it would like to use:
> > 
> > 	writel(optimal_size(size), QueueNum);
> > 
> > 3. The Host does the best it can to accommodate the Guest and the Guest
> > checks the effective size:
> > 
> > 	size = real(QueueNum);
> > 
> > Does it make some sense?
> 
> Does Host care?  It is sufficient for it to publish min/max values?

Hm. You're right, it should no care. Most likely the queue size will
impact some Host's memory allocation size, but that's the Host's
problem :-)

At the same time, how the Host would know what the max value is?

Generally it looks like the matter was getting back to value suggested
by the Host (as it is now) that may be changed by the Guest. Single R/W
register should be fine, I believe?

> You might want to throw the alignment value in there; there has been
> talk about adding that to PCI, for really small rings (less than a
> page).

Sure thing, will do.

v3 will be ready tomorrow.

Cheers!

Pawe?
