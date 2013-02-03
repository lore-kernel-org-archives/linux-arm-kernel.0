From: pavel@denx.de (Pavel Machek)
Date: Sun, 3 Feb 2013 19:36:41 +0100
Subject: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <71B37E0559AC6849A68C5BA94C509FB45A645BA4EA@SJ-ITMSG02.altera.priv.altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-5-git-send-email-dinguyen@altera.com>
 <20130201035040.GE4838@quad.lixom.net>
 <20130201104655.GA3124@amd.pavel.ucw.cz>
 <71B37E0559AC6849A68C5BA94C509FB45A63D4E47D@SJ-ITMSG02.altera.priv.altera.com>
 <20130201153152.GS23505@n2100.arm.linux.org.uk>
 <1359736762.2932.1.camel@linux-builds1>
 <20130202192409.GA17736@amd.pavel.ucw.cz>
 <71B37E0559AC6849A68C5BA94C509FB45A645BA4EA@SJ-ITMSG02.altera.priv.altera.com>
Message-ID: <20130203183641.GA30825@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Point taken...thanks Russell.
> > 
> > Well, I don't think we normally check dtbs for validity with
> > user-helpful error messages, but it is relatively easy in this case.
> > 
> > ---cut here---
> > 
> > Continue booting with second core disabled if cpu1-start-addr is not
> > present in .dtb.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > 
> > diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-
> > socfpga/platsmp.c
> > index 81e0da0..90facdd 100644
> > --- a/arch/arm/mach-socfpga/platsmp.c
> > +++ b/arch/arm/mach-socfpga/platsmp.c
> > @@ -82,6 +82,9 @@ static void __init socfpga_smp_init_cpus(void)
> >  		ncores = 1;
> >  	}
> >  #endif
> > +	if (!cpu1start_addr)
> > +		ncores = 1;
> > +
> 
> This will not work because of commit 5587164eea4aad88fcb79d9b21dc8f14fea598cd 
> I sent out a V3 series of this patch, CPU1 will simply fail to come online if 
> cpu1-start-addr is not defined.

Are you sure? As far as I can see you still need such a line in v3 of
the patch:

@@ -72,6 +73,11 @@ void __init socfpga_sysmgr_init(void)
        struct device_node *np;

        np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
+       
+       if (of_property_read_u32(np, "cpu1-start-addr",
+                       (u32 *) &cpu1start_addr))
+               pr_err("SMP: Need cpu1-start-addr in device tree.\n");
+
        sys_manager_base_addr = of_iomap(np, 0);

        np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");

...so cpu1-start-addr is not there, cpu1start_addr is NULL but you
continue booting.

 ENTRY(secondary_trampoline)
-       movw    r0, #:lower16:CPU1_START_ADDR
-       movt  r0, #:upper16:CPU1_START_ADDR
+       movw    r2, #:lower16:cpu1start_addr
+       movt  r2, #:upper16:cpu1start_addr
+                       
+       /* The socfpga VT cannot handle a 0xC0000000 page offset when
loading
+               the cpu1start_addr, we bit clear it. Tested on HW and
VT. */
+       bic     r2, r2, #0x40000000

+       ldr     r0, [r2]
        ldr     r1, [r0]
        bx      r1

...and you'll dereference the NULL pointer here, no?

Sorry for the noise, this really is not all that important...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
