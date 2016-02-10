From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 18:15:22 +0000
Subject: [PATCH] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <56BB7C91.5010205@caviumnetworks.com>
References: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
 <20160210092822.GA1052@arm.com>
 <56BB7C91.5010205@caviumnetworks.com>
Message-ID: <20160210181522.GW1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 10:08:17AM -0800, David Daney wrote:
> On 02/10/2016 01:28 AM, Will Deacon wrote:
> >On Tue, Feb 09, 2016 at 11:29:16AM -0800, David Daney wrote:
> >>From: Andrew Pinski <apinski@cavium.com>
> >>
> >>On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> >>instructions may cause the icache to become invalid if it contains
> >>data for a non-current ASID.
> >>
> >>This patch implements the workaround (which flushes the local icache
> >>when switching the mm) by using code patching.
> >
> >So, to be clear, is this "just" a performance problem as opposed to a
> >correctness issue?
> 
> No.  It is a correctness issue.  Without this workaround in place, userspace
> programs end up executing the wrong instructions, which leads to
> unpredictable behavior and program crashes.

Ok, so I think the description in the commit log isn't quite right. An
"invalid" line in i-cache simply means that it needs to be refetched.
What you're talking about sounds like data corruption.

I also don't understand how the workaround fixes things like TLBIs due
to copy-on-write faults triggered by another core. Also, what's the
interaction with virtual machines, or is the VMID not affected in the
same way as the ASID?

Sorry to be a pain on this, but we need to understand the issue well
enough to maintain the workaround in the future!

> >If so, do you have any numbers with and without this
> >change?
> 
> We tried to measure it, but the impact is not measurable in the tests we
> have done.  Switching the mm is not often done so the extra ICache
> invalidation is rare.

Oh, sure. I was only interested in perf figures if this was a performance
problem rather than a functional one.

Will
