From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 14:06:10 +0000
Subject: [PATCH] arm: kprobes: Align stack to 8-bytes in test code
In-Reply-To: <1489755542.3063.2.camel@linaro.org>
References: <20170316135359.23019-1-tixy@linaro.org>
 <20170317121025.GD21222@n2100.armlinux.org.uk>
 <1489755542.3063.2.camel@linaro.org>
Message-ID: <20170317140610.GF21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 12:59:02PM +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2017-03-17 at 12:10 +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 16, 2017 at 01:53:59PM +0000, Jon Medhurst wrote:
> > > Without this fix, some test cases will generate alignment faults on
> > > systems where alignment is enforced. Even if the kernel is configured to
> > > handle these faults in software, triggering them is ugly. It also
> > > exposes limitations in the fault handling code which doesn't cope with
> > > writes to the stack. E.g. when handling this instruction
> > > 
> > >    strd r6, [sp, #-64]!
> > > 
> > > the fault handling code will write to a stack location below the SP
> > > value at the point the fault occurred, which coincides with where the
> > > exception handler has pushed the saved register context. This results in
> > > corruption of those registers.
> > 
> > The general rule today is that the stack must always be 64-bit aligned,
> > so an even number of registers must always be pushed to the stack.
> > 
> > > diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
> > > index c893726aa52d..1c98a87786ca 100644
> > > --- a/arch/arm/probes/kprobes/test-core.c
> > > +++ b/arch/arm/probes/kprobes/test-core.c
> > > @@ -977,7 +977,10 @@ static void coverage_end(void)
> > >  void __naked __kprobes_test_case_start(void)
> > >  {
> > >  	__asm__ __volatile__ (
> > > -		"stmdb	sp!, {r4-r11}				\n\t"
> > > +		"mov	r2, sp					\n\t"
> > > +		"bic	r3, r2, #7				\n\t"
> > > +		"mov	sp, r3					\n\t"
> > > +		"stmdb	sp!, {r2-r11}				\n\t"
> > 
> > I'm not sure these is where the problem is - on entry, the stack
> > should be 64-bit aligned
> 
> It isn't, because GCC turns code like this
> 
> void foo(void)
> {
>         asm volatile("bl __kprobes_test_case_start"
>                      : : : "r0", "r1", "r2", "r3", "ip", "lr", "memory", "cc");
> }
> 
> into this...
> 
> 8010e4ac <foo>:
> 8010e4ac:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
> 8010e4b0:       eb002c99        bl      8011971c <__kprobes_test_case_start>
> 8010e4b4:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
> 
> Perhaps we need a way of telling GCC we are using the stack but I've not
> managed to spot a way of doing that.

Using which compiler options?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
