From: saaguirre@ti.com (Aguirre Rodriguez, Sergio Alberto)
Date: Mon, 19 Oct 2009 12:21:17 -0500
Subject: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
In-Reply-To: <20091019171204.GP12576@atomide.com>
References: <20091016233624.2463.26653.stgit@localhost>
	<20091016234138.2463.38350.stgit@localhost>
	<20091016234622.GH12576@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB37D7AA@dbde02.ent.ti.com>
	<20091017161947.GK12576@atomide.com>
	<20091019002416.GM12576@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB37D82D@dbde02.ent.ti.com>
	<20091019171204.GP12576@atomide.com>
Message-ID: <A24693684029E5489D1D202277BE89444CFD9382@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, 

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Monday, October 19, 2009 12:12 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [091019 00:27]:
> > Tony,
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony at atomide.com]
> > > Sent: Monday, October 19, 2009 5:54 AM
> > > To: Shilimkar, Santosh
> > > Cc: linux-arm-kernel at lists.infradead.org; 
> linux-omap at vger.kernel.org
> > > Subject: Re: [PATCH 08/14] omap: Use ioremap for omap4 L4 code
> > > 
> > > * Tony Lindgren <tony@atomide.com> [091017 09:19]:
> > > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [091017 03:49]:
> > > > > Thanks Tony for this ioremap series!!
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tony Lindgren [mailto:tony at atomide.com]
> > > > > > Sent: Saturday, October 17, 2009 5:16 AM
> > > > > > To: linux-arm-kernel at lists.infradead.org
> > > > > > Cc: linux-omap at vger.kernel.org; Shilimkar, Santosh
> > > > > > Subject: Re: [PATCH 08/14] omap: Use ioremap for 
> omap4 L4 code
> > > > > >
> > > > > > * Tony Lindgren <tony@atomide.com> [091016 16:42]:
> > > > > > > Use ioremap for omap4 L4 code
> > > > > >
> > > > > > Santosh, can you please check and ack this patch?
> > > > > >
> > > > > > Especially some of the ioremap sizes may be wrong. 
> Also, this one
> > > > > > I cannot boot test, so it's just compile tested.
> > > > >
> > > > > I have checked the patch and it looks all right 
> except few typo. Also
> > > the scu_base is needed bit earlier.
> > > 
> > > <snip>
> > > 
> > > > > Here is the patch on top of ioremap series which 
> should fix above
> > > mentioned things. With below patch + two serial related 
> patches the kernel
> > > boots on OMAP4430.
> > > >
> > > > Great, will update. Thanks for taking the time to fix it!
> > > 
> > > Here's this one updated with Santosh's fix merged in.
> > V2 has one typo which I think I also missed in my patch.
> > >+	/* Static mapping, never released */
> > >+	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> > >+	BUG_ON(!base);
> > Should be BUG_ON(!gic_cpu_base_addr);
> 
> OK, here's V3 of the patch.

Tony,

> diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
> index abe0864..3bad928 100644
> --- a/arch/arm/plat-omap/include/mach/entry-macro.S
> +++ b/arch/arm/plat-omap/include/mach/entry-macro.S
> @@ -104,6 +104,8 @@
>  
>  		.endm
>  #else
> +#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
> +

Shouldn't this define go with the ioremap aproach?

>  		/*
>  		 * The interrupt numbering scheme is defined in the
>  		 * interrupt controller spec.  To wit:

Regards,
Sergio

> 
> Tony
> 
