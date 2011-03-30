From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Mar 2011 13:59:45 -0400 (EDT)
Subject: [PATCH] Reject kprobes when Rn==15 and writeback is set
In-Reply-To: <1301500340.2488.127.camel@computer2.home>
References: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
	<1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301500340.2488.127.camel@computer2.home>
Message-ID: <alpine.LFD.2.00.1103301328280.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2011, Tixy wrote:

> On Wed, 2011-03-30 at 16:42 +0300, Viktor Rosendahl wrote:
> > On 03/29/2011 09:44 PM, ext Nicolas Pitre wrote:
> >  > On Tue, 29 Mar 2011, Russell King - ARM Linux wrote:
> >  >
> >  >> On Tue, Mar 29, 2011 at 12:55:27PM -0400, Nicolas Pitre wrote:
> >  >>> Sorry, I meant r15-indexed with a write back.
> >  >>
> >  >> I believe that's unpredictable.  So actually you can make kprobes do
> >  >> anything you like with it - no one should ever generate an instruction
> >  >> which read-modify-writes the PC.
> >  >
> >  > Indeed.  Hence my suggestion to simply refuse and abort the placement of
> >  > a probe on such instructions and keep the actual emulation code free of
> >  > tests for those odd cases.  In practice this shouldn't affect anyone.
> >  >
> > 
> > Here is a patch for implementing the rejection of probes on those instructions,
> > with Rn == 15 and writeback enabled. Those previous patches are still
> > required, since they fix the emulation of the fully legal instructions where
> > Rn == 15 and writeback isn't enabled.
> 
> I think this could be a slippery slope, what about the other dubious
> combinations, like writeback when Rn==Rt, or when Rm==pc? By the same
> rationale we should check for those to.
> 
> If we start littering the code with all these extra checks we risk
> introducing bugs and making the code more difficult to maintain.
> 
> In my opinion we should not add any extra code to handle instructions
> combinations that the ARM ARM says are UNPREDICTABLE, or have fields
> which are SBZ/SBO. The toolchain shouldn't ever generate these bad
> instructions in which case the extra kprobes code is redundant.

There are two categories to consider for such issues:

1) What to do with any writeback to pc.  This is really important 
   because this directly affects the running thread and determines where
   execution will resume once the probe is done.  Any dubious case 
   should be carefully intercepted, otherwise this may become a 
   potential security risk.  So, given that this has to be handled
   somehow, I think it is best to simply refuse the placement of a probe
   on a dubious instruction rather than working around the dubiousness in
   the actual emulation code.

2) What to do with any other undefined combinations.  Well, anything 
   else that is defined as unpredictable by the ARM ARM which doesn't 
   involve writing the pc should simply pass through the emulation code 
   without incuring any additional overhead or special care.  By definition,
   if the result is unpredictable, we can emulate it the way we wish and
   any discrepancy with native hardware result is unimportant.

In the first category can be found things like:

	ldmdb	pc!, {r0, r1, r2}

In the second category would be:

	ldmdb	pc, {r0, r1, r2}

We can safely ignore the second case, but the first case clearly has the 
potential for trouble if mis-emulated.  And trying to correctly emulate 
any of those cases is worthless.


Nicolas
