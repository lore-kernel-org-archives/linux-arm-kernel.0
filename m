From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Dec 2011 16:40:29 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code
 checks for kprobes.
In-Reply-To: <4EE234A8.80208@arm.com>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173212.7572.16210.stgit@localhost6.localdomain6>
 <20111209155450.GI5196@mudshark.cambridge.arm.com>
 <4EE234A8.80208@arm.com>
Message-ID: <20111209164029.GL5196@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 04:17:44PM +0000, Leif Lindholm wrote:
> On 12/09/11 15:54, Will Deacon wrote:
> > On Thu, Dec 08, 2011 at 05:32:13PM +0000, Leif Lindholm wrote:
> >> -static unsigned long test_check_cc(int cc, unsigned long cpsr)
> >> +inline unsigned long test_check_cc(int cc, unsigned long cpsr)
> >
> > Not sure why you make this change, surely you can just leave it as static?
> 
> As the function is now only a wrapper on arm_check_condition (with an 
> inline shift), it made more sense to me. This was also suggested by 
> Tixy, and he's since ACKed this patch.

Hmm, I still don't see why you should change the linkage. Make it static
inline if you really want the inline, but that seems weird outside of a
header file stub.

> > Maybe it's best just to change all of the callers to call
> > arm_check_condition directly, like you have done below for the ARM case. For
> > the Thumb cases will it work if you make sure that you put the condition
> > code in the top bits?
> 
> Yes, that is functionally equivalent, and what I did in the RFC version, 
> but it ended up looking messy at the calling point.

Ok, then could you route the ARM variant through the wrapper too?

> Any sane compiler should generate pretty identical code for these two 
> alternative solutions (unless it neglected to auto-inline the static 
> variant).

The problem is when somebody else decides to call test_check_cc from another
compilation unit, rather than go through arm_check_condition.

Will
