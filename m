From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Aug 2014 13:23:52 +0200
Subject: [PATCH] drivers: pci: convert generic host controller to DT host
 bridge creation API
In-Reply-To: <20140819120553.GA23128@arm.com>
References: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com>
 <20140819120553.GA23128@arm.com>
Message-ID: <201408201323.52404.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 August 2014, Will Deacon wrote:
> On Tue, Aug 12, 2014 at 05:41:35PM +0100, Liviu Dudau wrote:

> > +     if (!res_valid) {
> > +             dev_err(dev, "non-prefetchable memory resource required\n");
> > +             return -EINVAL;
> > +     }

I don't see why this part should be in the host controller driver. It's really
a sanity check that could apply anywhere, so could we just move it into the
common code, or alternatively drop it?

> > +     if (iores) {
> > +             if (!PAGE_ALIGNED(io_cpuaddr))
> > +                     return -EINVAL;
> 
> Why is this alignment check not in the core code?

This confused me too. I have to look back at the core code, but I assume it's
either aligned already based on the way this number gets created, or it
can have an offset within the page that is the same as the offset within the
physical address of iores and that hould be handled internally by
pci_remap_iospace().

> Probably a question for
> somebody like Arnd, but do we need to deal with multiple IO resources?
> Currently we'll just silently take the last one that we found, which doesn't
> sound ideal.

I can't think of a case where you'd actually have multiple IO resources,
but I agree we should either treat that as an error or handle it right.
My guess is that handling it is actually easier.

	Arnd
