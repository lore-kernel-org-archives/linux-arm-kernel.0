From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:54:54 +0100
Subject: [PATCH 01/16] irqchip: add basic infrastructure
In-Reply-To: <50AC06F0.5070402@wwwdotorg.org>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50AC06F0.5070402@wwwdotorg.org>
Message-ID: <20121120235454.78fb7065@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Tue, 20 Nov 2012 15:40:48 -0700, Stephen Warren wrote:

> > Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> That still stands as:
> 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> ... although I think in this case the implementation changed enough it
> probably shouldn't have been kept in v4.

Indeed, my apologies. I was seeing some interest in this irqchip thing
in the recent days, and I wanted to show some of the progress but have
been quite busy with the mvebu development. So I was quite certainly a
bit too quick.

> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> 
> > +config IRQCHIP
> 
> I wonder if it should be IRQCHIP_OF, since it's OF-specific?
> 
> > +	def_bool y
> > +	depends on OF_IRQ
> 
> For the drivers/clocksource patch I created, I required the
> architecture/machine config option to select it rather than making it a
> def_bool. Would that be better? I suppose if it's going to be selected
> in a lot of places anyway, and since the code will just be dropped if it
> isn't used, then making it default to on is reasonable though.

Well, Rob Herring suggesting this def_bool y originally, I think it
makes sense as all new DT platforms will most likely this mechanism for
their IRQ driver. But if people feel like having a per-platform
'select IRQCHIP', I'm fine as well.

> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> 
> > @@ -493,7 +502,8 @@
> >  	DEV_DISCARD(init.rodata)					\
> >  	CPU_DISCARD(init.rodata)					\
> >  	MEM_DISCARD(init.rodata)					\
> > -	KERNEL_DTB()
> > +	KERNEL_DTB()							\
> > +	IRQCHIP_OF_MATCH_TABLE()
> 
> Does it make sense to put that before KERNEL_DTB()? I did in my
> drivers/clocksource patch just in case anything depended on KERNEL_DTB
> being last along the lines of APPENDED_DTB. That said, now that I think
> about it, nothing really should depend on the order...

I haven't thought about this, and I actually booted an APPENDED_DTB
kernel with this IRQCHIP_OF_MATCH_TABLE thing on Armada XP, and it
worked. I admit I haven't looked in details at what this KERNEL_DTB()
thing was.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
