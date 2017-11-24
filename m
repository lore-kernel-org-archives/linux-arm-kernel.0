From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Fri, 24 Nov 2017 14:29:48 +0000
Subject: [PATCH v2 4/5] mm: memory_hotplug: Add memory hotremove probe
 device
In-Reply-To: <5A180DF1.8060009@huawei.com>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com>
 <5A17F5DF.2040108@huawei.com> <20171124104401.GD18120@samekh>
 <5A180DF1.8060009@huawei.com>
Message-ID: <20171124142948.GA1966@samekh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhongjian,

On Fri 24 Nov 2017, 20:17, zhong jiang wrote:
> Hi, Andrea
> 
> most of server will benefit from NUMA ,it is best to sovle the issue without
> spcial restrictions.
> 
> At least we can obtain the numa information from dtb. therefore, The memory can
> online correctly.

I fully agree it's an important feature, that should eventually be there. 

But, at least in my understanding, the implementation is not as
straightfoward as it looks. If I declare a memory node in the fdt, then,
at boot, the kernel will expect that memory to actually be there to be
used: this is not true if I want to plug my dimms only later at runtime.
So I think that declaring the hotpluggable memory in an fdt memory
node might not feasible without changes.

One idea could be to add a new property to memory nodes, to specify what
memory is potentially hotplugguable. For example, something like:

memory at 0 {
  device_type = "memory";
  reg = <0x0 0x0 0x0 0x40000000>;
  hot-add-range = <0x0 0x40000000 0x0 0x40000000>;
  numa-node-id=<0>;
}

memory at 10000000000 {
  device_type = "memory";
  reg = <0x100 0x0 0x0 0x40000000>;
  hot-add-range = <0x100 0x40000000 0x0 0x40000000>;
  numa-node-id=<1>;
}

The information in this imaginary "hot-add-range" property would be
ignored at boot and only checked by the hot add process to see to which
NUMA domain some phy memory belongs.

Of course this is just an example, and my limited knowledge of fdt
doesn't make me the best person to think what's the best approach.

All this to say: in absence of a clear and agreed approach, we released
the patch with the !NUMA limitation, so that we can get early feedback.
And also in the hope to kickstart this discussion on what's the best
approach to support NUMA .

Ideas/suggestions?

Thanks,
Andrea

> 
> Thanks
> zhongjiang
> 
> On 2017/11/24 18:44, Andrea Reale wrote:
> > Hi zhongjiang,
> >
> > On Fri 24 Nov 2017, 18:35, zhong jiang wrote:
> >> HI, Andrea
> >>
> >> I don't see "memory_add_physaddr_to_nid" in arch/arm64.
> >> Am I miss something?
> > When !CONFIG_NUMA it is defined in include/linux/memory_hotplug.h as 0.
> > In patch 1/5 of this series we require !NUMA to enable
> > ARCH_ENABLE_MEMORY_HOTPLUG.
> >
> > The reason for this simplification is simply that we would not know how
> > to decide the correct node to which to add memory when NUMA is on.
> > Any suggestion on that matter is welcome. 
> >
> > Thanks,
> > Andrea
> >
> >> Thnaks
> >> zhongjiang
> >>
> >> On 2017/11/23 19:14, Andrea Reale wrote:
> >>> Adding a "remove" sysfs handle that can be used to trigger
> >>> memory hotremove manually, exactly simmetrically with
> >>> what happens with the "probe" device for hot-add.
> >>>
> >>> This is usueful for architecture that do not rely on
> >>> ACPI for memory hot-remove.
> >>>
> >>> Signed-off-by: Andrea Reale <ar@linux.vnet.ibm.com>
> >>> Signed-off-by: Maciej Bielski <m.bielski@virtualopensystems.com>
> >>> ---
> >>>  drivers/base/memory.c | 34 +++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> >>> index 1d60b58..8ccb67c 100644
> >>> --- a/drivers/base/memory.c
> >>> +++ b/drivers/base/memory.c
> >>> @@ -530,7 +530,36 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
> >>>  }
> >>>  
> >>>  static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
> >>> -#endif
> >>> +
> >>> +#ifdef CONFIG_MEMORY_HOTREMOVE
> >>> +static ssize_t
> >>> +memory_remove_store(struct device *dev,
> >>> +		struct device_attribute *attr, const char *buf, size_t count)
> >>> +{
> >>> +	u64 phys_addr;
> >>> +	int nid, ret;
> >>> +	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
> >>> +
> >>> +	ret = kstrtoull(buf, 0, &phys_addr);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
> >>> +		return -EINVAL;
> >>> +
> >>> +	nid = memory_add_physaddr_to_nid(phys_addr);
> >>> +	ret = lock_device_hotplug_sysfs();
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	remove_memory(nid, phys_addr,
> >>> +			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> >>> +	unlock_device_hotplug();
> >>> +	return count;
> >>> +}
> >>> +static DEVICE_ATTR(remove, S_IWUSR, NULL, memory_remove_store);
> >>> +#endif /* CONFIG_MEMORY_HOTREMOVE */
> >>> +#endif /* CONFIG_ARCH_MEMORY_PROBE */
> >>>  
> >>>  #ifdef CONFIG_MEMORY_FAILURE
> >>>  /*
> >>> @@ -790,6 +819,9 @@ bool is_memblock_offlined(struct memory_block *mem)
> >>>  static struct attribute *memory_root_attrs[] = {
> >>>  #ifdef CONFIG_ARCH_MEMORY_PROBE
> >>>  	&dev_attr_probe.attr,
> >>> +#ifdef CONFIG_MEMORY_HOTREMOVE
> >>> +	&dev_attr_remove.attr,
> >>> +#endif
> >>>  #endif
> >>>  
> >>>  #ifdef CONFIG_MEMORY_FAILURE
> >>
> >
> > .
> >
> 
> 
