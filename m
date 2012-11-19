From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 Nov 2012 22:12:10 -0500
Subject: [PATCH V3 4/5] arm: mm: Added support for PJ4B cpu and init
 routines
In-Reply-To: <50A6B427.9080807@free-electrons.com>
References: <1352931637-3405-1-git-send-email-gregory.clement@free-electrons.com>
 <1352931637-3405-5-git-send-email-gregory.clement@free-electrons.com>
 <50A41BD3.9040509@free-electrons.com>
 <50A6B427.9080807@free-electrons.com>
Message-ID: <20121119031210.GD22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:46:15PM +0100, Gregory CLEMENT wrote:
> On 11/14/2012 11:31 PM, Gregory CLEMENT wrote:
> > Hello Russell,
> > 
> > With the 2 changes I have done on according your comments
> > do you think you can give your acked-by for this patch?
> > 
> 
> Hello Russell,
> 
> I didn't have any feedback from you for this version.
> If you are fine with this, could you give your Acked-by?
> 
> 

Gregory,

>From the looks of things, Russell has his head wrapped around buggy
sound driver code for the CuBox.  Perhaps Will Deacon or Catalin Marinas
would care to weigh in?  I'm reluctant to take the series without an
Acked-By from at least one of them.

thx,

Jason.

> 
> > On 11/14/2012 11:20 PM, Gregory CLEMENT wrote:
> >> From: Yehuda Yitschak <yehuday@marvell.com>
> >>
> >> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  arch/arm/mach-mvebu/Kconfig |    2 +-
> >>  arch/arm/mm/Kconfig         |    4 ++++
> >>  arch/arm/mm/proc-v7.S       |   51 +++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 56 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> >> index 17d246b..9bfaa0c 100644
> >> --- a/arch/arm/mach-mvebu/Kconfig
> >> +++ b/arch/arm/mach-mvebu/Kconfig
> >> @@ -22,7 +22,7 @@ config MVEBU_CLK_CPU
> >>  config MACH_ARMADA_370_XP
> >>  	bool
> >>  	select ARMADA_370_XP_TIMER
> >> -	select CPU_V7
> >> +	select CPU_PJ4B
> >>  
> >>  config MACH_ARMADA_370
> >>  	bool "Marvell Armada 370 boards"
> >> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> >> index 94186b6..3fd629d 100644
> >> --- a/arch/arm/mm/Kconfig
> >> +++ b/arch/arm/mm/Kconfig
> >> @@ -352,6 +352,10 @@ config CPU_PJ4
> >>  	select ARM_THUMBEE
> >>  	select CPU_V7
> >>  
> >> +config CPU_PJ4B
> >> +	bool
> >> +	select CPU_V7
> >> +
> >>  # ARMv6
> >>  config CPU_V6
> >>  	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> >> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> >> index 846d279..a4c0ccf 100644
> >> --- a/arch/arm/mm/proc-v7.S
> >> +++ b/arch/arm/mm/proc-v7.S
> >> @@ -169,6 +169,47 @@ __v7_ca15mp_setup:
> >>  	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
> >>  	mcreq	p15, 0, r0, c1, c0, 1
> >>  #endif
> >> +
> >> +__v7_pj4b_setup:
> >> +#ifdef CONFIG_CPU_PJ4B
> >> +
> >> +#define SNOOP_DATA    (1 << 25) /* Dont interleave write and snoop data */
> >> +#define CWF           (1 << 27) /* Disable Critical Word First feature */
> >> +#define OUTSANDING_NC (1 << 29) /* Disable outstanding non cacheable request */
> >> +#define L1_REP_RR     (1 << 30) /* L1 replacement - Strict round robin */
> >> +
> >> +#define AUX_DBG_CTRL2 (SNOOP_DATA | CWF | OUTSANDING_NC | L1_REP_RR)
> >> +
> >> +	/* Auxiliary Debug Modes Control 1 Register */
> >> +	mrc	p15, 1,	r0, c15, c1, 1
> >> +	orr     r0, r0, #(1 << 16)     @ Disable data transfer for clean line.
> >> +	orr     r0, r0, #(1 << 5)      @ Enable the back off of STREX instr
> >> +	orr     r0, r0, #(1 << 8)      @ Disable Internal Parity Handling
> >> +	bic	r0, r0, #(1 << 2)      @ Disable Static BP
> >> +	mcr	p15, 1,	r0, c15, c1, 1
> >> +
> >> +	/* Auxiliary Debug Modes Control 2 Register */
> >> +	mrc	p15, 1,	r0, c15, c1, 2
> >> +	bic	r0, r0, #(1 << 23)   @ Enable fast LDR.
> >> +	orr	r0, r0, #AUX_DBG_CTRL2
> >> +	mcr	p15, 1,	r0, c15, c1, 2
> >> +
> >> +	/* Auxiliary Functional Modes Control Register 0 */
> >> +	mrc	p15, 1,	r0, c15, c2, 0
> >> +#ifdef CONFIG_SMP
> >> +	orr	r0, r0, #(1 << 1)     @ Set SMP mode. Join the coherency fabric
> >> +#endif
> >> +	orr	r0, r0, #(1 << 2)     @ Support L1 parity checking
> >> +	orr	r0, r0, #(1 << 8)     @ Broadcast Cache and TLB maintenance
> >> +	mcr	p15, 1,	r0, c15, c2, 0
> >> +
> >> +	/* Auxiliary Debug Modes Control 0 Register */
> >> +	mrc	p15, 1,	r0, c15, c1, 0
> >> +	orr	r0, r0, #(1 << 22)   @ WFI/WFE - serve the DVM and back to idle
> >> +	mcr	p15, 1,	r0, c15, c1, 0
> >> +
> >> +#endif /* CONFIG_CPU_PJ4B */
> >> +
> >>  __v7_setup:
> >>  	adr	r12, __v7_setup_stack		@ the local stack
> >>  	stmia	r12, {r0-r5, r7, r9, r11, lr}
> >> @@ -342,6 +383,16 @@ __v7_ca9mp_proc_info:
> >>  	.long	0xff0ffff0
> >>  	__v7_proc __v7_ca9mp_setup
> >>  	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
> >> +
> >> +	/*
> >> +	 * Marvell PJ4B processor.
> >> +	 */
> >> +	.type   __v7_pj4b_proc_info, #object
> >> +__v7_pj4b_proc_info:
> >> +	.long	0x562f5840
> >> +	.long	0xfffffff0
> >> +	__v7_proc __v7_pj4b_setup
> >> +	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
> >>  #endif	/* CONFIG_ARM_LPAE */
> >>  
> >>  	/*
> >>
> > 
> > 
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
