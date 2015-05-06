From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 11:24:58 +0200
Subject: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <20150505221646.GE24643@google.com>
 <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
Message-ID: <2236679.A9NfANRyhD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 11:14:25 Gabriel Fernandez wrote:
> 
> >> +static int __init pcie_init(void)
> >> +{
> >> +     return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
> >> +}
> >> +device_initcall(pcie_init);
> >
> > Can you use module_platform_driver_probe() or module_init() here?
> >
> 
> Yes we can use module_init() here.
> 
> By the way if figure out i removed __init attribute on st_pcie_probe()
> in previous version to follow Arnd's remark.
> But st_pcie_probe calls hook_fault_code() that has __init attribute.
> So I think we need to keep __init for probe routine ?
> Also, we have to restrict bind/unbind with "suppress_bind_attrs" in
> platform_driver structure.
> This is the main reason to not allow module unload/reload.
> 
> If you are ok i will send a v4 ?
> 

If you mark the probe function as __init, you have to use
module_platform_driver_probe() or platform_driver_probe() instead,
to prevent the probe function from being deferred.

Calling hook_fault_code() also means you need to prevent module
unloading, by providing only a module_init but not a module_exit
function, so module_platform_driver_probe() also won't work.

It may be a good idea to work on improving the hook_fault_code()
infrastructure to make it more usable with loadable device drivers.

	Arnd
