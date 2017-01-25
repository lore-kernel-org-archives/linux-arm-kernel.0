From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 25 Jan 2017 16:48:06 +0000
Subject: [PATCH] arm64: skip register_cpufreq_notifier on ACPI-based
 systems
In-Reply-To: <bbc37634-f087-feef-dacd-77c5adb9ed04@codeaurora.org>
References: <1485304992-26888-1-git-send-email-pprakash@codeaurora.org>
 <20170125120306.GC8093@e106622-lin>
 <bbc37634-f087-feef-dacd-77c5adb9ed04@codeaurora.org>
Message-ID: <20170125164806.GC25681@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/17 10:49, Christopher Covington wrote:
> On 01/25/2017 07:03 AM, Juri Lelli wrote:
> > Hi,
> > 
> > On 24/01/17 17:43, Prashanth Prakash wrote:
> >> On ACPI based systems where the topology is setup using the API
> >> store_cpu_topology, at the moment we do not have necessary code
> >> to handle a cpufreq notifier, thus resulting in a crash.
> >>
> >> Skip register_cpufreq_notifier if raw_capacity is not allocated
> >> as part of topology initialization.
> >>
> >> Stack:
> >>         init_cpu_capacity_callback+0xb4/0x1c8
> >>         notifier_call_chain+0x5c/0xa0
> >>         __blocking_notifier_call_chain+0x58/0xa0
> >>         blocking_notifier_call_chain+0x3c/0x50
> >>         cpufreq_set_policy+0xe4/0x328
> >>         cpufreq_init_policy+0x80/0x100
> >>         cpufreq_online+0x418/0x710
> >>         cpufreq_add_dev+0x118/0x180
> >>         subsys_interface_register+0xa4/0xf8
> >>         cpufreq_register_driver+0x1c0/0x298
> >>         cppc_cpufreq_init+0xdc/0x1000 [cppc_cpufreq]
> >>         do_one_initcall+0x5c/0x168
> >>         do_init_module+0x64/0x1e4
> >>         load_module+0x130c/0x14d0
> >>         SyS_finit_module+0x108/0x120
> >>         el0_svc_naked+0x24/0x28
> >>
> >> Patch that added support for popultaing cpu capacity for DT:
> >> https://patchwork.codeaurora.org/patch/98353/
> 
> In other words,
> 
> Fixes: 7202bde8b7ae ("arm64: parse cpu capacity-dmips-mhz from DT")
> 
> >> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> >> ---
> >>  arch/arm64/kernel/topology.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> >> index 23e9e13..3f175ce 100644
> >> --- a/arch/arm64/kernel/topology.c
> >> +++ b/arch/arm64/kernel/topology.c
> >> @@ -209,7 +209,7 @@ static void normalize_cpu_capacity(void)
> >>  
> >>  static int __init register_cpufreq_notifier(void)
> >>  {
> >> -	if (cap_parsing_failed)
> >> +	if (cap_parsing_failed || !raw_capacity)
> > 
> > Looks good. I couldn't really test it to check if it fixes your problem
> > (I assume it does), but it doesn't seem to introduce regressions on my
> > boxes.
> 
> Are you testing on QEMU or Fast Models?

Neither, Juno R2. Let me see if I can quickly test it in ACPI mode.

> I was under the impression that the
> former had ACPI support. For the latter, wouldn't it be nice to have ACPI
> support in the bootwrapper. Out of curiosity, is Mark's bootwrapper
> repository on kernel.org the best one to use these days?
> 
> http://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/
> 

Not sure, Mark, others?

Thanks,

- Juri
