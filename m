From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Feb 2016 13:07:20 +0000
Subject: [PATCH] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <56BB848A.6060603@caviumnetworks.com>
References: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
 <20160210092822.GA1052@arm.com>
 <56BB7C91.5010205@caviumnetworks.com>
 <20160210181522.GW1052@arm.com>
 <56BB848A.6060603@caviumnetworks.com>
Message-ID: <20160211130720.GD32084@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thanks for the reply.

On Wed, Feb 10, 2016 at 10:42:18AM -0800, David Daney wrote:
> On 02/10/2016 10:15 AM, Will Deacon wrote:
> >On Wed, Feb 10, 2016 at 10:08:17AM -0800, David Daney wrote:
> >>On 02/10/2016 01:28 AM, Will Deacon wrote:
> >>>On Tue, Feb 09, 2016 at 11:29:16AM -0800, David Daney wrote:
> >>>>From: Andrew Pinski <apinski@cavium.com>
> >>>>
> >>>>On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> >>>>instructions may cause the icache to become invalid if it contains
> >>>>data for a non-current ASID.
> >>>>
> >>>>This patch implements the workaround (which flushes the local icache
> >>>>when switching the mm) by using code patching.
> >>>
> >>>So, to be clear, is this "just" a performance problem as opposed to a
> >>>correctness issue?
> >>
> >>No.  It is a correctness issue.  Without this workaround in place, userspace
> >>programs end up executing the wrong instructions, which leads to
> >>unpredictable behavior and program crashes.
> >
> >Ok, so I think the description in the commit log isn't quite right. An
> >"invalid" line in i-cache simply means that it needs to be refetched.
> >What you're talking about sounds like data corruption.
> 
> Yes.  I guess I will be sending v3 with an improved description.

Yes, please!

> >I also don't understand how the workaround fixes things like TLBIs due
> >to copy-on-write faults triggered by another core.
> 
> Caveat: I don't fully understand the internal ICache implementation details.
> But ...
> 
> External broadcast TLBIs arriving for the current ASID (as set in TTBR0_EL1)
> are handled properly.  The issue is that cached data for other ASIDs, under
> some circumstances, may be inadvertently "blessed" into the current ASID.
> If we take care that no data for "foreign" ASIDs is in the Icache, the
> problematical case can never occur.

Ok, that makes sense. Maybe include this in the description too.

> >Also, what's the
> >interaction with virtual machines, or is the VMID not affected in the
> >same way as the ASID?
> 
> Ah, the $10^6 question.  Current information on how this interacts with KVM
> is less well developed.  We think the workaround doesn't cause failures in
> virtual machines.
> 
> I realize that this is different than asserting that virtual machines are
> guaranteed to operate error free.

So, to confirm, we don't need to flush the I-cache on world-switch in
KVM?

Will
