From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 9 Mar 2017 08:39:07 +0100
Subject: pcie-iproc: broken 2nd (& 3rd?) controller support by
 c3245a566400 ("PCI: iproc: Request host bridge window resources")
In-Reply-To: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
References: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
Message-ID: <f40bbf2f-3ba9-3992-d417-6588085f3d62@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2017 01:56 PM, Rafa? Mi?ecki wrote:
> I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see card
> connected to the 2nd controller.
>
> [    2.593534] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> [    2.599786] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
> [    2.606663] pcie_iproc_bcma bcma0:7: link: UP
> [    2.611316] PCI: bus0: Fast back to back transfers disabled
> [    2.616899] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    2.625395] PCI: bus1: Fast back to back transfers disabled
> [    2.631011] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
> [    2.637795] pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
> [    2.645091] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.650042] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
>
> [    2.657199] pcie_iproc_bcma bcma0:8: resource collision: [mem 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem 0x40000000-0x47ffffff]
> [    2.669946] pcie_iproc_bcma bcma0:8: PCIe controller setup failed
> [    2.676032] pcie_iproc_bcma: probe of bcma0:8 failed with error -16
>
>
> This used to work with older kernels because there wasn't any collision check:
>
> [    2.587117] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> [    2.593378] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
> [    2.600256] pcie_iproc_bcma bcma0:7: link: UP
> [    2.604888] PCI: bus0: Fast back to back transfers disabled
> [    2.610474] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    2.618973] PCI: bus1: Fast back to back transfers disabled
> [    2.624591] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
> [    2.631382] pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
> [    2.638686] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.643633] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
>
> [    2.777118] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
> [    2.783367] pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
> [    2.790245] pcie_iproc_bcma bcma0:8: link: UP
> [    2.794862] PCI: bus0: Fast back to back transfers disabled
> [    2.800452] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    2.808946] PCI: bus1: Fast back to back transfers disabled
> [    2.814558] pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x400fffff]
> [    2.821352] pci 0001:01:00.0: BAR 0: assigned [mem 0x40000000-0x40007fff 64bit]
> [    2.828650] pci 0001:00:00.0: PCI bridge to [bus 01]
> [    2.833600] pci 0001:00:00.0:   bridge window [mem 0x40000000-0x400fffff]
>
>
> I guess the check is OK after all and the real problem is iproc driver assigning
> the same resource.
>
> Broadcom team: could you take a look at this, please?

I found a reason of this conflict (and probably random crashes I started
seeing with 4.9). I believe we have a memory corruption.

So that commit c3245a566400 ("PCI: iproc: Request host bridge window
resources") adds call to the devm_request_pci_bus_resources passing "res"
pointer. The problem is "res" points to the *local* variable of
iproc_pcie_bcma_probe function.
As soon as the iproc_pcie_bcma_probe exits that resource variable is not
accessible anymore, yet it's used as a child for &iomem_resource. Things go
even worse on another iproc_pcie_bcma_probe call. Its local variable res_mem
gets the same memory address as the one already used for &iomem_resource. We
modify local variable modifying already-added resource at the same time!

So this is where this whole conflicts comes from. What is stored as resource
for [mem 0x08000000-0x0fffffff] range gets modified as "local" variable to the
[mem 0x40000000-0x47ffffff] and then we try to re-request the same resource.

I'm pasting log & patch that allowed me to debug & notice this problem so you
can confirm my observations.

[    2.615055] resource: [__request_resource] root:[mem 0x00000000-0xffffffff]
[    2.621995] resource: [__request_resource]  new:c7839be0 new:[mem 0x08000000-0x0fffffff]
[    2.630060] resource: [__request_resource]  tmp:c7ffee00 tmp:[mem 0x00000000-0x07ffffff]
[    2.638122] resource: [__request_resource]  tmp:c7adf180 tmp:[mem 0x18000300-0x180003ff]
[    2.764941] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    2.771194] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[    2.778066] pcie_iproc_bcma bcma0:7: link: UP
[    2.782693] PCI: bus0: Fast back to back transfers disabled
[    2.788267] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.796767] PCI: bus1: Fast back to back transfers disabled
[    2.802375] resource: [__request_resource] root:[mem 0x08000000-0x0fffffff]
[    2.809324] resource: [__request_resource]  new:c7b08e64 new:[mem size 0x00100000]
[    2.816865] resource: [__request_resource]  tmp:  (null) tmp:  (null)
[    2.823282] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
[    2.830049] resource: [__request_resource] root:[mem 0x08000000-0x080fffff]
[    2.836986] resource: [__request_resource]  new:c7b09164 new:[mem size 0x00008000 64bit]
[    2.845047] resource: [__request_resource]  tmp:  (null) tmp:  (null)
[    2.851464] pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
[    2.858758] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.863700] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]

[    2.870834] resource: [__request_resource] root:[mem 0x00000000-0xffffffff]
[    2.877791] resource: [__request_resource]  new:c7839be0 new:[mem 0x40000000-0x47ffffff]
[    2.885855] resource: [__request_resource]  tmp:c7ffee00 tmp:[mem 0x00000000-0x07ffffff]
[    2.893911] resource: [__request_resource]  tmp:c7839be0 tmp:[mem 0x40000000-0x47ffffff]
[    2.901971] resource: [__request_resource] Found collision with tmp
[    2.908225] pcie_iproc_bcma bcma0:8: resource collision: [mem 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem 0x40000000-0x47ffffff]
[    2.920952] pcie_iproc_bcma bcma0:8: PCIe controller setup failed
[    2.927037] pcie_iproc_bcma: probe of bcma0:8 failed with error -16

As you can see, for the first controller following resource has been requested:
c7839be0 [mem 0x08000000-0x0fffffff]

Then when we try to probe second controller there are following resources
already in use:
c7ffee00 [mem 0x00000000-0x07ffffff]
c7839be0 [mem 0x40000000-0x47ffffff]
and we try to request:
c7839be0 [mem 0x40000000-0x47ffffff]


diff --git a/kernel/resource.c b/kernel/resource.c
index 9b5f044..fab9405 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -220,6 +220,8 @@ static struct resource * __request_resource(struct resource *root, struct resour
  	resource_size_t end = new->end;
  	struct resource *tmp, **p;

+	if (new->flags & IORESOURCE_MEM) pr_info("[%s] root:%pR\n", __func__, root);
+	if (new->flags & IORESOURCE_MEM) pr_info("[%s]  new:%p new:%pR\n", __func__, new, new);
  	if (end < start)
  		return root;
  	if (start < root->start)
@@ -229,6 +231,7 @@ static struct resource * __request_resource(struct resource *root, struct resour
  	p = &root->child;
  	for (;;) {
  		tmp = *p;
+		if (new->flags & IORESOURCE_MEM) pr_info("[%s]  tmp:%p tmp:%pR\n", __func__, tmp, tmp);
  		if (!tmp || tmp->start > end) {
  			new->sibling = tmp;
  			*p = new;
@@ -238,6 +241,7 @@ static struct resource * __request_resource(struct resource *root, struct resour
  		p = &tmp->sibling;
  		if (tmp->end < start)
  			continue;
+		if (new->flags & IORESOURCE_MEM) pr_info("[%s] Found collision with tmp\n", __func__);
  		return tmp;
  	}
  }
