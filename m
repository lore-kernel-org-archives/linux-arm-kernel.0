From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 11:09:16 +0200
Subject: [PATCH v9 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <CAFiDJ58Uwpv=xUXbBNQcd4FQq=fHGhtCnjTb7TKQBJ0TOxRLig@mail.gmail.com>
References: <1444790492-4051-1-git-send-email-lftan@altera.com>
 <6044983.WR9BTgsOaA@wuerfel>
 <CAFiDJ58Uwpv=xUXbBNQcd4FQq=fHGhtCnjTb7TKQBJ0TOxRLig@mail.gmail.com>
Message-ID: <5088538.zEUtS0EC0S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 16:32:25 Ley Foon Tan wrote:
> On Wed, Oct 14, 2015 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 14 October 2015 10:41:29 Ley Foon Tan wrote:
> >> +static int altera_pcie_remove(struct platform_device *pdev)
> >> +{
> >> +     struct altera_pcie *pcie = platform_get_drvdata(pdev);
> >> +
> >> +     altera_pcie_free_irq_domain(pcie);
> >> +     platform_set_drvdata(pdev, NULL);
> >> +     return 0;
> >> +}
> >
> > I just noticed this. Does it actually work to unload the module
> > and tear down all the pci_dev structures in a safe way?
> Good catch. It only can be compiled as builtin-moduley now, so we can
> remove this _remove callback function.

I think we should change both: make it possible to load the
driver dynamically, and remove the altera_pcie_remove function.

You can prevent the module from being unloaded if you also remove
the module_platform_driver() directive and add a module_init()
without a matching module_exit().

Please also add a '.suppress_bind_attrs = true,' flag in the driver
struct to prevent manual unbinding.

	Arnd
