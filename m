From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 23:52:34 +0200
Subject: [PATCH v2 2/2] PCI: keystone: update to support multiple pci ports
In-Reply-To: <540F75DF.5050904@ti.com>
References: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
 <9042477.aRbAhpkfQ5@wuerfel> <540F75DF.5050904@ti.com>
Message-ID: <3967092.l9bxcqMaSa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 17:49:19 Murali Karicheri wrote:
> Actually this is an inteded. The vendor ID is in a register indicated by
> reg offset and as per the device spec, it needs to be read and updated 
> by the software. Now since multiple instances of PCI device needs to be 
> read the same register, the reading happens in the probe() and same is 
> unmapped after that.
> 
> +       ks_pcie->device_id = readl(reg_p) >> 16;
> +       devm_iounmap(dev, reg_p);
> +       devm_release_mem_region(dev, res->start, resource_size(res));
> 
> Afetr that in ks_pcie_host_init(), it update the device_id in the RC's 
> config space.

I'm not sure I understand the purpose of this. Do you mean you read
the vendor/device ID of whichever device happens to get probed first
and then program the same ID into all other devices as well?

What if the order changes between two boots? Why does the vendor/device
ID of the host bridge even matter at all?

	Arnd
