From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 17:24:19 +0000
Subject: [RFC PATCH] arm64: fault: Don't populate ESR context for user
 fault on kernel VA
In-Reply-To: <20180305140506.GJ32331@e103592.cambridge.arm.com>
References: <1520245875-32527-1-git-send-email-will.deacon@arm.com>
 <20180305140506.GJ32331@e103592.cambridge.arm.com>
Message-ID: <20180305172418.GD12869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 02:05:06PM +0000, Dave Martin wrote:
> On Mon, Mar 05, 2018 at 10:31:15AM +0000, Will Deacon wrote:
> > User faults on kernel addresses are a good sign that the faulting task
> > is either up to no good or is in deep trouble. In such situations,
> > exposing the optional ESR context on the sigframe as part of the
> > delivered signal is only useful to attackers who are using information
> > about underlying hardware fault (e.g. translation vs permission) as a
> > mechanism to defeat KASLR.
> > 
> > Remove the ESR context from the sigframe for user faults on kernel
> > addresses.
> 
> As this wording suggests, this change causes esr_context to disappear
> entirely from the signal frame.  Previously, I think user code could
> have relied on its being present for certain signals.
> 
> Does Debian's codesearch throw up any nontrivial users of esr_context?

The main one seems to be ASAN, which uses the RnW bit to report "READ",
"WRITE" or "UNKNOWN". So with this change, the access will be treated as
UNKNOWN for kernel addresses.

Whilst I can see how that might cause a testsuite regression, I'm struggling
to see how it could sensible impact ASAN given that userspace never has
permission to access these addresses and so the fault should be treated as
fatal regardless of whether or not it's a read or a write.

Will
