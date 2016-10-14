From: lersek@redhat.com (Laszlo Ersek)
Date: Fri, 14 Oct 2016 18:22:55 +0200
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
In-Reply-To: <20161014154231.GA4411@red-moon>
References: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
 <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
 <04f22a79-301b-f05b-033d-c7a24c9f4084@redhat.com>
 <d26ea7ca-6b65-b3a6-591e-ab892f1815e7@redhat.com>
 <b8b58d52-691c-11f0-2d26-a51e03430771@redhat.com>
 <20161014154231.GA4411@red-moon>
Message-ID: <c8b9f6fc-3a4b-f74a-c930-f500bcc00a1d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/16 17:42, Lorenzo Pieralisi wrote:
> On Fri, Oct 14, 2016 at 05:27:58PM +0200, Laszlo Ersek wrote:
>> On 10/14/16 17:01, Laszlo Ersek wrote:
>>
>>> Maybe the code I
>>> tried to analyze in this email was never *meant* to associate CPU#0 with
>>> any NUMA node at all (not even node 0); instead, other code -- for
>>> example code removed by 7ba5f605f3a0 -- was meant to perform that
>>> association.
>>
>> Staring a bit more at the code, this looks very likely; in acpi_map_gic_cpu_interface() we have
>>
>>> 	/* Check if GICC structure of boot CPU is available in the MADT */
>>> 	if (cpu_logical_map(0) == hwid) {
>>> 		if (bootcpu_valid) {
>>> 			pr_err("duplicate boot CPU MPIDR: 0x%llx in MADT\n",
>>> 			       hwid);
>>> 			return;
>>> 		}
>>> 		bootcpu_valid = true;
>>> 		return;
>>> 	}
>>
>> which means that this callback function (for parsing the GICC
>> structures in the MADT) expects to find the boot processor as well.
>>
>> Upon finding the boot processor, we set bootcpu_valid to true, and
>> that's it -- no association with any NUMA node, and no incrementing of
>> "cpu_count".
> 
> Yes, because that's to check the MADT contains the boot cpu hwid.
> 
> Does this help (compile tested only) ?
> 
> -- >8 -- 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d3f151c..8507703 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -544,6 +544,7 @@ static int __init smp_cpu_setup(int cpu)
>  			return;
>  		}
>  		bootcpu_valid = true;
> +		early_map_cpu_to_node(0, acpi_numa_get_nid(0, hwid));
>  		return;
>  	}
>  
> 

Your patch applies to the tree at v4.8-14604-g29fbff8698fc, but the function the hunk modifies is not smp_cpu_setup(), it is acpi_map_gic_cpu_interface():

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d3f151cfd4a1..8507703dabe4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -544,6 +544,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>  			return;
>  		}
>  		bootcpu_valid = true;
> +		early_map_cpu_to_node(0, acpi_numa_get_nid(0, hwid));
>  		return;
>  	}
> 

Anyway, your patch works with both the two-node NUMA configuration Drew suggested for testing, and with the single-node config that I originally used for the bisection. Therefore:

Tested-by: Laszlo Ersek <lersek@redhat.com>
Reported-by: Laszlo Ersek <lersek@redhat.com>

Thank you very much for the quick bugfix! And, I think your patch (when you send it for real) should carry

Fixes: 7ba5f605f3a0d9495aad539eeb8346d726dfc183

too, because it supplies the cpu#0<->node#xxx association that 7ba5f605f3a0 removed not just for DT, but also for ACPI.

Cheers!
Laszlo
