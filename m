From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jan 2013 18:26:55 +0000
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
Message-ID: <201301101826.56248.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013, Thierry Reding wrote:
> I don't understand how this would help. The encoding is like this:
> 
>         [27:24] extended register number
>         [23:16] bus number
>         [15:11] device number
>         [10: 8] function number
>         [ 7: 0] register number
> 
> So it doesn't matter whether I use separate areas per bus or not. As
> soon as the whole extended configuration space needs to be accessed a
> whopping 28 bits (256 MiB) are required.
> 
> What you propose would work if only regular configuration space is
> supported. I'm not sure if that's an option.

I mean something like:

struct tegra_bus_private {
	...
	void __iomem *config_space[16];
};


void tegra_scan_bus(struct pci_bus *bus)
{
	int i;
	struct tegra_bus_private *priv = bus->dev->private;

	for (i=0; i<16; i++)
		priv->config_space[i] = ioremap(config_space_phys +
				 65536 * bus->primary + i * SZ_1M, 65536);

	...
}

	Arnd
