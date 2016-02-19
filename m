From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 19 Feb 2016 10:35:35 +0100
Subject: [PATCH v2] irqchip: irq-mvebu-odmi: new driver for platform MSI
 on Marvell 7K/8K
In-Reply-To: <56C5F433.8010701@arm.com>
References: <1455811134-3679-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <56C5F433.8010701@arm.com>
Message-ID: <20160219103535.28062901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Thu, 18 Feb 2016 16:41:23 +0000, Marc Zyngier wrote:

> It looks really nice, except for a couple of points, see below.

Thanks again for the review.

> > +/*
> > + * We don't support the group events, so we simply have 8 interrupts
> > + * per frame.
> > + */
> > +#define NODMIS_PER_FRAME 8
> > +#define NODMIS_SHIFT     3
> > +#define NODMIS_MASK      7
> 
> All these values are directly related, so it would be nice if they would
> be expressed in term of each other:
> 
> #define NODMIS_SHIFT	 3
> #define NODMIS_PER_FRAME (1 << NODMIS_SHIFT)
> #define NODMIS_MASK      (NODMIS_PER_FRAME - 1)

Good point, will do.

> > +	odmis_bm = kzalloc(odmis_count * NODMIS_PER_FRAME / BITS_PER_BYTE,
> > +			   GFP_KERNEL);
> 
> Blah. this will allocate the exact number of bytes, which you will then
> access as longs, touching memory that's not yours in the process (I've
> been recently bitten and publicly shamed...).

Aah, yes.

> Consider the following:
> 
> odmis_bm = kzalloc(BITS_TO_LONGS(odmis_count * NODMIS_PER_FRAME) *
> sizeof(long), GFP_KERNEL);

Will do.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
