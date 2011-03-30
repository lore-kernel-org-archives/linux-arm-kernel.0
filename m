From: tixy@yxit.co.uk (Tixy)
Date: Wed, 30 Mar 2011 16:52:20 +0100
Subject: [PATCH] Reject kprobes when Rn==15 and writeback is set
In-Reply-To: <1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
References: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
	<1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
Message-ID: <1301500340.2488.127.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-30 at 16:42 +0300, Viktor Rosendahl wrote:
> On 03/29/2011 09:44 PM, ext Nicolas Pitre wrote:
>  > On Tue, 29 Mar 2011, Russell King - ARM Linux wrote:
>  >
>  >> On Tue, Mar 29, 2011 at 12:55:27PM -0400, Nicolas Pitre wrote:
>  >>> Sorry, I meant r15-indexed with a write back.
>  >>
>  >> I believe that's unpredictable.  So actually you can make kprobes do
>  >> anything you like with it - no one should ever generate an instruction
>  >> which read-modify-writes the PC.
>  >
>  > Indeed.  Hence my suggestion to simply refuse and abort the placement of
>  > a probe on such instructions and keep the actual emulation code free of
>  > tests for those odd cases.  In practice this shouldn't affect anyone.
>  >
> 
> Here is a patch for implementing the rejection of probes on those instructions,
> with Rn == 15 and writeback enabled. Those previous patches are still
> required, since they fix the emulation of the fully legal instructions where
> Rn == 15 and writeback isn't enabled.

I think this could be a slippery slope, what about the other dubious
combinations, like writeback when Rn==Rt, or when Rm==pc? By the same
rationale we should check for those to.

If we start littering the code with all these extra checks we risk
introducing bugs and making the code more difficult to maintain.

In my opinion we should not add any extra code to handle instructions
combinations that the ARM ARM says are UNPREDICTABLE, or have fields
which are SBZ/SBO. The toolchain shouldn't ever generate these bad
instructions in which case the extra kprobes code is redundant.

-- 
Tixy
