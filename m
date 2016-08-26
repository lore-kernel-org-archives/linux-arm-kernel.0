From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2016 13:35:50 +0100
Subject: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
In-Reply-To: <AM3PR04MB13154FA0116D397AABD75E10F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
 <1472209971-32469-4-git-send-email-Anson.Huang@nxp.com>
 <20160826111356.GM1041@n2100.armlinux.org.uk>
 <AM3PR04MB13154FA0116D397AABD75E10F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <20160826123550.GQ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 12:20:15PM +0000, Yongcai Huang wrote:
> > On Fri, Aug 26, 2016 at 07:12:51PM +0800, Anson Huang wrote:
> > > diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> > > index 711dbbd..63af911 100644
> > > --- a/arch/arm/mach-imx/platsmp.c
> > > +++ b/arch/arm/mach-imx/platsmp.c
> > > @@ -60,8 +60,17 @@ static int imx_boot_secondary(unsigned int cpu,
> > > struct task_struct *idle)  static void __init imx_smp_init_cpus(void)
> > > {
> > >  	int i, ncores;
> > > +	unsigned long val, arch_type;
> > >
> > > -	ncores = scu_get_core_count(scu_base);
> > > +	asm volatile("mrc p15, 0, %0, c0, c0, 0" : "=r" (arch_type));
> > > +
> > > +	if (((arch_type >> 4) & 0xfff) == 0xc07) {
> > 
> > This is buggy.  Plus, we have macros for this.  Please use the macros in
> > asm/cputype.h to achieve these tests.
> 
> Thanks, I will use read_cpuid_id() API intead of putting asm code here.

Nope.  Do this:

	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A7) {

Because the part number field is defined by the implementer, so before
you can interpret the part number field, you have to first check who
has implemented the device.

That's exactly why these macros exist - to help you get these tests
correct, so when someone else releases an ARM core with the same value
in the part number field, we don't end up with a load of tests which
incorrectly matching.

While it may be unlikely that an iMX7 would end up with a non-ARM CPU,
that's no real excuse for avoiding using what's been provided for you,
especially when avoiding it causes issues for static analysis.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
