From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 18 Dec 2012 16:59:45 -0500 (EST)
Subject: [PATCH v2 4/6] ARM: psci: add support for PSCI invocations from
 the kernel
In-Reply-To: <20121218101125.GC9072@mudshark.cambridge.arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1212171537230.1263@xanadu.home>
 <20121218101125.GC9072@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1212181657020.1263@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Dec 2012, Will Deacon wrote:
> On Mon, Dec 17, 2012 at 08:51:27PM +0000, Nicolas Pitre wrote:
> > On Mon, 17 Dec 2012, Will Deacon wrote:
> > > +static int psci_cpu_suspend(struct psci_power_state state,
> > > +			    unsigned long entry_point)
> > > +{
> > > +	int err;
> > > +	u32 fn, power_state;
> > > +
> > > +	fn = psci_function_id[PSCI_FN_CPU_SUSPEND];
> > > +	power_state = psci_power_state_pack(state);
> > > +	err = invoke_psci_fn(fn, power_state, (u32)entry_point, 0);
> > 
> > Why do you need the u32 cast here?
> 
> That's a hangover from when entry_point was a void *. I'll fix that, thanks.

Hopefully you didn't pass virtual pointers to the PSCI call, did you?  :-)

> > > +static int __init psci_init(void)
> > > +{
> > > +	struct device_node *np;
> > > +	const char *method;
> > > +	u32 base, id;
> > > +
> > > +	np = of_find_matching_node(NULL, psci_of_match);
> > > +	if (!np)
> > > +		return 0;
> > > +
> > > +	pr_info("probing function IDs from device-tree\n");
> > 
> > Having "probing function IDs from device-tree" in the middle of a kernel 
> > log isn't very informative.  Better make this more useful or remove it.
> > 
> > > +
> > > +	if (of_property_read_u32(np, "function-base", &base)) {
> > > +		pr_warning("missing \"function-base\" property\n");
> > 
> > Same thing here: this lacks context in a kernel log.
> > And so on for the other occurrences.
> 
> Actually, these are all prefixed with "psci: " thanks to the pr_fmt
> definition at the top of the file.

Ah, goodie!  No more issue then.


Nicolas
