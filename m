From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Feb 2016 17:32:26 +0000
Subject: [PATCH v2] ARM: proc-v7.S: Adjust stack address when XIP_KERNEL
In-Reply-To: <alpine.LFD.2.20.1602011613360.32766@knanqh.ubzr>
References: <1454105474-3009-1-git-send-email-chris.brandt@renesas.com>
 <1454335736-10084-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602011613360.32766@knanqh.ubzr>
Message-ID: <20160216173225.GE19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 04:15:38PM -0500, Nicolas Pitre wrote:
> On Mon, 1 Feb 2016, Chris Brandt wrote:
> 
> > From: Nicolas Pitre <nico@linaro.org>
> > 
> > When XIP_KERNEL is enabled, the virt to phys address translation for RAM
> > is not the same as the virt to phys address translation for .text.
> > The only way to know where physical RAM is located is to use
> > PLAT_PHYS_OFFSET.
> > The MACRO will be useful for other places where there is a similar problem.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> 
> Looks fine.  You may submit it here:
...
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define PHYS_OFFSET_FIXUP \
> > +	( XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) - PAGE_OFFSET + \
> > +	  PLAT_PHYS_OFFSET - CONFIG_XIP_PHYS_ADDR )
> > +#else
> > +#define PHYS_OFFSET_FIXUP 0
> > +#endif
> > +
> >  #ifndef __ASSEMBLY__
> >  
> >  /*
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 0f92d57..1595fb2 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -487,7 +487,7 @@ __errata_finish:
> >  
> >  	.align	2
> >  __v7_setup_stack_ptr:
> > -	.word	__v7_setup_stack - .
> > +	.word	__v7_setup_stack - . + PHYS_OFFSET_FIXUP

I keep looking at this patch, and I really find that I detest this
PHYS_OFFSET_FIXUP thing - it's really not obvious what's going on
here.  It's taken a _long_ time to work this out, which _really_
isn't good going forward.

Let's instead change things to make it much more obvious - see the
patch below.

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ebdaaf7dd19f..593e5613184d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -135,11 +135,18 @@
 #define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
 
 #ifdef CONFIG_XIP_KERNEL
-#define PHYS_OFFSET_FIXUP \
-	( XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) - PAGE_OFFSET + \
-	  PLAT_PHYS_OFFSET - CONFIG_XIP_PHYS_ADDR )
+/*
+ * When referencing data in RAM from the XIP region in a relative manner
+ * with the MMU off, we need the relative offset between the two physical
+ * addresses.  The macro below achieves this, which is:
+ *    __pa(v_data) - __xip_pa(v_text)
+ */
+#define PHYS_RELATIVE(v_data, v_text) \
+	(((v_data) - PAGE_OFFSET + PLAT_PHYS_OFFSET) - \
+	 ((v_text) - XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) + \
+          CONFIG_XIP_PHYS_ADDR))
 #else
-#define PHYS_OFFSET_FIXUP 0
+#define PHYS_RELATIVE(v_data, v_text) (v_data) - (v_text)
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 1595fb29ec12..0f8963a7e7d9 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -487,7 +487,7 @@ __errata_finish:
 
 	.align	2
 __v7_setup_stack_ptr:
-	.word	__v7_setup_stack - . + PHYS_OFFSET_FIXUP
+	.word	PHYS_RELATIVE(__v7_setup_stack, .)
 ENDPROC(__v7_setup)
 
 	.bss


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
