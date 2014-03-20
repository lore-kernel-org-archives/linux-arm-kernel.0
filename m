From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 20 Mar 2014 15:24:41 +0100
Subject: [PATCH 3/4] ata: add new-style AHCI platform driver for DaVinci
 DA850 AHCI controller
In-Reply-To: <532AEBBD.80707@ti.com>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <2662651.GJX9HVKij5@amdc1032> <532AEBBD.80707@ti.com>
Message-ID: <4579887.D6KcuxH2bm@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 20, 2014 06:53:09 PM Sekhar Nori wrote:
> On Thursday 20 March 2014 06:27 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> >>> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> 
> >>> +extern void __iomem *da8xx_syscfg1_base;
> >>
> >> This platform specific extern symbol should not be used in drivers and
> >> in fact checkpatch complains about it too. Can you instead get the
> >> addresses you need as part of the device resources?
> > 
> > This is problematic because it is system resource not particular device
> > resource.  I would prefer to wait with fixing it until the conversion to
> > the device tree.
> 
> The way you have it now, module build will fail because the symbol isn't
> exported from platform code (and it should not be). The register is
> "system level" but it is SATA specific and I see no problem in passing
> it to the driver.

OK, I'll try to fix it.

> Conversion to device tree will not change anything until we throw out
> the platform device code. That may or may not ever happen.
> 
> >>> +static int da850_sata_init(struct device *dev, void __iomem *addr)
> >>> +{
> >>> +	int i, ret;
> >>> +	unsigned int val;
> >>> +
> >>> +	da850_sata_clk = clk_get(dev, NULL);
> >>> +	if (IS_ERR(da850_sata_clk))
> >>> +		return PTR_ERR(da850_sata_clk);
> >>> +
> >>> +	ret = clk_prepare_enable(da850_sata_clk);
> >>> +	if (ret)
> >>> +		goto err0;
> >>
> >> Please switch to pm_runtime instead of using the clock APIs directly.
> > 
> > Could you please elaborate a bit more on this?
> 
> I meant using pm_runtime_get_sync() to enable the clocks. There are many
> examples in the kernel. drivers/watchdog/omap_wdt.c is one.
> Documentation is available in Documentation/power/runtime_pm.txt

What would be benefit of adding runtime PM methods (->runtime_suspend
and ->runtime_resume) just for enabling/disabling this clock on driver
->probe and ->remove methods?  Wouldn't it add complexity and additonal
dependency (on runtime PM) just for no gain?

Is the driver specific clock control even needed given the resource
handling in the generic AHCI platform library code (please see
ahci_platform_get_resources(),  ahci_platform_enable_resources() and
ahci_platform_disable_resources())?

[ Please also take a look at commit f1e70c2 ("ata/ahci_platform: Add
  clock framework support") which on Aug 27 2012 added generic clock
  control to ahci_platform driver but forgot to cleanup DA850 AHCI
  platform code.  The DA850 AHCI support was added much earlier by
  commit cbb2c961 ("davinci: da850: add support for SATA interface")
  on Jul 6 2011. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
