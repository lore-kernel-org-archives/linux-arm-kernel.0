From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 3 Oct 2011 15:32:39 +0100
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <4E7DA3C0.7000208@stericsson.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
	<20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
	<4E7DA3C0.7000208@stericsson.com>
Message-ID: <20111003143239.GC2117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 11:32:48AM +0200, Per F?rlin wrote:
> On 09/24/2011 10:13 AM, Mika Westerberg wrote:
> > On Sat, Sep 24, 2011 at 10:02:50AM +0200, Per Forlin wrote:
> >> PC runs virtual addresses when calling cpu_v7_reset(). The MMU
> >> is switched off and "mov pc, r0" sets pc back to
> >> virtual addresses even though the MMU is switched off.
> >> This will result in a crash if the pipeline delay after
> >> MMU disable is one instruction. To prevent this set PC
> >> to physical addresses before disabling the MMU.
> >>
> >> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> >> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> >> ---
> >>  arch/arm/mm/proc-v7.S |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> >> index 9049c07..f26e831 100644
> >> --- a/arch/arm/mm/proc-v7.S
> >> +++ b/arch/arm/mm/proc-v7.S
> >> @@ -64,6 +64,7 @@ ENDPROC(cpu_v7_proc_fin)
> >>   */
> >>  	.align	5
> >>  ENTRY(cpu_v7_reset)
> >> +	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses
> > 
> > This only works on machines where PHYS_OFFSET is zero.
> > 
> You are right! Russell was very quick to point out the same thing. 

For reference, I'll also point out that except for "mov pc,<Rm>", 
almost no instruction involving an explicit reference to the pc will
safely do what you want in Thumb-2 kernels, due to the variable instruction
size.

Cheers
---Dave
