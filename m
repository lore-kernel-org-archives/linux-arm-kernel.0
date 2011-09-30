From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 09:34:45 +0100
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <4E8555A5.9090304@stericsson.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
	<20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
	<4E7DA3C0.7000208@stericsson.com>
	<20110924110024.GA20044@e102144-lin.cambridge.arm.com>
	<4E7DD34E.3060402@stericsson.com>
	<20110924130202.GF17169@n2100.arm.linux.org.uk>
	<4E8555A5.9090304@stericsson.com>
Message-ID: <20110930083445.GA3895@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Per,

On Fri, Sep 30, 2011 at 06:37:41AM +0100, Per F?rlin wrote:
> On 09/24/2011 03:02 PM, Russell King - ARM Linux wrote:
> > On Sat, Sep 24, 2011 at 02:55:42PM +0200, Per F?rlin wrote:
> >> On 09/24/2011 01:00 PM, Will Deacon wrote:
> >>> On Sat, Sep 24, 2011 at 10:32:48AM +0100, Per F?rlin wrote:
> >>>> I am trying to figure out how I can get the value of PHYS_OFFSET in assembler code (proc-v7.S).
> >>>> I guess I could use the value calculated in arch/arm/kernel.head.S but wouldn't that make
> >>>> this patch dependent on CONFIG_ARM_PATCH_PHYS_VIRT?
> >>>
> >>> Wouldn't we just be better off passing a physical address to cpu_v7_reset
> >>> instead?
> >>>
> >> Good point! I'm fine with that.
> > 
> > Alternatively, call it using the phys address.
> I changed the code to use a label instead of the ARM specific instruction offset +4. A few more lines but the intention is that it should work with both ARM and THUMB. I'm in favour of Russell's idea of setting pc to physical before calling cpu_reset().
>       /* Go to physical addresses to be ready for MMU disable */
>       asm("ADR r1, pc_phy_here \n\t"
>           "sub r1, %0 \n\t"
>           "mov pc, r1 \n\t"
>           "pc_phy_here: \n\t"
>           : :"r" (PAGE_OFFSET - PHYS_OFFSET) : "r1", "cc");

I'm not sure why all of this is necessary. Take a look at my kexec patches
here:

http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/kexec-mmu-off

The interesting bit is __arm_machine_reset in kernel/process.c

Will
