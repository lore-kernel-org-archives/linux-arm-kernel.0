From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Jan 2017 15:52:29 +0000
Subject: [PATCH] arm64: skip register_cpufreq_notifier on ACPI-based
 systems
In-Reply-To: <20170126121811.GD14167@arm.com>
References: <1485304992-26888-1-git-send-email-pprakash@codeaurora.org>
 <20170126121811.GD14167@arm.com>
Message-ID: <20170126155229.GB1194@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 12:18:11PM +0000, Will Deacon wrote:
> [adding Sudeep and Lorenzo for comment]
> 
> On Tue, Jan 24, 2017 at 05:43:12PM -0700, Prashanth Prakash wrote:
> > On ACPI based systems where the topology is setup using the API
> > store_cpu_topology, at the moment we do not have necessary code
> > to handle a cpufreq notifier, thus resulting in a crash.
> 
> What is the "necessary code" that we're missing? Wouldn't it be better
> to add that, or explicitly avoid the cpufreq notifier registration if
> we're using ACPI?

Necessary code is, in DT, code parsing bindings to provide capacity
values and allocate the raw_capacity array; there is no ACPI counterpart
for those bindings (well..there is a byte length field in the GICC MADT
entry "Processor Power Efficiency Class" but as far as I understand,
currently, it would be more reliable as a random seed than a useful
capacity scale, I just do not know why it is there) so the whole CPUfreq
notifier thing is basically useless when booting with ACPI.

How about using (or put the ACPI bit in a separate line with a
comment):

	if (!acpi_disabled || cap_parsing_failed)

to prevent registering the CPUfreq notifier ? Using raw_capacity check
this patch achieves the same in a much more opaque way (you will have to
include <linux/acpi.h> to make use of acpi_disabled).

We can work to turn "Processor Power Efficiency Class" into something
useful but that's for another series anyway.

Lorenzo

> 
> Will
> 
> 
> > Skip register_cpufreq_notifier if raw_capacity is not allocated
> > as part of topology initialization.
> > 
> > Stack:
> >         init_cpu_capacity_callback+0xb4/0x1c8
> >         notifier_call_chain+0x5c/0xa0
> >         __blocking_notifier_call_chain+0x58/0xa0
> >         blocking_notifier_call_chain+0x3c/0x50
> >         cpufreq_set_policy+0xe4/0x328
> >         cpufreq_init_policy+0x80/0x100
> >         cpufreq_online+0x418/0x710
> >         cpufreq_add_dev+0x118/0x180
> >         subsys_interface_register+0xa4/0xf8
> >         cpufreq_register_driver+0x1c0/0x298
> >         cppc_cpufreq_init+0xdc/0x1000 [cppc_cpufreq]
> >         do_one_initcall+0x5c/0x168
> >         do_init_module+0x64/0x1e4
> >         load_module+0x130c/0x14d0
> >         SyS_finit_module+0x108/0x120
> >         el0_svc_naked+0x24/0x28
> > 
> > Patch that added support for popultaing cpu capacity for DT:
> > https://patchwork.codeaurora.org/patch/98353/
> > 
> > Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> > ---
> >  arch/arm64/kernel/topology.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 23e9e13..3f175ce 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -209,7 +209,7 @@ static void normalize_cpu_capacity(void)
> >  
> >  static int __init register_cpufreq_notifier(void)
> >  {
> > -	if (cap_parsing_failed)
> > +	if (cap_parsing_failed || !raw_capacity)
> >  		return -EINVAL;
> >  
> >  	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
> > -- 
> > Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
> > Qualcomm Technologies, Inc. is a member of the
> > Code Aurora Forum, a Linux Foundation Collaborative Project.
> > 
