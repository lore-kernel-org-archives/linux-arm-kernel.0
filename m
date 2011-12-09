From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 09 Dec 2011 18:05:35 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code
 checks for kprobes.
In-Reply-To: <20111209164029.GL5196@mudshark.cambridge.arm.com>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173212.7572.16210.stgit@localhost6.localdomain6>
 <20111209155450.GI5196@mudshark.cambridge.arm.com> <4EE234A8.80208@arm.com>
 <20111209164029.GL5196@mudshark.cambridge.arm.com>
Message-ID: <1323453935.14174.22.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-12-09 at 16:40 +0000, Will Deacon wrote:
> On Fri, Dec 09, 2011 at 04:17:44PM +0000, Leif Lindholm wrote:
> > On 12/09/11 15:54, Will Deacon wrote:
> > > On Thu, Dec 08, 2011 at 05:32:13PM +0000, Leif Lindholm wrote:
> > >> -static unsigned long test_check_cc(int cc, unsigned long cpsr)
> > >> +inline unsigned long test_check_cc(int cc, unsigned long cpsr)
> > >
> > > Not sure why you make this change, surely you can just leave it as static?
> > 
> > As the function is now only a wrapper on arm_check_condition (with an 
> > inline shift), it made more sense to me. This was also suggested by 
> > Tixy, and he's since ACKed this patch.
> 
> Hmm, I still don't see why you should change the linkage. Make it static
> inline if you really want the inline, but that seems weird outside of a
> header file stub.

As you pointed out later, it does need to be static, to avoid potential
linkage issues. (I always incorrectly imagine that 'inline' is a
glorified macro.)

> > > Maybe it's best just to change all of the callers to call
> > > arm_check_condition directly, like you have done below for the ARM case. For
> > > the Thumb cases will it work if you make sure that you put the condition
> > > code in the top bits?
> > 
> > Yes, that is functionally equivalent, and what I did in the RFC version, 
> > but it ended up looking messy at the calling point.
> 
> Ok, then could you route the ARM variant through the wrapper too?

The function Leif added is for checking the condition code in an ARM
instruction, so it doesn't need a wrapper when used for this.

The other locations in the kprobes tests get the condition nibble from
the ITSATE or from thumb conditional branch instructions. In these cases
the code looks cleaner if the condition is passed as a value between 0x0
and 0xf, rather than being shift up to bit position 28 where the
conditional ARM instructions have it encoded.

> > Any sane compiler should generate pretty identical code for these two 
> > alternative solutions (unless it neglected to auto-inline the static 
> > variant).
> 
> The problem is when somebody else decides to call test_check_cc from another
> compilation unit, rather than go through arm_check_condition.

-- 
Tixy
