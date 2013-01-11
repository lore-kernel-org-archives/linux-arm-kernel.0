From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 10:58:36 +0000
Subject: [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
In-Reply-To: <alpine.LFD.2.02.1301102055320.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-3-git-send-email-nicolas.pitre@linaro.org>
 <20130110230854.GC11628@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301102055320.6300@xanadu.home>
Message-ID: <20130111105836.GD12977@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 02:30:06AM +0000, Nicolas Pitre wrote:
> On Thu, 10 Jan 2013, Will Deacon wrote:
> > On Thu, Jan 10, 2013 at 12:20:37AM +0000, Nicolas Pitre wrote:
> > > +int bL_cpu_power_up(unsigned int cpu, unsigned int cluster)
> > > +{
> > > +	if (!platform_ops)
> > > +		return -EUNATCH;
> > 
> > Is this the right error code?
> 
> It is as good as any other, with some meaning to be distinguished from 
> the traditional ones like -ENOMEM or -EINVAL that the platform backends 
> could return.
> 
> Would you prefer another one?

-ENODEV? Nothing to lose sleep over though.

> > > +	might_sleep();
> > > +	return platform_ops->power_up(cpu, cluster);
> > > +}
> > > +
> > > +typedef void (*phys_reset_t)(unsigned long);
> > 
> > Maybe it's worth putting this typedef in a header file somewhere. It's
> > also used by the soft reboot code.
> 
> Agreed.  Maybe separately from this series though.
> 
> > > +
> > > +void bL_cpu_power_down(void)
> > > +{
> > > +	phys_reset_t phys_reset;
> > > +
> > > +	BUG_ON(!platform_ops);
> > 
> > Seems a bit overkill, or are we unrecoverable by this point?
> 
> We are.  The upper layer expects this CPU to be dead and there is no 
> easy recovery possible.  This is a "should never happen" condition, and 
> the kernel is badly configured otherwise.

Okey doke, that's what I feared. The BUG_ON makes sense then.

> > > +/*
> > > + * Platform specific methods used in the implementation of the above API.
> > > + */
> > > +struct bL_platform_power_ops {
> > > +	int (*power_up)(unsigned int cpu, unsigned int cluster);
> > > +	void (*power_down)(void);
> > > +	void (*suspend)(u64);
> > > +	void (*powered_up)(void);
> > > +};
> > 
> > It would be good if these prototypes matched the PSCI code, then platforms
> > could just glue them together directly.
> 
> No.
> 
> I discussed this at length with Charles (the PSCI spec author) already. 
> Even in the PSCI case, a minimum PSCI backend is necessary to do some 
> impedance matching between what the PSCI calls expect as arguments and 
> what this kernel specific API needs to express.  For example, the UP 
> method needs to always be provided with the address for bL_entry, 
> irrespective of where the user of this kernel API wants execution to be 
> resumed.  There might be some cases where the backend might decide to 
> override the desired power saving state because of other kernel induced 
> constraints (ongoing DMA operation for example) that PSCI doesn't (and 
> should not) know about.  And the best place to arbitrate between those 
> platform specific constraints is in this platform specific shim or 
> backend.

Yes, you're right. I was thinking we could convert cpu/cluster into cpuid
automatically, but actually it's not guaranteed that the PSCI firmware will
follow the MPIDR format so we even need platform-specific marshalling for
that.

Thanks for the reply,

Will
