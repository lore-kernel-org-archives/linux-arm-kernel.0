From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Mon, 27 Nov 2017 17:14:43 +0000
Subject: [PATCH v2 4/5] mm: memory_hotplug: Add memory hotremove probe
 device
In-Reply-To: <198063b0-fcc9-7beb-7476-86ed5f04734c@arm.com>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com>
 <198063b0-fcc9-7beb-7476-86ed5f04734c@arm.com>
Message-ID: <20171127171441.GB12687@samekh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Mon 27 Nov 2017, 15:33, Robin Murphy wrote:
> On 23/11/17 11:14, Andrea Reale wrote:
> >Adding a "remove" sysfs handle that can be used to trigger
> >memory hotremove manually, exactly simmetrically with
> >what happens with the "probe" device for hot-add.
> >
> >This is usueful for architecture that do not rely on
> >ACPI for memory hot-remove.
> 
> Is there a real-world use-case for this, or is it mostly just a handy
> development feature?
> 
as I was saying in a response to your previous message, in our use
case remove events are triggered by software. Besides our use case,
yes, it is mostly just a handy develeopment feature AFAICT.

> >Signed-off-by: Andrea Reale <ar@linux.vnet.ibm.com>
> >Signed-off-by: Maciej Bielski <m.bielski@virtualopensystems.com>
> >---
> >  drivers/base/memory.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> >index 1d60b58..8ccb67c 100644
> >--- a/drivers/base/memory.c
> >+++ b/drivers/base/memory.c
> >@@ -530,7 +530,36 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
> >-#endif
> >+
> >+#ifdef CONFIG_MEMORY_HOTREMOVE
> >+static ssize_t
> >+memory_remove_store(struct device *dev,
> >+		struct device_attribute *attr, const char *buf, size_t count)
> >+{
> >+	u64 phys_addr;
> >+	int nid, ret;
> >+	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
> >+
> >+	ret = kstrtoull(buf, 0, &phys_addr);
> >+	if (ret)
> >+		return ret;
> >+
> >+	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
> >+		return -EINVAL;
> >+
> >+	nid = memory_add_physaddr_to_nid(phys_addr);
> 
> This call looks a bit odd, since you're not doing a memory add. In fact, any
> memory being removed should already be fully known-about, so AFAICS it
> should be simple to get everything you need to know (including potentially
> the online status as mentioned earlier), through 'normal' methods, e.g.
> page_to_nid() or similar.

Makes sense. Suggestion noted, thanks.

> Robin.
> 
> >+	ret = lock_device_hotplug_sysfs();
> >+	if (ret)
> >+		return ret;
> >+
> >+	remove_memory(nid, phys_addr,
> >+			 MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> >+	unlock_device_hotplug();
> >+	return count;
> >+}
> >+static DEVICE_ATTR(remove, S_IWUSR, NULL, memory_remove_store);
> >+#endif /* CONFIG_MEMORY_HOTREMOVE */
> >+#endif /* CONFIG_ARCH_MEMORY_PROBE */
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  /*
> >@@ -790,6 +819,9 @@ bool is_memblock_offlined(struct memory_block *mem)
> >  static struct attribute *memory_root_attrs[] = {
> >  #ifdef CONFIG_ARCH_MEMORY_PROBE
> >  	&dev_attr_probe.attr,
> >+#ifdef CONFIG_MEMORY_HOTREMOVE
> >+	&dev_attr_remove.attr,
> >+#endif
> >  #endif
> >  #ifdef CONFIG_MEMORY_FAILURE
> >
> 
