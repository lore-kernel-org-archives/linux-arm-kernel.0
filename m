From: dyoung@redhat.com (Dave Young)
Date: Fri, 11 Jul 2014 17:47:48 +0800
Subject: [PATCH 7/8] arm64/kexec: Add core kexec support
In-Reply-To: <20140707073337.GA1108@dhcp-16-198.nay.redhat.com>
References: <cover.1399594544.git.geoff@infradead.org>
 <64ef27888fa70b3e27ddcf4ca594fa71ab7f7777.1399594544.git.geoff@infradead.org>
 <20140707073337.GA1108@dhcp-16-198.nay.redhat.com>
Message-ID: <20140711094747.GA16936@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/14 at 03:33pm, Dave Young wrote:
> [snip]
> 
> > +
> > +/**
> > + * kexec_cpu_info_init - Initialize an array of kexec_cpu_info structures.
> > + *
> > + * Allocates a cpu info array and fills it with info for all cpus found in
> > + * the device tree passed.  The cpu info array is zero terminated.
> > + */
> > +
> > +int kexec_cpu_info_init(const struct device_node *dn,
> > +	struct kexec_dt_info *info)
> > +{
> > +	int result;
> > +	unsigned int cpu;
> > +	const struct device_node *i;
> > +
> > +	info->cpu_info = kmalloc(
> > +		(1 + info->cpu_count) * sizeof(struct kexec_cpu_info),
> > +		GFP_KERNEL);
> > +
> > +	if (!info->cpu_info) {
> > +		pr_debug("%s: out of memory", __func__);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	info->spinner_count = 0;
> > +
> > +	for (cpu = 0, i = dn; cpu < info->cpu_count; cpu++) {
> > +		struct kexec_cpu_info *cpu_info = &info->cpu_info[cpu];
> > +
> > +		i = of_find_node_by_type((struct device_node *)i, "cpu");
> > +
> > +		BUG_ON(!i);
> > +
> > +		cpu_info->cpu = cpu;
> > +
> > +		result = cpu_read_ops((struct device_node *)i, cpu,
> > +			&cpu_info->cpu_ops);
> 
> cpu_ops memory is not allocated?

Oops, I misread the code, it should be not a problem. Just ignore above comment

But I surely have some problem, probably caused by some random issues. 

> 
> BTW cpu_read_ops will call cpu_get_ops which is marked as __init
> 
> Thanks
> Dave
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
