From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 30 Oct 2014 12:42:50 -0600
Subject: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
In-Reply-To: <20141030180941.GA17911@red-moon>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141030162552.GC26820@obsidianresearch.com>
 <20141030165246.GC2048@red-moon>
 <20141030170305.GE26820@obsidianresearch.com>
 <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
 <20141030174541.GH26820@obsidianresearch.com>
 <20141030180941.GA17911@red-moon>
Message-ID: <20141030184250.GI26820@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 06:09:41PM +0000, Lorenzo Pieralisi wrote:

> It is done through core code in pci_create_root_bus(), that in turn
> calls pci_bus_assign_domain_nr() which is implemented now in pcibios
> for arm, it is all in patch 2. What Liviu is saying is correct, it
> all

Does request_resources have to be called before pci_create_root_bus
for everything to work right? I didn't trace too deeply, but
pci_create_root_bus is doing all sorts of things with the resource
list.. 

We already know that missing the request_resource causes some subtle
misbehavior in the PCI core...

Also:

+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+       int domain = of_get_pci_domain_nr(parent->of_node);
+
+       if (domain >= 0) {
+               dt_domain_found = true;
+       } else if (dt_domain_found == true) {
+               dev_err(parent, "Node %s is missing \"linux,pci-domain\" property in DT\n",
+                       parent->of_node->full_name);
+               return;

There isn't any way to return an error from pci_bus_assign_domain_nr,
so I'd think it must always assign something to bus->domain_nr?
Or does higher level code bail out of there are duplicate domains?

Should this error case call pci_get_new_domain_nr() anyhow?

Jason
