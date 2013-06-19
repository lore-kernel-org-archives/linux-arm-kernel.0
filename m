From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 07:02:00 -0300
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <20130618173906.GC2204@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618173906.GC2204@obsidianresearch.com>
Message-ID: <20130619100159.GB16138@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:39:06AM -0600, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2013 at 08:25:30AM -0300, Ezequiel Garcia wrote:
> > The address decoding window to access the BootROM should not be
> > allocated programatically, but instead declared in the device tree.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >  arch/arm/mach-mvebu/platsmp.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> > index 93f2f3a..d419fac 100644
> > +++ b/arch/arm/mach-mvebu/platsmp.c
> > @@ -118,7 +118,6 @@ void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
> >  	set_secondary_cpus_clock();
> >  	flush_cache_all();
> >  	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
> > -	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
> >  }
> 
> I think some kind of test is needed here. As I understand it the SMP
> startup uses a trampoline in the boot rom and the boot rom *must* be
> mapped to 0xfff00000 ?
> 

Indeed, setting up 0xfff00000 is a *must*.

> Verifying the DT is setup this way and aborting if it is not seems
> like a good idea..
> 

I agree it's a nice idea, but I'm not too sure how to accomplish this
in a simple and generic way. There's nothing in the DT that allows you
to know which of the ranges entries correspond to the BootROM, unless you go
through each of the entries comparing against the known target ID and
attribute.

You could also do a 'of_find_node_by_name(NULL, "bootrom");' but the binding
no longer requires to even have any children for the window.

Any ideas?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
