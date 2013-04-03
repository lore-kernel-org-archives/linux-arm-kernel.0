From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 10:13:51 +0800
Subject: [PATCH] ARM: imx: do not bring up unavailable cores
In-Reply-To: <20130402151715.GB6608@mudshark.cambridge.arm.com>
References: <1364913146-26084-1-git-send-email-shawn.guo@linaro.org>
 <20130402151715.GB6608@mudshark.cambridge.arm.com>
Message-ID: <20130403021348.GK24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 04:17:15PM +0100, Will Deacon wrote:
> On Tue, Apr 02, 2013 at 03:32:26PM +0100, Shawn Guo wrote:
> > The i.MX6 Quad can be fused as i.MX6 Dual chip, and similarly i.MX6
> > DualLite can be fused as i.MX6 Solo.  The actual number of available
> > cores can be found out from SCU.
> > 
> > Since we do not reflect the fusing thing in device tree, the function
> > arm_dt_init_cpu_maps() will always call set_cpu_possible(true) for 4
> > cores on i.MX6 Quad/Dual and 2 cores for i.MX6 DualLite/Solo.  This
> > causes failures when kernel tries to bring those unavailable cores
> > online.  For example, the following failure message will be seen when
> > booting an i.MX6 Solo chip.
> > 
> >   CPU1: failed to come online
> > 
> > Though kernel will still boot fine, the message is somehow annoying.
> > Let's get rid of it by calling set_cpu_possible(false) on those
> > unavailable cores.
> > 
> > While at it, the set_cpu_possible(true) for available cores is removed,
> > since it's already been done in arm_dt_init_cpu_maps().
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/platsmp.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> > index 7c0b03f..7061bde 100644
> > --- a/arch/arm/mach-imx/platsmp.c
> > +++ b/arch/arm/mach-imx/platsmp.c
> > @@ -79,8 +79,8 @@ static void __init imx_smp_init_cpus(void)
> >  
> >  	ncores = scu_get_core_count(scu_base);
> >  
> > -	for (i = 0; i < ncores; i++)
> > -		set_cpu_possible(i, true);
> > +	for (i = ncores; i < NR_CPUS; i++)
> > +		set_cpu_possible(i, false);
> >  }
> 
> So you're passing the wrong DT to the kernel and then getting annoyed about
> some warnings in the dmesg?

I wouldn't way I'm passing the wrong DT to the kernel.  Here is the
thing, for i.MX6 DualLite example.

The i.MX6 DualLite is a dual core CA9 SoC.  The SoC is designed with a
One Time Programming (OTP) fuse bit.  When this fuse bit gets
programmed, one of the core will become unavailable and SCU
register will report core number as 1.

We write up DT for dual core case as default and let kernel to find out
if the i.MX6 DualLite it runs on actually has only one core available.

> Assuming the bootloader knows how many CPUs
> there are, shouldn't that be sorting out the CPU nodes before passing the
> dtb to the kernel?

The bootloader doesn't know the core numbers, unless we have code in
bootloader to find it out by reading fuse bit or SCU register that the
i.MX6 DualLite has one or two cores available.

Shawn
