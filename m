From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Jan 2013 12:25:47 +0000
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <50F10EF4.9070909@ti.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
 <50F059A4.4010107@ti.com>
 <alpine.LFD.2.02.1301111425020.6300@xanadu.home>
 <50F10EF4.9070909@ti.com>
Message-ID: <20130114122547.GA21142@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 07:21:24AM +0000, Santosh Shilimkar wrote:
> On Saturday 12 January 2013 12:58 AM, Nicolas Pitre wrote:
> > On Fri, 11 Jan 2013, Santosh Shilimkar wrote:
> >
> >> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> >>> From: Dave Martin <dave.martin@linaro.org>
> >>>
> >>> +		/*
> >>> +		 * Flush the local CPU cache.
> >>> +		 *
> >>> +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> >>> +		 * a preliminary flush here for those CPUs.  At least, that's
> >>> +		 * the theory -- without the extra flush, Linux explodes on
> >>> +		 * RTSM (maybe not needed anymore, to be investigated).
> >>> +		 */
> >> This is expected if the entire code is not in one stack frame and the
> >> additional flush is needed to avoid possible stack corruption. This
> >> issue has been discussed in past on the list.
> >
> > I missed that.  Do you have a reference or pointer handy?
> >
> > What is strange is that this is 100% reproducible on RTSM while this
> > apparently is not an issue on real hardware so far.
> >
> I tried searching archives and realized the discussion was in private
> email thread. There are some bits and pieces on list but not all the
> information.
> 
> The main issue RMK pointed out is- An additional L1 flush needed
> to avoid the effective change of view of memory when the C bit is
> turned off, and the cache is no longer searched for local CPU accesses.
> 
> In your case dcscb_power_down() has updated the stack which can be hit
> in cache line and hence cache is dirty now. Then cpu_proc_fin() clears
> the C-bit and hence for sub sequent calls the L1 cache won't be
> searched. You then call flush_cache_all() which again updates the
> stack but avoids searching the L1 cache. So it overwrites previous
> saved stack frame. This seems to be an issue in your case as well.

On A15/A7 even with the C bit cleared the D-cache is searched, the
situation above cannot happen and if it does we are facing a HW/model bug.
If this code is run on A9 then we have a problem since there, when the C bit
is cleared D-cache is not searched (and that's why the sequence above
should be written in assembly with no data access whatsoever), but on
A15/A7 we do not.

I have been running this code on TC2 for hours on end with nary a problem.

The sequence:

- clear C bit
- clean D-cache
- exit SMP

must be written in assembly with no data access whatsoever to make it
portable across v7 implementations. I think I will write some docs and
add them to the kernel to avoid further discussion on this topic.

FYI, the thread Santosh mentioned:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/099791.html

Lorenzo
