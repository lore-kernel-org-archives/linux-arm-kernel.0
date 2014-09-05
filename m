From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 19:54:58 +0200
Subject: [PATCH] PCI: keystone: update to support multiple pci ports
In-Reply-To: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com>
References: <1409938782-31460-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <7260053.FoBVhTXVfj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 13:39:42 Murali Karicheri wrote:
> +
>         /* enable RC mode in devcfg */
>         val = readl(reg_p);
> -       val &= ~PCIE_MODE_MASK;
> -       val |= PCIE_RC_MODE;
> +       port_id <<= 1;
> +       val &= ~(PCIE_MODE_MASK << port_id);
> +       val |= (PCIE_RC_MODE << port_id);
>         writel(val, reg_p);
> +       devm_iounmap(dev, reg_p);
> +       devm_release_mem_region(dev, res->start, resource_size(res));

This looks like it's a shared register of some sort that doesn't
really belong into the registers of a particular port. Could it
be that it's actually for the PHY?

	Arnd
