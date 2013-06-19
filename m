From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 14:43:09 +0200
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <002401ce6c8a$2dd1e4a0$8975ade0$@samsung.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <201306181556.47656.arnd@arndb.de>
 <002401ce6c8a$2dd1e4a0$8975ade0$@samsung.com>
Message-ID: <201306191443.09598.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Jingoo Han wrote:
> Then, do you mean the following?
> 
> static int __exit exynos_pcie_remove(struct platform_device *pdev)
> {
>         struct pcie_port *pp = platform_get_drvdata(pdev);
> 
>         clk_disable_unprepare(pp->bus_clk);
>         clk_disable_unprepare(pp->clk);
> 
>         return 0;
> }
> 
> static struct platform_driver exynos_pcie_driver = {
>         .remove = __exit_p(exynos_pcie_remove),
> 
> [.....]
> 
> /* Exynos PCIe driver does not allow module unload */
> 
> static int __init pcie_init(void)
> {
>         hook_fault_code(16 + 6, exynos_pcie_abort, SIGBUS, 0,
>                         "imprecise external abort");
> 
>         platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
> 
>         return 0;
> }
> subsys_initcall(pcie_init);
> 
> MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
> MODULE_DESCRIPTION("Samsung PCIe host controller driver");
> MODULE_LICENSE("GPLv2");
> 

Yes, this looks good. I would probably use platform_driver_register
rather than platform_driver_probe, but that is your choice. using
platform_driver_probe() mean you cannot deal with deferred probing.

	Arnd
