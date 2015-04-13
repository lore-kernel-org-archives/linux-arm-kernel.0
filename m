From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 13 Apr 2015 22:47:24 +0800
Subject: [PATCH] ARM: alignment: Use is_wide_instruction() to check
 wide instruction
In-Reply-To: <20150413124832.GA15504@e103592.cambridge.arm.com>
References: <1428674741-5409-1-git-send-email-yingjoe.chen@mediatek.com>
 <20150413124832.GA15504@e103592.cambridge.arm.com>
Message-ID: <1428936444.7514.66.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-04-13 at 13:48 +0100, Dave Martin wrote:
> On Fri, Apr 10, 2015 at 10:05:41PM +0800, Yingjoe Chen wrote:
> > 
> > I first notice the comment is incorrect, then I realize there's another
> > macro which do exactly the same thing.
> > Tested with hand written userspace program with a few wide instructions
> > to make sure this still work as expect.
> > 
> > 8<-------------------------------------------------
> > do_alignment() is using locally added IS_T32() macro to check if an
> > instruction is a Thumb-2 32 bit instruction. The macro
> > is_wide_instruction() is doing the same thing, with slightly faster
> > implementation.
> > Change to use is_wide_instruction() in do_alignment() and remove
> > IS_T32().
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> The existing code is correct, but the comment is indeed wrong.
> Consolidating this with one of the other existing macros makes sense.
> 
> 
> !__opcode_is_thumb16() could also be used here (or is_wide_instruction()
> redefined in terms of it), but that's not essential.

Hi Dave,

Thanks for your review.

I did notice there are __opcode_is_thumb16/32. They need to handle
32bits instruction instead of 16bits only for is_wide_instruction, so I
think using same implementation for them is a different story.

Joe.C

> 
> Cheers
> ---Dave
> 
> > 
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >  arch/arm/mm/alignment.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> > index 2c0c541..f8e82f5 100644
> > --- a/arch/arm/mm/alignment.c
> > +++ b/arch/arm/mm/alignment.c
> > @@ -71,10 +71,6 @@
> >  
> >  #define BAD_INSTR 	0xdeadc0de
> >  
> > -/* Thumb-2 32 bit format per ARMv7 DDI0406A A6.3, either f800h,e800h,f800h */
> > -#define IS_T32(hi16) \
> > -	(((hi16) & 0xe000) == 0xe000 && ((hi16) & 0x1800))
> > -
> >  static unsigned long ai_user;
> >  static unsigned long ai_sys;
> >  static void *ai_sys_last_pc;
> > @@ -770,7 +766,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  		tinstr = __mem_to_opcode_thumb16(tinstr);
> >  		if (!fault) {
> >  			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
> > -			    IS_T32(tinstr)) {
> > +			    is_wide_instruction(tinstr)) {
> >  				/* Thumb-2 32-bit */
> >  				u16 tinst2 = 0;
> >  				fault = probe_kernel_address(ptr + 1, tinst2);
> > -- 
> > 1.8.1.1.dirty
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
