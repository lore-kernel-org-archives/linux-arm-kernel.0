From: premi@ti.com (Premi, Sanjeev)
Date: Fri, 24 Jun 2011 16:18:31 +0530
Subject: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy	calculation
In-Reply-To: <20110624104331.GK9449@n2100.arm.linux.org.uk>
References: <1308911742-27394-1-git-send-email-premi@ti.com>
	<1308911742-27394-3-git-send-email-premi@ti.com>
	<20110624104331.GK9449@n2100.arm.linux.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2DD9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> Sent: Friday, June 24, 2011 4:14 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation
> 
> On Fri, Jun 24, 2011 at 04:05:42PM +0530, Sanjeev Premi wrote:
> > Currently, loops_per_jiffy is being calculated before calling
> > cpufreq_notify_transition().
> > 
> > However, generic cpufreq driver adjusts the jiffies as well.
> > Double adjustment leads to incorrect value being assigned to
> > loops_per_jiffy.
> 
> Are you sure the generic cpufreq driver adjusts the per-cpu 
> loops_per_jiffy
> values?  I don't believe it does.

Russell,

I am quoting the function from drivers/cpufreq/cpufreq.h
Follow the arrows:

[quote]
void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
{
      [snip]...[snip]

	case CPUFREQ_PRECHANGE:

	      [snip]...[snip]
		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
				CPUFREQ_PRECHANGE, freqs);
---->		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
		break;

	case CPUFREQ_POSTCHANGE:
---->		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
	      [snip]...[snip]
	}
}
[/quote]

Same can be viewed here:
http://lxr.free-electrons.com/source/drivers/cpufreq/cpufreq.c?a=arm#L300


~sanjeev

[snip]...[snip]
