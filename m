From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 20 Sep 2011 09:27:01 -0400 (EDT)
Subject: [PATCH] arm: Add unwinding annotations for 64bit division
	functions
In-Reply-To: <2285dff3fee56758b6279062a5a30dc7.squirrel@www.codeaurora.org>
References: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
	<alpine.LFD.2.00.1109191913210.12663@xanadu.home>
	<2285dff3fee56758b6279062a5a30dc7.squirrel@www.codeaurora.org>
Message-ID: <alpine.LFD.2.00.1109200922281.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2011, Laura Abbott wrote:

> 
> On Mon, September 19, 2011 4:22 pm, Nicolas Pitre wrote:
> > On Mon, 19 Sep 2011, Laura Abbott wrote:
> >
> >> The 64bit division functions never had unwinding annotations
> >> added. This prevents a backtrace from being printed within
> >> the function and if a division by 0 occurs. Add the annotations.
> >>
> >> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >> ---
> >>  arch/arm/lib/div64.S |    8 ++++++++
> >>  1 files changed, 8 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
> >> index faa7748..e55c484 100644
> >> --- a/arch/arm/lib/div64.S
> >> +++ b/arch/arm/lib/div64.S
> >> @@ -13,6 +13,7 @@
> >>   */
> >>
> >>  #include <linux/linkage.h>
> >> +#include <asm/unwind.h>
> >>
> >>  #ifdef __ARMEB__
> >>  #define xh r0
> >> @@ -44,6 +45,7 @@
> >>   */
> >>
> >>  ENTRY(__do_div64)
> >> +UNWIND(.fnstart)
> >>
> >>  	@ Test for easy paths first.
> >>  	subs	ip, r4, #1
> >> @@ -189,7 +191,12 @@ ENTRY(__do_div64)
> >>  	moveq	yh, xh
> >>  	moveq	xh, #0
> >>  	moveq	pc, lr
> >> +UNWIND(.fnend)
> >>
> >> +UNWIND(.fnstart)
> >> +UNWIND(.pad #4)
> >> +UNWIND(.save {lr})
> >> +Ldiv0_64:
> >
> > Why this phony fnend+fnstart here?
> >
> If a division by 0 occurs, we need to be able to access the saved LR on
> the stack which is setup right before calling the __div0 function. This
> can't go at the top of __do_div64 because if we try to do a backtrace from
> within __do_div64 the annotation won't be correct as the LR was never
> saved on the stack.

I suppose the debug infrastructure always assume the same stack frame 
for the whole function, hence you can't put that .pad and .save right 
before the call to __div0 without the .fnstart and have it effective 
only there?

If so then:

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
