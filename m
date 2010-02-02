From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 2 Feb 2010 12:19:34 +0530
Subject: [PATCH 1/3] OMAP4: Add L2 Cache support
In-Reply-To: <20100129143002.GD16712@n2100.arm.linux.org.uk>
References: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
	<1264767365.4242.54.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C09C688C@dbde02.ent.ti.com>
	<20100129143002.GD16712@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0A69934@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Since this code was used only ones in init, I haven't converted it to
> > function. With clobber list as well as you know adding r12 to clobber
> > list, compiler don't generate the save code and r11 can't be added to
> > clobber list.
> 
> Well, we seem to have two places with the same code structure.  Let's
> pull them together into a common function, such as:
> 
> void omap_smc1(u32 fn, u32 arg)
> {
> 	register u32 r12 asm("r12") = fn;
> 	register u32 r0 asm("r0") = arg;
> 	asm volatile(
> 		"str r11, [sp], #-4\n"
> 		"dsb\n"
> 		"smc\n"
> 		"ldr r11, [sp, #4]!"
> 		: "+r" (r0), "+r" (r12)
> 		:
> 		: "r0-r10", "lr", "cc");
> }
> EXPORT_SYMBOL(omap_smc1);
> 
> The code there probably may not be Thumb-2 compatible.
I will re-arrange the series and sent combined the errata + l2 support
with above change since dependency.

Regards,
Santosh
