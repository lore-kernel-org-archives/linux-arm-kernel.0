From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 21:22:18 +0200
Subject: [PATCH v7 4/4] PCI: Generic Configuration Access Mechanism support
In-Reply-To: <1400863915-24135-5-git-send-email-will.deacon@arm.com>
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
 <1400863915-24135-5-git-send-email-will.deacon@arm.com>
Message-ID: <201405232122.18995.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Will Deacon wrote:
> +static void __iomem *pci_cfg_map_bus_ecam(struct pci_bus *bus,
> +                                         unsigned int devfn,
> +                                         int where)
> +{
> +       struct pci_sys_data *sys = bus->sysdata;
> +       struct pci_cfg_windows *cfg = sys->private_data;
> +       resource_size_t idx = bus->number - cfg->bus_range.start;
> +
> +       return cfg->win[idx] + ((devfn << PCI_CFG_ECAM_DEV_NUM) | where);
> +}

I just noticed that this function makes the code rather non-generic, because
struct pci_sys_data is the ARM specific structure that doesn't exist elsewhere,
and sys->private_data wouldn't typically point to struct pci_cfg_windows on
anything other than your generic PCI host.

I'd say let's drop this for now. I know it was my idea to do it like this,
but it seems it's more complex than I had hoped to get this right, and
I'd really prefer to merge the other three patches for 3.16 if possible.
We can factor it out later if we get more users.

	Arnd
