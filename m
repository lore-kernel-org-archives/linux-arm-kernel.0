From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 May 2011 13:35:03 +0200
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <4DD8F177.9020809@ti.com>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<201105221154.28211.arnd@arndb.de> <4DD8F177.9020809@ti.com>
Message-ID: <201105221335.03688.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 May 2011 13:20:23 Santosh Shilimkar wrote:
> >>   /*
> >>    * Intercept ioremap() requests for addresses in our fixed mapping regions.
> >
> > The only thing that the ioremap functions for omap do as a special case
> > is to handle the fixed mappings. Maybe a better approach would be to
> > make handling this in omap (and others) unnecessary, using one of
> > two approaches:
> >
> > * Remove all fixed mappings that are also ioremapped, and rely on every
> >    user calling ioremap correctly. I don't see why we would want to allow
> >    both methods anyway.
> >
> What do you mean by "Remove all fixed mappings that are also
> ioremapped" ?

I mean don't call iotable_init() for regions that is ioremapped
into a device driver. Having both iotable_init and ioremap
on the same area is a bit fishy anyway, so we should only have one
of the two: If the ioremap specifies different attributes from
the existing mapping, the code will still just return a pointer,
which may not be what the driver asks for, although it avoids
the problems that arise from having conflicting mappings.

> Why will you ioremap() it again if the fixed mapping is already
> registered through iotable_init()

Evidently, drivers call ioremap on regions that have a mapping
installed by iotable_init, otherwise the omap_ioremap function
would not make any sense whatsoever.

	Arnd
