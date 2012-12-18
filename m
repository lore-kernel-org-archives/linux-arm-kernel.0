From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Dec 2012 10:11:25 +0000
Subject: [PATCH v2 4/6] ARM: psci: add support for PSCI invocations from
 the kernel
In-Reply-To: <alpine.LFD.2.02.1212171537230.1263@xanadu.home>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1212171537230.1263@xanadu.home>
Message-ID: <20121218101125.GC9072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 08:51:27PM +0000, Nicolas Pitre wrote:
> On Mon, 17 Dec 2012, Will Deacon wrote:
> 
> > This patch adds support for the Power State Coordination Interface
> > defined by ARM, allowing Linux to request CPU-centric power-management
> > operations from firmware implementing the PSCI protocol.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> [...]
> 
> > +/*
> > + * The following two functions are invoked via the invoke_psci_fn pointer
> > + * and will not be inlined, allowing us to piggyback on the AAPCS.
> > + */
> 
> To make sure the code is always in sync with the intent, you could mark 
> those with  noinline as well.

Can do.

> > +static int __invoke_psci_fn_hvc(u32 function_id, u32 arg0, u32 arg1, u32 arg2)
> > +{
> > +	asm volatile(
> > +			__asmeq("%0", "r0")
> > +			__asmeq("%1", "r1")
> > +			__asmeq("%2", "r2")
> > +			__asmeq("%3", "r3")
> > +			__HVC(0)
> > +		: "+r" (function_id)
> > +		: "r" (arg0), "r" (arg1), "r" (arg2));
> > +
> > +	return function_id;
> > +}
> > +
> > +static int __invoke_psci_fn_smc(u32 function_id, u32 arg0, u32 arg1, u32 arg2)
> > +{
> > +	asm volatile(
> > +			__asmeq("%0", "r0")
> > +			__asmeq("%1", "r1")
> > +			__asmeq("%2", "r2")
> > +			__asmeq("%3", "r3")
> > +			__SMC(0)
> > +		: "+r" (function_id)
> > +		: "r" (arg0), "r" (arg1), "r" (arg2));
> > +
> > +	return function_id;
> > +}
> > +
> > +static int psci_cpu_suspend(struct psci_power_state state,
> > +			    unsigned long entry_point)
> > +{
> > +	int err;
> > +	u32 fn, power_state;
> > +
> > +	fn = psci_function_id[PSCI_FN_CPU_SUSPEND];
> > +	power_state = psci_power_state_pack(state);
> > +	err = invoke_psci_fn(fn, power_state, (u32)entry_point, 0);
> 
> Why do you need the u32 cast here?

That's a hangover from when entry_point was a void *. I'll fix that, thanks.

> > +static int __init psci_init(void)
> > +{
> > +	struct device_node *np;
> > +	const char *method;
> > +	u32 base, id;
> > +
> > +	np = of_find_matching_node(NULL, psci_of_match);
> > +	if (!np)
> > +		return 0;
> > +
> > +	pr_info("probing function IDs from device-tree\n");
> 
> Having "probing function IDs from device-tree" in the middle of a kernel 
> log isn't very informative.  Better make this more useful or remove it.
> 
> > +
> > +	if (of_property_read_u32(np, "function-base", &base)) {
> > +		pr_warning("missing \"function-base\" property\n");
> 
> Same thing here: this lacks context in a kernel log.
> And so on for the other occurrences.

Actually, these are all prefixed with "psci: " thanks to the pr_fmt
definition at the top of the file. I can remove them if you like, but then
it's not obvious which parts of the PSCI code are available from looking at
a kernel boot log.

Cheers for the review,

Will
