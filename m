From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 12:36:43 +0200
Subject: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
In-Reply-To: <20130618101538.8D54E3E0D60@localhost>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130611133745.514CA3E0A90@localhost>
 <20130618104218.7917f927@skate>
 <20130618101538.8D54E3E0D60@localhost>
Message-ID: <20130618123643.694e733d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

On Tue, 18 Jun 2013 11:15:38 +0100, Grant Likely wrote:

> > +       if (domain == NULL)
> > +               domain = irq_default_domain;
> 
> Drop the above 2 lines. You absolutely must know what irq_domain you
> want to operate on when calling this function. There is no situation
> where the default domain is what should be used.

Sure, makes sense.

> > +
> > +       for (hwirq = 0; hwirq < domain->hwirq_max; hwirq++)
> > +               if (!irq_find_mapping(domain, hwirq))
> > +                       break;
> 
> Ugh. This will be slow on domains with a high hwirq_max and low
> revmap_size since all the lookups will go out to the radix tree. Blech.
> Not much to do about it though at this point without implementing some
> kind of fast lookup path. To do it right would require iterating over
> the radix tree looking for a hole.

So to conclude you would leave it as I proposed for now?

An option is to make irq_alloc_mapping() work only on linear domains,
where hwirq_max == revmap_size, and return an error otherwise.

> Once a free hwirq has been found, it would be better to call
> irq_create_mapping() directly rather than open coding it.

Thanks, will do.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
