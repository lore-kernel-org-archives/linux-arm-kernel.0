From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 8 Jun 2016 15:31:53 -0400
Subject: [RFC 1/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <5757D87E.2080508@arm.com>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <1465333713-14339-2-git-send-email-jon.mason@broadcom.com>
 <5757D87E.2080508@arm.com>
Message-ID: <20160608193003.GA17688@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:34:06AM +0100, Sudeep Holla wrote:
> 
> 
> On 07/06/16 22:08, Jon Mason wrote:
> >Query the CPU core clock in the device tree to determine the core clock
> >speed.
> 
> How do guarantee that it's the current frequency of the CPU ?

I am basing it on the assumption (perhaps incorrect) that the clock in
the CPU DT corresponds to the one determining the CPU clock rate.  And,
that this clock rate is accurate in describing the speed at which the
CPU is currently running.

> It doesn't even represent the mix or max frequency, so it's incorrect.
> Some DTs have boot frequency in that entry.
> 
> >Output this clock rate in /proc/cpuinfo to match the output
> >from other architectures.  The output is intentionally patterned after
> >the x86 output, to match existing (and possibly expected) convention.
> >
> >If any errors are encountered in querying the clock (or the speed is
> >erroneously zero), nothing will be printed out.  Thus any existing
> >devices that do not have CPU clocks defined in the device tree will
> >work as before.
> >
> 
> What if they just don't have in DT but have DVFS support ?

This can be extended to cover DVFS or SMC calls or anything else.
This was simply a first step to cover what appeared to be the most
prevalent case.

> Also whey do we need this support when the user-space can query the
> CPUFreq sysfs which is more accurate and maintains the current running
> frequency ?

This is exactly what x86 is doing to provide its value in
/proc/cpuinfo.  I could easily augment this patch to call
cpufreq_quick_get(), if it returns 0, then call clk_get_rate().  If
both return 0, then simply not print out anything (which would cover
all of the possibilities).  Or, I could have it just call
cpufreq_quick_get() to get the value.

Thanks,
Jon

> 
> -- 
> Regards,
> Sudeep
