From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Tue, 19 Jun 2018 20:03:07 +0800
Subject: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
References: <1527768879-88161-2-git-send-email-xiexiuqi@huawei.com>
 <20180606154516.GL6631@arm.com>
 <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
 <20180607105514.GA13139@dhcp22.suse.cz>
 <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
 <20180607122152.GP32433@dhcp22.suse.cz>
 <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
 <20180611085237.GI13364@dhcp22.suse.cz>
 <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
 <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,


On 2018/6/14 1:39, Punit Agrawal wrote:
> Punit Agrawal <punit.agrawal@arm.com> writes:
> 
> 
> [...]
> 
>>
>> CONFIG_HAVE_MEMORYLESS node is not enabled on arm64 which means we end
>> up returning the original node in the fallback path.
>>
>> Xie, does the below patch help? I can submit a proper patch if this
>> fixes the issue for you.
>>
>> -- >8 --
>> Subject: [PATCH] arm64/numa: Enable memoryless numa nodes
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>>  arch/arm64/Kconfig   | 4 ++++
>>  arch/arm64/mm/numa.c | 2 ++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index eb2cf4938f6d..5317e9aa93ab 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -756,6 +756,10 @@ config USE_PERCPU_NUMA_NODE_ID
>>  	def_bool y
>>  	depends on NUMA
>>  
>> +config HAVE_MEMORYLESS_NODES
>> +       def_bool y
>> +       depends on NUMA
>> +
>>  config HAVE_SETUP_PER_CPU_AREA
>>  	def_bool y
>>  	depends on NUMA
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index dad128ba98bf..c699dcfe93de 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -73,6 +73,8 @@ EXPORT_SYMBOL(cpumask_of_node);
>>  static void map_cpu_to_node(unsigned int cpu, int nid)
>>  {
>>  	set_cpu_numa_node(cpu, nid);
>> +	set_numa_mem(local_memory_node(nid));
> 
> Argh, this should be
> 
>         set_cpu_numa_mem(cpu, local_memory_node(nid));
> 
> There is not guarantee that map_cpu_to_node() will be called on the
> local cpu.
> 
> Hanjun, Xie - can you try with the update please?

I've tested this patch, but it does not help.
The boot message is attached.

I tested on a arm board with 128 cores 4 numa nodes, but I set CONFIG_NR_CPUS=72.
Then node 3 is not be created, because node 3 has no memory, and no cpu.
But some pci device may related to node 3, which be set in ACPI table.

165 /* Interface called from ACPI code to setup PCI host controller */
166 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
167 {
168         int node = acpi_get_node(root->device->handle);
169         struct acpi_pci_generic_root_info *ri;
170         struct pci_bus *bus, *child;
171         struct acpi_pci_root_ops *root_ops;
172
            // this node may be not created.
177         ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
178         if (!ri)
179                 return NULL;
180
181         root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
182         if (!root_ops) {
183                 kfree(ri);
184                 return NULL;
185         }
186
187         ri->cfg = pci_acpi_setup_ecam_mapping(root);
188         if (!ri->cfg) {
189                 kfree(ri);
190                 kfree(root_ops);
191                 return NULL;
192         }


> 
> Thanks,
> Punit
> 
>> +
>>  	if (nid >= 0)
>>  		cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
>>  }
> 
> .
> 

-- 
Thanks,
Xie XiuQi
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0000030000 [0x480fd010]
[    0.000000] Linux version 4.16.0-rc1-00491-g204a6cc-dirty (xiexiuqi at localhost.localdomain) (gcc version 6.3.1 20170404 (Linaro GCC 6.3-2017.05)) #17 SMP PREEMPT Tue Jun 19 16:33:32 CST 2018
[    0.000000] earlycon: pl11 at MMIO32 0x0000000094080000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS 3.0=0x3eb60000  ACPI 2.0=0x39710000  MEMATTR=0x3b106418 
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000039710000 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x0000000039700000 000074 (v01 HISI   HIP08    00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039630000 000114 (v06 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: DSDT 0x00000000395C0000 006A1A (v02 HISI   HIP08    00000000 INTL 20170929)
[    0.000000] ACPI: GTDT 0x0000000039620000 000060 (v02 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: DBG2 0x0000000039610000 00005A (v00 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: MCFG 0x0000000039600000 00003C (v01 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: SLIT 0x00000000395F0000 00003C (v01 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: SRAT 0x00000000395E0000 0009C0 (v03 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: APIC 0x00000000395D0000 00286C (v04 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: IORT 0x00000000395B0000 00110C (v00 HISI   HIP08    00000000 INTL 20170929)
[    0.000000] ACPI: PPTT 0x00000000311F0000 0037D0 (v01 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: SPMI 0x00000000311E0000 000041 (v05 HISI   HIP08    00000000 INTL 20151124)
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30000 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30001 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30002 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30003 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30100 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30101 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30102 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30103 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30200 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30201 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30202 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30203 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30300 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30301 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30302 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30303 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30400 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30401 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30402 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30403 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30500 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30501 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30502 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30503 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30600 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30601 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30602 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30603 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30700 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30701 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30702 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x30703 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10000 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10001 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10002 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10003 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10100 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10101 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10102 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10103 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10200 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10201 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10202 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10203 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10300 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10301 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10302 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10303 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10400 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10401 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10402 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10403 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10500 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10501 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10502 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10503 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10600 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10601 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10602 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10603 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10700 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10701 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10702 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x10703 -> Node 1
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70000 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70001 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70002 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70003 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70100 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70101 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70102 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: PXM 2 -> MPIDR 0x70103 -> Node 2
[    0.000000] ACPI: NUMA: SRAT: cpu_to_node_map[72] is too small, may not be able to use all cpus
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x23ffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x402000000000-0x4023ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x23ffffe780-0x23ffffffff]
[    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x4023fffed780-0x4023fffeefff]
[    0.000000] NUMA: NODE_DATA(1) on node 2
[    0.000000] NUMA: NODE_DATA [mem 0x4023fffebf00-0x4023fffed77f]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00004023ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003942ffff]
[    0.000000]   node   0: [mem 0x0000000039430000-0x000000003956ffff]
[    0.000000]   node   0: [mem 0x0000000039570000-0x000000003963ffff]
[    0.000000]   node   0: [mem 0x0000000039640000-0x00000000396fffff]
[    0.000000]   node   0: [mem 0x0000000039700000-0x000000003971ffff]
[    0.000000]   node   0: [mem 0x0000000039720000-0x0000000039b6ffff]
[    0.000000]   node   0: [mem 0x0000000039b70000-0x000000003eb5ffff]
[    0.000000]   node   0: [mem 0x000000003eb60000-0x000000003eb8ffff]
[    0.000000]   node   0: [mem 0x000000003eb90000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000023ffffffff]
[    0.000000]   node   2: [mem 0x0000402000000000-0x00004023ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000023ffffffff]
[    0.000000] Could not find start_pfn for node 1
[    0.000000] Initmem setup node 1 [mem 0x0000000000000000-0x0000000000000000]
[    0.000000] Initmem setup node 2 [mem 0x0000402000000000-0x00004023ffffffff]
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 24 pages/cpu @        (ptrval) s59432 r8192 d30680 u98304
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] Built 3 zonelists, mobility grouping on.  Total pages: 7998480
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: earlycon=pl011,mmio32,0x94080000 console=ttyAMA0,115200 initrd=minifs.cpio.gz acpi=force
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 290816 bytes
...
[    0.141182] Platform MSI: ITS at 0x400202100000 domain created
[    0.146793] PCI/MSI: ITS at 0x202100000 domain created
[    0.151690] PCI/MSI: ITS at 0x400202100000 domain created
[    0.156906] Remapping and enabling EFI services.
[    0.161562]   EFI remap 0x0000000039430000 =>         (ptrval)
[    0.167431]   EFI remap 0x0000000039480000 =>         (ptrval)
[    0.173299]   EFI remap 0x00000000394d0000 =>         (ptrval)
[    0.179167]   EFI remap 0x0000000039520000 =>         (ptrval)
[    0.185037]   EFI remap 0x0000000039650000 =>         (ptrval)
[    0.190905]   EFI remap 0x00000000396b0000 =>         (ptrval)
[    0.196773]   EFI remap 0x0000000039720000 =>         (ptrval)
[    0.202639]   EFI remap 0x0000000039770000 =>         (ptrval)
[    0.208505]   EFI remap 0x00000000397c0000 =>         (ptrval)
[    0.214371]   EFI remap 0x0000000039810000 =>         (ptrval)
[    0.220236]   EFI remap 0x0000000039860000 =>         (ptrval)
[    0.226103]   EFI remap 0x00000000398b0000 =>         (ptrval)
[    0.231973]   EFI remap 0x0000000039900000 =>         (ptrval)
[    0.237840]   EFI remap 0x0000000039970000 =>         (ptrval)
[    0.243710]   EFI remap 0x00000000399c0000 =>         (ptrval)
[    0.249577]   EFI remap 0x0000000039a10000 =>         (ptrval)
[    0.255445]   EFI remap 0x0000000039a60000 =>         (ptrval)
[    0.261313]   EFI remap 0x0000000039ab0000 =>         (ptrval)
[    0.267184]   EFI remap 0x0000000039b00000 =>         (ptrval)
[    0.273047]   EFI remap 0x000000003eb60000 =>         (ptrval)
[    0.278907]   EFI remap 0x0000000080000000 =>         (ptrval)
[    0.284766]   EFI remap 0x0000000202020000 =>         (ptrval)
[    0.290626]   EFI remap 0x0000000204000000 =>         (ptrval)
[    0.296487]   EFI remap 0x0000000206200000 =>         (ptrval)
[    0.318359] smp: Bringing up secondary CPUs ...
[    0.422473] Detected VIPT I-cache on CPU1
[    0.422481] GICv3: CPU1: found redistributor 30001 region 1:0x00000000aa140000
[    0.422502] CPU1: using LPI pending table @0x00000023ee480000
[    0.422543] CPU1: Booted secondary processor 0x0000030001 [0x480fd010]
[    0.522109] Detected VIPT I-cache on CPU2
[    0.522115] GICv3: CPU2: found redistributor 30002 region 2:0x00000000aa180000
[    0.522135] CPU2: using LPI pending table @0x00000023ee4b0000
[    0.522175] CPU2: Booted secondary processor 0x0000030002 [0x480fd010]
[    0.621751] Detected VIPT I-cache on CPU3
...
[    7.328992] CPU70: Booted secondary processor 0x0000070102 [0x480fd010]
[    7.435880] Detected VIPT I-cache on CPU71
[    7.435931] GICv3: CPU71: found redistributor 70103 region 71:0x00004000aa2c0000
[    7.435958] CPU71: using LPI pending table @0x00000023ed340000
[    7.436037] CPU71: Booted secondary processor 0x0000070103 [0x480fd010]
[    7.436131] smp: Brought up 3 nodes, 72 CPUs
[    9.146250] SMP: Total of 72 processors activated.
[    9.151067] CPU features: detected feature: GIC system register CPU interface
[    9.158247] CPU features: detected feature: Privileged Access Never
...
[   11.535050] pci 0000:74:02.0: BAR 5: assigned [mem 0xa2000000-0xa2007fff]
[   11.541829] pci 0000:74:03.0: BAR 5: assigned [mem 0xa2008000-0xa2008fff]
[   11.548610] pci 0000:75:00.0: BAR 2: assigned [mem 0x144000000-0x1443fffff 64bit pref]
[   11.556518] pci 0000:75:00.0: BAR 9: assigned [mem 0x144400000-0x1447effff 64bit pref]
[   11.564426] pci 0000:74:00.0: PCI bridge to [bus 75]
[   11.569382] pci 0000:74:00.0:   bridge window [mem 0x144000000-0x1447fffff 64bit pref]
[   11.577332] ACPI: PCI Root Bridge [PCI6] (domain 0000 [bus 80-9f])
[   11.583505] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[   11.591850] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[   11.599851] CPU002: pci_acpi_scan_root: 175 node 3, online 0
[   11.605503] Unable to handle kernel paging request at virtual address 00001530
[   11.612712] Mem abort info:
[   11.615492]   ESR = 0x96000004
[   11.618534]   Exception class = DABT (current EL), IL = 32 bits
[   11.624440]   SET = 0, FnV = 0
[   11.627481]   EA = 0, S1PTW = 0
[   11.630608] Data abort info:
[   11.633476]   ISV = 0, ISS = 0x00000004
[   11.637299]   CM = 0, WnR = 0
[   11.640254] [0000000000001530] user address but active_mm is swapper
[   11.646594] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   11.652154] Modules linked in:
[   11.655198] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1-00491-g204a6cc-dirty #17
[   11.663361] Hardware name: Huawei, 06/02/2018
[   11.673174] pstate: 20c00089 (nzCv daIf +PAN +UAO)
[   11.677955] pc : ___slab_alloc+0x60/0x590
[   11.681952] lr : __slab_alloc.isra.24+0x58/0x70
[   11.686469] sp : ffff00000981b870
[   11.689771] x29: ffff00000981b870 x28: ffffc023eb8d8000 
[   11.695071] x27: ffff7e008fafd600 x26: ffff8023f0407c00 
[   11.700372] x25: ffff8023f0407c00 x24: ffff000008098da0 
[   11.705671] x23: 0000000000000003 x22: 00000000014080c0 
[   11.710971] x21: 0000000000000000 x20: 0000000000000003 
[   11.716271] x19: ffff8023f0b40870 x18: ffffffffffffffff 
[   11.721571] x17: 0000000000000000 x16: 000000000001c200 
[   11.726871] x15: ffff000009423b88 x14: ffff00008958c94f 
[   11.732171] x13: ffff00000958c95d x12: ffff00000943e858 
[   11.737471] x11: ffff00000943e000 x10: 0000000005f5e0ff 
[   11.742771] x9 : 00000000ffffffd0 x8 : 65646f6e20353731 
[   11.748071] x7 : 203a746f6f725f6e x6 : 00000000000002e8 
[   11.753371] x5 : 000000000000000a x4 : ffff8023f0b40870 
[   11.758670] x3 : ffff000008098da0 x2 : 0000000000000003 
[   11.763970] x1 : 0000000000000000 x0 : 0000000000000000 
[   11.769271] Process swapper/0 (pid: 1, stack limit = 0x00000000b21a776c)
[   11.775958] Call trace:
[   11.778392]  ___slab_alloc+0x60/0x590
[   11.782041]  __slab_alloc.isra.24+0x58/0x70
[   11.786212]  kmem_cache_alloc_node+0xe0/0x240
[   11.790556]  pci_acpi_scan_root+0xb0/0x270
[   11.794642]  acpi_pci_root_add+0x29c/0x498
[   11.798726]  acpi_bus_attach+0x104/0x210
[   11.802635]  acpi_bus_attach+0xa4/0x210
[   11.806458]  acpi_bus_attach+0xa4/0x210
[   11.810282]  acpi_bus_scan+0x4c/0xb0
[   11.813846]  acpi_scan_init+0xec/0x24c
[   11.817582]  acpi_init+0x300/0x36c
[   11.820972]  do_one_initcall+0x50/0x158
[   11.824797]  kernel_init_freeable+0x188/0x228
[   11.829141]  kernel_init+0x10/0x100
[   11.832617]  ret_from_fork+0x10/0x18
[   11.836181] Code: 90009081 93407e82 912ec021 f8627821 (f94a9821) 
[   11.842316] ---[ end trace 6b7476446f4b95ab ]---
[   11.846936] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   11.846936] 
[   11.856079] SMP: stopping secondary CPUs
[   11.860027] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   11.860027] 
