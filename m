From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 8 Nov 2012 15:58:55 +0000
Subject: [Xen-devel] BUG: ARM build failures due to Xen
In-Reply-To: <alpine.DEB.2.02.1211081544510.2689@kaball.uk.xensource.com>
References: <20121106175749.GO28327@n2100.arm.linux.org.uk>
 <201211081528.31968.arnd@arndb.de>
 <1352389245.12977.106.camel@hastur.hellion.org.uk>
 <alpine.DEB.2.02.1211081544510.2689@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1211081554220.2689@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2012, Stefano Stabellini wrote:
> On Thu, 8 Nov 2012, Ian Campbell wrote:
> > On Thu, 2012-11-08 at 15:28 +0000, Arnd Bergmann wrote:
> > > On Tuesday 06 November 2012, Russell King - ARM Linux wrote:
> > > > My build system is giving me the following errors against an OMAP4
> > > > randconfig build against the latest Linus' kernel plus arm-soc:
> > > > 
> > > > ERROR: "privcmd_call" [drivers/xen/xen-privcmd.ko] undefined!
> > > > make[2]: *** [__modpost] Error 1
> > > > make[2]: Target `_modpost' not remade because of errors.
> > > > make[1]: *** [modules] Error 2
> > > > make: *** [sub-make] Error 2
> > > > make: Target `uImage' not remade because of errors.
> > > > make: Target `modules' not remade because of errors.
> > > > 
> > > > Full build results and configuration are here:
> > > > 
> > > > http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2627
> > > > http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2627
> > > > 
> > > 
> > > I can reproduce the same thing with mainline v3.7-rc4.
> > > 8<------
> > > xen/arm: export privcmd_call
> > 
> > Thanks, Konrad posted a fix for this on Tuesday which covers a few other
> > cases too: http://marc.info/?l=linux-kernel&m=135224075902642&w=2 I
> > added Russell to my response but forgot to add l-a-k@ too, sorry.
> 
> Konrad, do you have time to respin a patch that exports all the 9
> hypercalls?
 
This is the patch that I had in mind:

---


From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

xen/arm: Fix compile errors when drivers are compiled as modules.

We end up with:

ERROR: "HYPERVISOR_event_channel_op" [drivers/xen/xen-gntdev.ko] undefined!
ERROR: "privcmd_call" [drivers/xen/xen-privcmd.ko] undefined!
ERROR: "HYPERVISOR_grant_table_op" [drivers/net/xen-netback/xen-netback.ko] undefined!

and this patch exports said function (which is implemented in hypercall.S).

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 59bcb96..f576092 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -166,3 +166,14 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 	*pages = NULL;
 }
 EXPORT_SYMBOL_GPL(free_xenballooned_pages);
+
+/* In the hypervisor.S file. */
+EXPORT_SYMBOL_GPL(HYPERVISOR_event_channel_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_grant_table_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_xen_version);
+EXPORT_SYMBOL_GPL(HYPERVISOR_console_io);
+EXPORT_SYMBOL_GPL(HYPERVISOR_sched_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_hvm_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
+EXPORT_SYMBOL_GPL(privcmd_call);
