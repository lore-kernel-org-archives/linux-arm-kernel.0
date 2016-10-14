From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 14 Oct 2016 16:42:31 +0100
Subject: aarch64 ACPI boot regressed by commit 7ba5f605f3a0 ("arm64/numa:
 remove the limitation that cpu0 must bind to node0")
In-Reply-To: <b8b58d52-691c-11f0-2d26-a51e03430771@redhat.com>
References: <4a64cd93-5ead-aad6-1057-f42224d65b43@redhat.com>
 <20161014080524.4hm2b4p373r7rhel@hawk.localdomain>
 <04f22a79-301b-f05b-033d-c7a24c9f4084@redhat.com>
 <d26ea7ca-6b65-b3a6-591e-ab892f1815e7@redhat.com>
 <b8b58d52-691c-11f0-2d26-a51e03430771@redhat.com>
Message-ID: <20161014154231.GA4411@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 05:27:58PM +0200, Laszlo Ersek wrote:
> On 10/14/16 17:01, Laszlo Ersek wrote:
> 
> > Maybe the code I
> > tried to analyze in this email was never *meant* to associate CPU#0 with
> > any NUMA node at all (not even node 0); instead, other code -- for
> > example code removed by 7ba5f605f3a0 -- was meant to perform that
> > association.
> 
> Staring a bit more at the code, this looks very likely; in acpi_map_gic_cpu_interface() we have
> 
> > 	/* Check if GICC structure of boot CPU is available in the MADT */
> > 	if (cpu_logical_map(0) == hwid) {
> > 		if (bootcpu_valid) {
> > 			pr_err("duplicate boot CPU MPIDR: 0x%llx in MADT\n",
> > 			       hwid);
> > 			return;
> > 		}
> > 		bootcpu_valid = true;
> > 		return;
> > 	}
> 
> which means that this callback function (for parsing the GICC
> structures in the MADT) expects to find the boot processor as well.
> 
> Upon finding the boot processor, we set bootcpu_valid to true, and
> that's it -- no association with any NUMA node, and no incrementing of
> "cpu_count".

Yes, because that's to check the MADT contains the boot cpu hwid.

Does this help (compile tested only) ?

-- >8 -- 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d3f151c..8507703 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -544,6 +544,7 @@ static int __init smp_cpu_setup(int cpu)
 			return;
 		}
 		bootcpu_valid = true;
+		early_map_cpu_to_node(0, acpi_numa_get_nid(0, hwid));
 		return;
 	}
 
