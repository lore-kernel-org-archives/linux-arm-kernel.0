From: jcm@redhat.com (Jon Masters)
Date: Sat, 17 Jan 2015 00:57:38 -0500
Subject: [PATCHv4] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
References: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
Message-ID: <54B9F9D2.6000104@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yi Li,

I would like some advice on the below patch. First, a little background.

I /may/ need to use SMBIOS provided data on ARMv8 systems to enumerate
the number of physical underlying CPU sockets present. This is provided
in one Type4 DMI structure per physical socket. Using that fact (such
data is already provided by all of the reference ARMv8 server systems),
and a variable interpretation of the CPU affinity data, we can refactor
the topology.c code to understand threads vs cores vs sockets without
getting confused by the extra levels of hierarchy for clusters.

I am going back over some older patches, including this one to
understand the DMI port, and I notice that you call dmi_scan_machine
from an early_initcall. This will run from the init thread, after we've
done basic SMP setup in smp_prepare_cpus, which is where we stash
cpu_topology data, which is after I already need DMI data available.

So. If I wanted this available prior to early_initcall time, would it be
reasonable to follow e.g. x86 and move this early in the boot? I'm not
necessarily going to ask to upstream such a change (since I expect to be
able to solve the underlying problem I am looking to address in a
different fashion soon), but first want to know if it would be
reasonable to ask to do that anyway.

Jon.

P.S. I'm not interested at all in replies pointing me to the existing DT
cpu topology binding, which I am well aware of, but it does also not
actually solve the problem I have :)

On 10/04/2014 11:46 AM, Yi Li wrote:

<snip>

> +
> +static int __init arm64_core_init(void)
> +{
> +/*
> + * DMI depends on EFI on arm64, and dmi_scan_machine() needs to be
> + * called early because dmi_id_init(), which is an arch_initcall itself,
> + * depends on dmi_scan_machine() having been called already.
> + */
> +
> +	dmi_scan_machine();
> +	return 0;
> +}
> +core_initcall(arm64_core_init);
> 
