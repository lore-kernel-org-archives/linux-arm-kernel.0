From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 09 Dec 2011 16:17:44 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code checks
 for kprobes.
In-Reply-To: <20111209155450.GI5196@mudshark.cambridge.arm.com>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173212.7572.16210.stgit@localhost6.localdomain6>
 <20111209155450.GI5196@mudshark.cambridge.arm.com>
Message-ID: <4EE234A8.80208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/11 15:54, Will Deacon wrote:
> On Thu, Dec 08, 2011 at 05:32:13PM +0000, Leif Lindholm wrote:
>> -static unsigned long test_check_cc(int cc, unsigned long cpsr)
>> +inline unsigned long test_check_cc(int cc, unsigned long cpsr)
>
> Not sure why you make this change, surely you can just leave it as static?

As the function is now only a wrapper on arm_check_condition (with an 
inline shift), it made more sense to me. This was also suggested by 
Tixy, and he's since ACKed this patch.

> Maybe it's best just to change all of the callers to call
> arm_check_condition directly, like you have done below for the ARM case. For
> the Thumb cases will it work if you make sure that you put the condition
> code in the top bits?

Yes, that is functionally equivalent, and what I did in the RFC version, 
but it ended up looking messy at the calling point.
Also, since in the other locations test_check_cc is actually used to 
check conditions for Thumb instructions (rather than ARM), it makes 
sense to me to wrap it behind something that doesn't appear to suggest 
otherwise.

Any sane compiler should generate pretty identical code for these two 
alternative solutions (unless it neglected to auto-inline the static 
variant).

/
     Leif
