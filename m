From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Feb 2018 11:52:25 +0000
Subject: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
In-Reply-To: <7cab1b91545e81e4b6b09e85c2f81d7e@codeaurora.org>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
 <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
 <20180224084106.GC25201@hirez.programming.kicks-ass.net>
 <7cab1b91545e81e4b6b09e85c2f81d7e@codeaurora.org>
Message-ID: <20180227115224.rmtfy4eif3g4hmmr@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 05:53:57PM -0800, skannan at codeaurora.org wrote:
> On 2018-02-24 00:41, Peter Zijlstra wrote:
> > On Fri, Feb 23, 2018 at 04:19:38PM -0800, Saravana Kannan wrote:
> > > Some PMUs events can be read from any CPU. So allow the PMU to mark
> > > events as such. For these events, we don't need to reject reads or
> > > make smp calls to the event's CPU and cause unnecessary wake ups.
> > > 
> > > Good examples of such events would be events from caches shared across
> > > all CPUs.
> > 
> > So why would the existing ACTIVE_PKG not work for you? Because clearly
> > your example does not cross a package.
> 
> Because based on testing it on hardware, it looks like the two clusters in
> an ARM DynamIQ design are not considered part of the same "package". 

I don't think we should consider the topology masks at all for system
PMU affinity. Due to the number of ways these can be integrated, and the
lack of a standard(ish) topology across arm platforms.

IIUC, there's ongoing work to try to clean that up, but that won't give
us anything meaningful for PMU affinity.

If we need a mask, that should be something the FW description of the
PMU provides, and the PMU driver provides to the core code.

Thanks,
Mark.
