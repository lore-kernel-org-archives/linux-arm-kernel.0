From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 09:16:20 +0200
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
	<CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
Message-ID: <201107070916.20750.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 01:57:11 Lin Mac wrote:
> 2011/7/6 Anton Vorontsov <avorontsov@mvista.com>:
> > CNS3xxx SOCs have L310-compatible cache controller, so let's use it.
> >
> > With this patch benchmarking with 'gzip' shows that performance is
> > doubled, and I'm still able to boot full-fledged userland over NFS
> > (using PCIe NIC), so the support should be pretty robust.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> 
> CNS3xxx have PL310. Would you mind to enable CONFIG_CACHE_PL310 by
> default as well? It is default disabled by !CPU_V6 of CACHE_PL310.
> 
> @@ -795,6 +795,7 @@ config CACHE_L2X0
>         default y
>         select OUTER_CACHE
>         select OUTER_CACHE_SYNC
> +       select CACHE_PL310 if ARCH_CNS3XXX
>         help
>           This option enables the L2x0 PrimeCell.
> 

I think it's better to keep such things local to the platform that needs
it and add 'select CACHE_PL310 if CACHE_L2X0' to the ARCH_CNS3XXX config.
The result is the same, but we don't clutter the main Kconfig.

In the light of the move to cross-platform zImage builds, this would
still be wrong however, you must not select CACHE_PL310 if any target
machine has a L2X0.

A more correct but also more complex solution would be

 config CACHE_PL310
         bool
         depends on CACHE_L2X0
-        default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
+        default y if CPU_V7 && (!(CPU_V6 || CPU_V6K) || ARCH_CNS3XXX)
         help
           This option enables optimisations for the PL310 cache
           controller.

If we get more of these, we might want to turn around the logic.


	Arnd
