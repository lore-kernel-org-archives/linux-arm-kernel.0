From: arbab@linux.vnet.ibm.com (Reza Arbab)
Date: Mon, 4 Dec 2017 11:50:41 -0600
Subject: [PATCH v2 4/5] mm: memory_hotplug: Add memory hotremove probe
 device
In-Reply-To: <20171124142948.GA1966@samekh>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com>
 <5A17F5DF.2040108@huawei.com> <20171124104401.GD18120@samekh>
 <5A180DF1.8060009@huawei.com> <20171124142948.GA1966@samekh>
Message-ID: <20171204175040.2vgc6ccdcr5m77hm@arbab-laptop.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 02:29:48PM +0000, Andrea Reale wrote:
>But, at least in my understanding, the implementation is not as
>straightfoward as it looks. If I declare a memory node in the fdt, then,
>at boot, the kernel will expect that memory to actually be there to be
>used: this is not true if I want to plug my dimms only later at runtime.
>So I think that declaring the hotpluggable memory in an fdt memory
>node might not feasible without changes.

On the power arch, we do this today using "linux,usable-memory".

memory at 10000000000 {
  device_type = "memory";
  reg = <0x100 0x0 0x0 0x80000000>;
  linux,usable-memory = <0x100 0x0 0x0 0x40000000>;
  :
}

The reg range defines the node, but at at boot, memblocks are only 
created for the linux,usable-memory range. The rest can be hotplugged 
later. YMMV, because this depends on your arch's implementation of 
memory_add_physaddr_to_nid().

>One idea could be to add a new property to memory nodes, to specify 
>what memory is potentially hotplugguable.

Somewhat related, there is already a "hotpluggable" property.

memory at 10040000000 {
  device_type = "memory";
  reg = <0x100 0x40000000 0x0 0x40000000>;
  hotpluggable;
  :
}

This is subtly different from the earlier example. This memory IS 
present at boot. The hotpluggable property ensures that it resides in 
ZONE_MOVABLE so it can potentially be removed.

-- 
Reza Arbab
