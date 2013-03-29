From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 29 Mar 2013 16:15:55 -0400 (EDT)
Subject: [PATCH v3 7/7] USB: OHCI: avoid conflicting platform drivers
In-Reply-To: <1364507705-22012-8-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303291612370.1467-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> Like the EHCI driver, OHCI supports a large number of different platform
> glue drivers by directly including them, which causes problems with
> conflicting macro definitions in some cases. As more ARM architecture
> specific back-ends are required to coexist in a single build, we should
> split those out into separate drivers. Unfortunately, the infrastructure
> for that is still under development, so to give us more time, this uses
> a separate *_PLATFORM_DRIVER macro for each ARM specific OHCI backend,
> just like we already do on PowerPC and some of the other ARM platforms.
> 
> In linux-3.10, only the SPEAr and CNS3xxx back-ends would actually conflict
> without this patch, but over time we would get more of them, so this
> is a way to avoid having to patch the driver every time it breaks. We
> should still split out all back-ends into separate loadable modules,
> but that work is only needed to improve code size and cleanliness after
> this patch, not for correctness.
> 
> While we're here, this fixes the incorrectly sorted error path
> for the OMAP1 and OMAP3 backends to ensure we always unregister
> the exact set of drivers that were registered before erroring out.

I have not checked the details of all the changes; however, the basic
idea is okay as a stop-gap measure.

I guess this means the onus is now on me to split up ohci-hcd into a 
central library and separate bus drivers, like ehci-hcd...

Alan Stern
