From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 17 Oct 2016 16:04:05 +0800
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
In-Reply-To: <c8b9f6fc-3a4b-f74a-c930-f500bcc00a1d@redhat.com>
References: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
 <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
 <04f22a79-301b-f05b-033d-c7a24c9f4084@redhat.com>
 <d26ea7ca-6b65-b3a6-591e-ab892f1815e7@redhat.com>
 <b8b58d52-691c-11f0-2d26-a51e03430771@redhat.com>
 <20161014154231.GA4411@red-moon>
 <c8b9f6fc-3a4b-f74a-c930-f500bcc00a1d@redhat.com>
Message-ID: <580485F5.9080207@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index d3f151cfd4a1..8507703dabe4 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -544,6 +544,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>>  			return;
>>  		}
>>  		bootcpu_valid = true;
>> +		early_map_cpu_to_node(0, acpi_numa_get_nid(0, hwid));
>>  		return;
>>  	}
>>
> 
> Anyway, your patch works with both the two-node NUMA configuration Drew suggested for testing, and with the single-node config that I originally used for the bisection. Therefore:
> 
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thank you very much for the quick bugfix! And, I think your patch (when you send it for real) should carry
I'm so sorry about this. My patch series prepared before ACPI NUMA upstreamed, and forgot considering it in later.

> 
> Fixes: 7ba5f605f3a0d9495aad539eeb8346d726dfc183
> 
> too, because it supplies the cpu#0<->node#xxx association that 7ba5f605f3a0 removed not just for DT, but also for ACPI.
> 
> Cheers!
> Laszlo
> 
> .
> 
