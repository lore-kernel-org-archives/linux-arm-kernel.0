From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 2 Oct 2013 14:05:50 +0100
Subject: [PATCH 3/6] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <alpine.LFD.2.03.1310011451390.21228@syhkavp.arg>
References: <1380644227-12244-1-git-send-email-v.tyrtov@samsung.com>
 <1380644227-12244-4-git-send-email-v.tyrtov@samsung.com>
 <alpine.LFD.2.03.1310011451390.21228@syhkavp.arg>
Message-ID: <20131002130550.GB3407@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 03:55:24PM -0400, Nicolas Pitre wrote:
> On Tue, 1 Oct 2013, Vyacheslav Tyrtov wrote:
> 
> > From: Tarek Dakhran <t.dakhran@samsung.com>

[...]

> > +	kfs_use_count[cpu][cluster]++;
> > +	if (kfs_use_count[cpu][cluster] == 1) {
> > +		++core_count[cluster];
> > +		if (core_count[cluster] == 1) {
> > +			ret = exynos_cluster_power_up(cluster);
> > +			if (ret) {
> > +				pr_err("%s: cluster %u power up error\n",
> > +					__func__, cluster);
> > +				return ret;
> > +			}
> > +			__cci_control_port_by_index(MAX_NR_CLUSTERS
> > +					 - cluster, true);
> 
> This is wrong and very racy.  The state machine implemented in 
> mcpm-head.S is there already to handle proper synchronization for you.  

Maybe this issue didn't make itself obvious yet due to the lack of
suspend support.

Moving the CCI maintenance to power_up_setup() is essential for suspend/
resume to work, because then CPUs can power up randomly in response to
interrupts -- exynos_lock is not sufficient protection in that case.

The TC2 code should provide a good example of what to do.

[...]

Cheers
---Dave
