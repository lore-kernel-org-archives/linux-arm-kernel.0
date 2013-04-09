From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Apr 2013 01:41:13 -0400 (EDT)
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP operation
 if required
In-Reply-To: <1365412211.3384.16.camel@linaro1.home>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
 <20130405224819.GB14308@quad.lixom.net>
 <alpine.LFD.2.03.1304060943370.1171@syhkavp.arg>
 <1365412211.3384.16.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1304090135590.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Apr 2013, Jon Medhurst (Tixy) wrote:

> On Sat, 2013-04-06 at 10:02 -0400, Nicolas Pitre wrote:
> > I've amended this patch slightly so to:
> > 
> > 1) Keep the default .smp = &vexpress_smp_ops and only perform an 
> >    override in vexpress_smp_init_ops() when appropriate.  This should
> >    remove one potential issue with Xen support that was highlighted 
> >    recently.
> > 
> > 2) Add a mcpm_smp_set_ops() instead of installing mcpm_smp_ops directly
> >    for better abstraction.
> >
> > 3) Added a comment about and checked for the CCI node being enabled.
> > 
> > That results in the patch below.  Given those are minor changes, I kept 
> > the existing review tags.
> >
> > From: Jon Medhurst <tixy@linaro.org>
> > Date: Wed, 30 Jan 2013 09:12:55 +0000
> > Subject: [PATCH] ARM: vexpress: Select multi-cluster SMP operation if required
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> >
> > diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
> > index 34f236af09..cc82040877 100644
> > --- a/arch/arm/common/mcpm_platsmp.c
> > +++ b/arch/arm/common/mcpm_platsmp.c
> > @@ -85,3 +85,8 @@ struct smp_operations __initdata mcpm_smp_ops = {
> >  	.cpu_die		= mcpm_cpu_die,
> >  #endif
> >  };
> > +
> > +void __init mcpm_smp_set_ops(void)
> > +{
> > +	smp_set_ops(&mcpm_smp_ops);
> > +}
> > diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
> > index 814623e6a1..34dfb86ff5 100644
> > --- a/arch/arm/include/asm/mcpm_entry.h
> > +++ b/arch/arm/include/asm/mcpm_entry.h
> > @@ -190,5 +190,7 @@ int __mcpm_cluster_state(unsigned int cluster);
> >  int __init mcpm_sync_init(
> >  	void (*power_up_setup)(unsigned int affinity_level));
> >  
> > +void __init mcpm_smp_set_ops(void);
> > +
> >  #endif /* ! __ASSEMBLY__ */
> >  #endif
> 
> 
> Do the changes to the above mcpm files want to be in a separate patch as
> it's generic ARM code, not vexpress specific?

Well, since it was so trivial I didn't do it, but the split might be a 
good idea nevertheless.  So I inserted the following patch in the 
series, and corresponding changes are now removed from the patch above.  
What do you think?

Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Tue Apr 9 01:29:17 2013 -0400

    ARM: mcpm: provide an interface to set the SMP ops at run time
    
    This is cleaner than exporting the mcpm_smp_ops structure.
    
    Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 34f236af09..79ed70d846 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -76,7 +76,7 @@ static void mcpm_cpu_die(unsigned int cpu)
 
 #endif
 
-struct smp_operations __initdata mcpm_smp_ops = {
+static struct smp_operations __initdata mcpm_smp_ops = {
 	.smp_init_cpus		= simple_smp_init_cpus,
 	.smp_boot_secondary	= mcpm_boot_secondary,
 	.smp_secondary_init	= mcpm_secondary_init,
@@ -85,3 +85,8 @@ struct smp_operations __initdata mcpm_smp_ops = {
 	.cpu_die		= mcpm_cpu_die,
 #endif
 };
+
+void __init mcpm_smp_set_ops(void)
+{
+	smp_set_ops(&mcpm_smp_ops);
+}
diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
index 814623e6a1..34dfb86ff5 100644
--- a/arch/arm/include/asm/mcpm_entry.h
+++ b/arch/arm/include/asm/mcpm_entry.h
@@ -190,5 +190,7 @@ int __mcpm_cluster_state(unsigned int cluster);
 int __init mcpm_sync_init(
 	void (*power_up_setup)(unsigned int affinity_level));
 
+void __init mcpm_smp_set_ops(void);
+
 #endif /* ! __ASSEMBLY__ */
 #endif
