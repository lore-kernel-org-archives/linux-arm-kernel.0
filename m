From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jun 2012 13:13:17 +0100
Subject: [PATCH] ARM: fiq: change FIQ_START to a variable
In-Reply-To: <20120629120057.GF29197@S2101-09.ap.freescale.net>
References: <1340867264-23043-1-git-send-email-shawn.guo@linaro.org>
 <20120629120057.GF29197@S2101-09.ap.freescale.net>
Message-ID: <20120629121317.GC16319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 08:00:59PM +0800, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 03:07:44PM +0800, Shawn Guo wrote:
> > The commit a2be01b (ARM: only include mach/irqs.h for !SPARSE_IRQ)
> > makes mach/irqs.h only be included for !SPARSE_IRQ build.  There are
> > a nubmer of platforms have FIQ_START defined in mach/irqs.h for FIQ
> > support.
> > 
> >   arch/arm/mach-rpc/include/mach/irqs.h:#define FIQ_START         64
> >   arch/arm/mach-s3c24xx/include/mach/irqs.h:#define FIQ_START             IRQ_EINT0
> >   arch/arm/plat-mxc/include/mach/irqs.h:#define FIQ_START 0
> > 
> > If SPARSE_IRQ is enabled for any of these platforms, the following
> > compile error will be seen.
> > 
> >   arch/arm/kernel/fiq.c: In function ?enable_fiq?:
> >   arch/arm/kernel/fiq.c:127:19: error: ?FIQ_START? undeclared (first use in this function)
> >   arch/arm/kernel/fiq.c:127:19: note: each undeclared identifier is reported only once for each function it appears in
> >   arch/arm/kernel/fiq.c: In function ?disable_fiq?:
> >   arch/arm/kernel/fiq.c:132:20: error: ?FIQ_START? undeclared (first use in this function)
> > 
> > The patch changes fiq code to have init_FIQ take FIQ_START from
> > platforms as a parameter and assign it to variable fiq_start which
> > is to replace FIQ_START uses in enable_fiq/disable_fiq.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Hi Russell,
> 
> Sorry for the pushing.  But the whole imx sparse-irq series is being
> held by this compile issue.  Can we consider the patch a solution for
> the issue?

To be frank, I've not been paying attention to it.  This patch looks okey
as a stop gap solution but in the longer run it must stop using the genirq
stuff, as I've already said.
