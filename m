From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 17:49:20 +0800
Subject: [PATCH] irq: convert generic-chip to use irq_domain
In-Reply-To: <4EE554BA.9040408@gmail.com>
References: <1323470689-6200-1-git-send-email-robherring2@gmail.com>
 <20111211160025.GA9572@S2100-06.ap.freescale.net>
 <4EE554BA.9040408@gmail.com>
Message-ID: <20111212094919.GH9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2011 at 07:11:22PM -0600, Rob Herring wrote:
> Shawn,
> 
> On 12/11/2011 10:00 AM, Shawn Guo wrote:
> > Hi Rob,
> > 
> > I installed the patch and played it a little bit, and I some feedback
> > below.
> 
> Thanks!
> 
> > * It breaks some existing irq_chip_generic users like imx5, which
> >   is currently numbering irq from 0.  For such users, irq_alloc_descs()
> >   will fail because it's asked to search irq #0 starting from irq #1.
> >   Yes, I know numbering irq from 0 is a bad idea and really needs to
> >   get fixed.  But is it your intention to break such users and force
> >   them get fixed with this patch?
> 
> I was trying not to break things and allow the existing irq base.
> 
> My problem is irq 0-15 are unallocated, 16-159 are the GIC. So when I
> try to allocate 8 irqdescs for gpio, I don't really want irq_alloc_descs
> to pick 0-15. Ideally we would just globally reserve 0-15 on ARM, but
> this will cause problems. So starting at 1 was at least slightly better
> than 0.
> 
> I think I'll just skip irq_alloc_descs call when the irq_base is >= 0.
> 
Yes, looks good.  But both parameter irq_base of irq_alloc_generic_chip
and member irq_base of 'struct irq_domain' are unsigned int, which
might be a little problem for irq_chip_generic users to pass -1 for
asking irq_chip_generic to allocate Linux irq numbers for it.

-- 
Regards,
Shawn
