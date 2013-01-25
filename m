From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 25 Jan 2013 15:02:50 -0600
Subject: [PATCHv1 for soc 5/5] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <20130125175511.GE10055@amd.pavel.ucw.cz>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-6-git-send-email-dinguyen@altera.com>
 <20130125175511.GE10055@amd.pavel.ucw.cz>
Message-ID: <1359147770.32148.28.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Fri, 2013-01-25 at 18:55 +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Because the CPU1 start address is different for socfpga-vt and
> > socfpga-cyclone5, we add code to use the correct CPU1 start addr.
> > 
> > +++ b/arch/arm/configs/socfpga_defconfig
> > @@ -21,6 +21,7 @@ CONFIG_ARM_THUMBEE=y
> >  # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
> >  # CONFIG_CACHE_L2X0 is not set
> >  CONFIG_HIGH_RES_TIMERS=y
> > +CONFIG_VMSPLIT_2G=y
> >  CONFIG_SMP=y
> >  CONFIG_NR_CPUS=2
> >  CONFIG_AEABI=y
> 
> Is this related to CPU1 start address?

Yes, it's really only necessary when running the virtual simulator.

> 
> > +++ b/arch/arm/mach-socfpga/headsmp.S
> > @@ -13,13 +13,19 @@
> >  	__CPUINIT
> >  	.arch	armv7-a
> >  
> > -#define CPU1_START_ADDR 	        0xffd08010
> > -
> >  ENTRY(secondary_trampoline)
> > -	movw	r0, #:lower16:CPU1_START_ADDR
> > -	movt  r0, #:upper16:CPU1_START_ADDR
> > +	movw	r2, #:lower16:cpu1start_addr
> > +	movt  r2, #:upper16:cpu1start_addr
> >  
> > +	ldr	r0, [r2]
> >  	ldr	r1, [r0]
> >  	bx	r1
> >  
> >  ENTRY(secondary_trampoline_end)
> > +
> > +#ifdef CONFIG_SMP
> > +ENTRY(v7_secondary_startup)
> > +       bl      v7_invalidate_l1
> > +       b       secondary_startup
> > +ENDPROC(v7_secondary_startup)
> > +#endif
> 
> #ifdef should not be neccessary, as headsmp.S is only compiled when CONFIG_SMP. 
> 
> > +++ b/arch/arm/mach-socfpga/platsmp.c
> > @@ -49,7 +49,8 @@ static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct
> >  
> >  	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> >  
> > -	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
> > +	__raw_writel(virt_to_phys(v7_secondary_startup),
> > +		(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
> >  
> 
> The math is rather interesting here; is (sys_manager_base_addr +
> (cpu1start_addr & 0x000000ff)) == cpu1start_addr ?
> 
> > @@ -55,6 +56,16 @@ static void __init socfpga_scu_map_io(void)
> >  	iotable_init(&scu_io_desc, 1);
> >  }
> >  
> > +static void __init init_socfpga_vt(void)
> > +{
> > +	cpu1start_addr = 0xffd08010;
> > +}
> > +
> > +static void __init init_socfpga(void)
> > +{
> > +	cpu1start_addr = 0xffd080c4;
> > +}
> 
> Should this be put into device tree somewhere?
> 
> In addition, this patch seems to break operation in the emulator for
> me. In fact, it looks pretty much like emulator crash, with continuous
> scroll of
> 
> B_TRANSPORT::(R(Addr=0x23092FD0, Count=08 ...

Definitely make sure CONFIG_VMSPLIT_2G=y is set for the Virtual Target.

Dinh
> 
> [sorry, it is hard to copy moving messages].
> 
> I'm using kernel based on 3.7-rc2. Should I attempt updating?
> 
> Thanks,
> 									Pavel 
