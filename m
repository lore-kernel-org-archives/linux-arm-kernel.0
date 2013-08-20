From: rientjes@google.com (David Rientjes)
Date: Mon, 19 Aug 2013 23:59:44 -0700 (PDT)
Subject: [RESEND PATCH 2/4] ARM: msm: Re-organize platsmp to make it
 extensible
In-Reply-To: <20130812155016.GC27165@e106331-lin.cambridge.arm.com>
References: <1375409725-22004-1-git-send-email-rvaswani@codeaurora.org>
 <1375409725-22004-3-git-send-email-rvaswani@codeaurora.org>
 <20130812155016.GC27165@e106331-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1308192357420.17575@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Mark Rutland wrote:

> >  static void __init msm_smp_prepare_cpus(unsigned int max_cpus)
> >  {
> > +	int cpu, map;
> > +	unsigned int flags = 0;
> > +
> > +	for_each_present_cpu(cpu) {
> > +		map = cpu_logical_map(cpu);
> > +		if (map > ARRAY_SIZE(cold_boot_flags)) {
> > +			set_cpu_present(cpu, false);
> > +			__WARN();
> > +			continue;
> > +		}
> > +		flags |= cold_boot_flags[map];

__WARN() can't be used in generic code because it's possible to have 
CONFIG_BUG=n, you probably want something like WARN_ON(1) instead.
