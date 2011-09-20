From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Sep 2011 15:57:45 +0100
Subject: [PATCH] arm: Add unwinding annotations for 64bit division
	functions
In-Reply-To: <alpine.LFD.2.00.1109200922281.12663@xanadu.home>
References: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
	<alpine.LFD.2.00.1109191913210.12663@xanadu.home>
	<2285dff3fee56758b6279062a5a30dc7.squirrel@www.codeaurora.org>
	<alpine.LFD.2.00.1109200922281.12663@xanadu.home>
Message-ID: <20110920145745.GG8545@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 02:27:01PM +0100, Nicolas Pitre wrote:
> On Mon, 19 Sep 2011, Laura Abbott wrote:
> > On Mon, September 19, 2011 4:22 pm, Nicolas Pitre wrote:
> > > On Mon, 19 Sep 2011, Laura Abbott wrote:
> > >> @@ -189,7 +191,12 @@ ENTRY(__do_div64)
> > >>  	moveq	yh, xh
> > >>  	moveq	xh, #0
> > >>  	moveq	pc, lr
> > >> +UNWIND(.fnend)
> > >>
> > >> +UNWIND(.fnstart)
> > >> +UNWIND(.pad #4)
> > >> +UNWIND(.save {lr})
> > >> +Ldiv0_64:
> > >
> > > Why this phony fnend+fnstart here?
> >
> > If a division by 0 occurs, we need to be able to access the saved LR on
> > the stack which is setup right before calling the __div0 function. This
> > can't go at the top of __do_div64 because if we try to do a backtrace from
> > within __do_div64 the annotation won't be correct as the LR was never
> > saved on the stack.
> 
> I suppose the debug infrastructure always assume the same stack frame 
> for the whole function, hence you can't put that .pad and .save right 
> before the call to __div0 without the .fnstart and have it effective 
> only there?

An element in the unwinding table contains a pointer to the .fnstart
location and a set of instruction bytecodes (like .save) to the next
.fnend statement. If more 4 bytecodes (to fit in an int), it contains an
index to another table with more bytecodes. The elements in the
unwinding table are sorted by the .fnstart address.

So I think in the above case if we don't have the .fnend/.fnstart for
Ldiv0_64 we would get all the instructions in the __do_div64 unwinding
information. I don't think the unwinding bytecode is that smart to allow
other tricks like checking some conditions.

Unless anyone has a better idea to specify this:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
