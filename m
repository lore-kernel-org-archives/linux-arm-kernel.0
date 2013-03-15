From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 15 Mar 2013 12:25:56 -0400 (EDT)
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <1363362247-9542-1-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303151220500.1414-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Arnd Bergmann wrote:

> A number of ARM platforms were changed in linux-3.9 so they can be enabled
> at a single kernel configuration. Unfortunately, the necessary changes for
> the EHCI driver were not ready in time and the first attempt to split out
> the EHCI bus glues into separate modules had to get reverted before the
> merge window.
> 
> This means we are still stuck with a situation where enabling any
> combination of more than one of the OMAP, MVEBU/Orion and VT8500/WM8x50
> platforms at the same time leaves us with an EHCI driver that does
> not work properly and spits out this build warning:
> 
> ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> ehci-hcd.c:1257:0: note: this is the location of the previous definition
> ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> ehci-hcd.c:1277:0: note: this is the location of the previous definition
> In file included from ehci-hcd.c:1256:0:
> ehci-omap.c:311:31: warning: 'ehci_hcd_omap_driver' defined but not used [-Wunused-variable]
> In file included from ehci-hcd.c:1276:0:
> ehci-orion.c:334:31: warning: 'ehci_orion_driver' defined but not used [-Wunused-variable]
> ehci-hcd.c:1277:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> ehci-hcd.c:1257:0: note: this is the location of the previous definition
> ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> ehci-hcd.c:1277:0: note: this is the location of the previous definition

Roger just submitted my patch to split out ehci-omap.

> This is the simplest patch I could come up with that will restore some
> sanity in multiplatform configuration and allow us to build an ARM
> allyesconfig kernel. Disallowing the broken configuration in Kconfig
> would actually end up in a larger patch and more regression potential
> than this one.
> 
> We had a similar situation in 3.8 with a conflict between Orion and MXC,
> and Alan Stern objected to the simple hack back then and instead provided
> a better full conversion of the MXC backend in patch dba63b2f7. A proper
> patch for OMAP was submitted in January but also did not make it into 3.9,
> see https://patchwork.kernel.org/patch/2055131.
> 
> I expect that for 3.10 we will be able to do this correctly and
> turn all ARM bus glues into separate modules, ripping out the
> code that this patch changes.

What happened to Manjunath Goudar?  I haven't heard from him since his 
first round of submissions a month ago.  Fixing them up shouldn't be 
too much work.

As far as I can tell, your scheme should be okay for now.  It would be 
good to hear from other people, though.

I'd guess that the only reason it wasn't done this way from the
beginning is that nobody considered the possibility of building a
multi-platform driver.

Alan Stern
