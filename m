From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 16:52:23 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <AANLkTi=4=c0B3Qo+boguUw-DvEihBej5Zz_d2QWmoucm@mail.gmail.com>
References: <1294990949-2729-1-git-send-email-ccross@android.com>
	<AANLkTimqiqABxCejdeOQWZZ62DVUZW2v-yMpdu1aNDQT@mail.gmail.com>
	<20110114120229.GA15996@n2100.arm.linux.org.uk>
	<1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<AANLkTi=4=c0B3Qo+boguUw-DvEihBej5Zz_d2QWmoucm@mail.gmail.com>
Message-ID: <20110114165222.GI15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 10:24:52AM -0600, Dave Martin wrote:
> Is the comment preceding __und_usr_unknown causing some confusion here?
> 
> /*
>  * The FP module is called with these registers set:
>  *  r0  = instruction
>  *  r2  = PC+4
>  ...
> 
> That reflects the ARM case only: for Thumb, r2 is always PC+2 (?)

Actually, referring to 'PC' here is confusing (and yes, I probably wrote
it) - does 'PC' refer to the address of the faulting instruction or the
current PC value...

Your '(?)' there is exactly the problem I'm referring to - I don't think
there's much of a clear idea really what's going on here...

> The comment at the start of do_undefinstr() (which receives these
> registers) is correct though:
> 
> 	/*
> 	 * According to the ARM ARM, PC is 2 or 4 bytes ahead,
> 	 * depending whether we're in Thumb mode or not.
> 	 * Correct this offset.

The ARM ARM says that in order to return to the instruction which
generated the exception, subtract 2 bytes for thumb or 4 bytes for
ARM.

So, in order to point at the instruction which generated the exception,
we have to subtract this value from the PC value we were passed.  I
suggest changing this comment to:

	/*
	 * According to the ARM ARM, the PC is 2 or 4 bytes ahead
	 * depending on Thumb mode.  Correct this offset so that
	 * regs->ARM_pc points at the faulting instruction.
	 */
