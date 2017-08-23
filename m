From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 23 Aug 2017 14:59:42 +0200
Subject: [PATCH v10] PCI: tango: Add MSI controller support
In-Reply-To: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
Message-ID: <e32f8446-bd0b-0bc8-55b4-8dbebaeba101@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/2017 16:56, Marc Gonzalez wrote:

> @@ -76,7 +234,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct tango_pcie *pcie;
>  	struct resource *res;
> -	int ret;
> +	struct irq_domain *msi_dom, *irq_dom;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	int ret, reg, virq;
>  
>  	dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
>  	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);

  CC      drivers/pci/host/pcie-tango.o
drivers/pci/host/pcie-tango.c: In function 'tango_pcie_probe':
drivers/pci/host/pcie-tango.c:257:6: warning: unused variable 'ret' [-Wunused-variable]
  int ret, reg, virq;
      ^~~

Hmmm, dunno how I managed to miss that...
Is the kbuild test robot enjoying a well-deserved vacation?

Bjorn, if/when you take the patch, can you first apply this fixup:

@@ -254,7 +254,7 @@ static int tango_pcie_probe(struct platform_device *pdev)
        struct resource *res;
        struct irq_domain *msi_dom, *irq_dom;
        struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-       int ret, reg, virq;
+       int reg, virq;
 
        dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
        add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);


Regards.
