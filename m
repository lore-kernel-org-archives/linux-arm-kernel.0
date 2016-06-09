From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jun 2016 23:49:36 +0200
Subject: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
In-Reply-To: <87r3c6mmyp.fsf@free-electrons.com>
References: <201606092223.3kHMu0m3%fengguang.wu@intel.com>
 <87r3c6mmyp.fsf@free-electrons.com>
Message-ID: <7218454.U6xIsxs3Lc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 9, 2016 4:54:54 PM CEST Gregory CLEMENT wrote:
> >
> >    drivers/built-in.o: In function `sdhci_xenon_remove':
> >>> sdhci-xenon.c:(.text+0x311234): undefined reference to `sdhci_remove_host'
> >>> sdhci-xenon.c:(.text+0x31123c): undefined reference to `sdhci_pltfm_free'
> >    drivers/built-in.o: In function `sdhci_xenon_delay_adj_test':
> >>> sdhci-xenon.c:(.text+0x31213b): undefined reference to `card_alive'
> >    drivers/built-in.o: In function `sdhci_xenon_set_uhs_signaling':
> >>> sdhci-xenon.c:(.text+0x312456): undefined reference to `sdhci_set_uhs_signaling'
> >    drivers/built-in.o: In function `sdhci_xenon_probe':
> >>> sdhci-xenon.c:(.text+0x31258c): undefined reference to `sdhci_pltfm_init'
> >>> sdhci-xenon.c:(.text+0x3125d3): undefined reference to `mmc_of_parse'
> >>> sdhci-xenon.c:(.text+0x312651): undefined reference to `sdhci_get_of_property'
> >>> sdhci-xenon.c:(.text+0x312840): undefined reference to `sdhci_add_host'
> >    sdhci-xenon.c:(.text+0x312904): undefined reference to `sdhci_pltfm_free'
> >    drivers/built-in.o: In function `sdhci_xenon_reset':
> >>> sdhci-xenon.c:(.text+0x313c11): undefined reference to `sdhci_reset'
> >>> drivers/built-in.o:(.data+0x1d7df0): undefined reference to `sdhci_pltfm_pmops'
> >>> drivers/built-in.o:(.data+0x1d7eb0): undefined reference to `sdhci_set_clock'
> >>> drivers/built-in.o:(.data+0x1d7ef0): undefined reference to `sdhci_set_bus_width'
> 
> These symbols are part of the drivers/mmc/host/sdhci.c which is build
> when CONFIG_MMC_SDHCI is enabled. However CONFIG_MMC_XENON_SDHCI depends
> on CONFIG_MMC_SDHCI_PLTFM which depends on CONFIG_MMC_SDHCI.
> 
> So I wonder how we can have a sition with sdhci-xenon.c built but not
> sdhci.c.
> 
> Any idea?
> 

CONFIG_MMC_SDHCI is built as a module, but CONFIG_MMC_XENON_SDHCI is
a "bool" option, so it can only be built-in.

It should work if you make it a 'tristate' instead, so that Kconfig
can handle the dependency correctly.

	Arnd
