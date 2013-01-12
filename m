From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Jan 2013 12:51:24 +0530
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <alpine.LFD.2.02.1301111425020.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
 <50F059A4.4010107@ti.com> <alpine.LFD.2.02.1301111425020.6300@xanadu.home>
Message-ID: <50F10EF4.9070909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 January 2013 12:58 AM, Nicolas Pitre wrote:
> On Fri, 11 Jan 2013, Santosh Shilimkar wrote:
>
>> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
>>> From: Dave Martin <dave.martin@linaro.org>
>>>
>>> +		/*
>>> +		 * Flush the local CPU cache.
>>> +		 *
>>> +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
>>> +		 * a preliminary flush here for those CPUs.  At least, that's
>>> +		 * the theory -- without the extra flush, Linux explodes on
>>> +		 * RTSM (maybe not needed anymore, to be investigated).
>>> +		 */
>> This is expected if the entire code is not in one stack frame and the
>> additional flush is needed to avoid possible stack corruption. This
>> issue has been discussed in past on the list.
>
> I missed that.  Do you have a reference or pointer handy?
>
> What is strange is that this is 100% reproducible on RTSM while this
> apparently is not an issue on real hardware so far.
>
I tried searching archives and realized the discussion was in private
email thread. There are some bits and pieces on list but not all the
information.

The main issue RMK pointed out is- An additional L1 flush needed
to avoid the effective change of view of memory when the C bit is
turned off, and the cache is no longer searched for local CPU accesses.

In your case dcscb_power_down() has updated the stack which can be hit
in cache line and hence cache is dirty now. Then cpu_proc_fin() clears
the C-bit and hence for sub sequent calls the L1 cache won't be
searched. You then call flush_cache_all() which again updates the
stack but avoids searching the L1 cache. So it overwrites previous
saved stack frame. This seems to be an issue in your case as well.

Regards,
Santosh
