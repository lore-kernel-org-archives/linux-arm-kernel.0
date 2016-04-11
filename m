From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Apr 2016 11:06:10 +0100
Subject: [PATCH] arm64: erratum: Workaround for Kryo reserved system
 register read
In-Reply-To: <570B48F0.5020408@arm.com>
References: <1460044456-5297-1-git-send-email-nkaje@codeaurora.org>
 <57069977.5050205@arm.com> <570780D2.3060104@arm.com>
 <570786C9.6020804@arm.com> <570B48F0.5020408@arm.com>
Message-ID: <20160411100609.GE15729@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 07:49:20AM +0100, James Morse wrote:
> On 08/04/16 11:24, Marc Zyngier wrote:
> > On 08/04/16 10:58, Suzuki K Poulose wrote:
> >> On 07/04/16 18:31, Marc Zyngier wrote:
> >>
> >>>> +	All system register encodings above use the form
> >>>> +
> >>>> +	Op0, Op1, CRn, CRm, Op2.
> >>>> +
> >>>> +	Note that some of the encodings listed above include
> >>>> +	the system register space reserved for the following
> >>>> +	identification registers which may appear in future revisions
> >>>> +	of the ARM architecture beyond ARMv8.0.
> >>>> +	This space includes:
> >>>> +	ID_AA64PFR[2-7]_EL1
> >>>> +	ID_AA64DFR[2-3]_EL1
> >>>> +	ID_AA64AFR[2-3]_EL1
> >>>> +	ID_AA64ISAR[2-7]_EL1
> >>>> +	ID_AA64MMFR[2-7]_EL1
> >>
> >>
> >> AFAIK, the id space is unassigned. So the naming above could cause confusion
> >> if the register is named something else.
> > 
> > It is reserved *at the moment*, but already has a defined behaviour. My
> > worry is that when some new architecture revision comes around, we start
> > using these registers without thinking much about it (because we should
> > be able to). At this point, your SoC will catch fire and nobody will
> > have a clue about the problem because it is not apparent in the code.
> > 
> > I'd really like to see something a bit more forward looking that covers
> > that space for good.
> 
> At the risk of volunteering...
> Registering these instructions with the undef hooks would be ideal, but they
> won't catch this instruction abort. I guess refactor them to be generic faulting
> instruction hooks, and have a list for the existing undef cases, and a new one
> for this instruction abort.
> 
> This won't cover early code in head.S, or KVM code that runs at EL2. Is this
> sufficient, or should any approach cover those too?

I much prefer a trapping approach than trying to patch the instructions
accessing the ID registers. The ID registers are used to figure out which
alternatives need to be applied and having this circular dependency feels
particularly fragile.

So, we need to figure out (a) what sort of exceptions we're likely to
get and (b) what syndrome information is provided. In the worst case,
we'll end up disassembling the instruction stream (or using an ugly
out-of-line function to access system registers).

Will
