From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Aug 2013 10:06:40 +0200
Subject: [PATCH 3/9] PCI: mvebu: remove subsys_initcall
In-Reply-To: <20130813091959.784b44f0@skate>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813091959.784b44f0@skate>
Message-ID: <20130813080639.GD9316@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 09:19:59AM +0200, Thomas Petazzoni wrote:
> Dear Sebastian Hesselbarth,
> 
> On Mon, 12 Aug 2013 20:46:49 +0200, Sebastian Hesselbarth wrote:
> > This removes the subsys_initcall from the driver and converts it to
> > a normal platform_driver. Also, drvdata is set and a remove functions
> > is added to disable the clock and free resources.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> I'm OK with this, just a comment below.
> 
> > +static int mvebu_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
> > +	struct mvebu_pcie_port *port = &pcie->ports[0];
> > +	int i;
> > +
> > +	for (i = 0; i < pcie->nports; i++, port++) {
> > +		clk_disable_unprepare(port->clk);
> > +		kfree(port->name);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> I believe the ->remove() part is quite useless. The driver is a 'bool'
> in Kconfig, so it cannot be compiled as a module, and I'm not sure
> there a way to remove the platform device that corresponds to the PCIe
> controller.

There is. You can write the device's name to the driver's unbind file in
sysfs. What I ended up doing for Tegra was not to provide a .remove() at
all and set the struct device_driver's .suppress_bind_attrs to true.

Those two things combined should make it impossible to unbind the device
from the driver.

> And even if there was, then it would still not work because as far as I
> know, the ARM PCI core doesn't provide functions to 'unregister' PCI
> controllers, so it would keep pointers to functions located in the
> driver, which would cause nasty things when unloading the module.

I did some initial work to support driver unbinding (in order to support
module unloading) on Tegra and things look pretty promising. The ARM PCI
code would need something like pci_common_exit() to make sure there are
no leaks.

Unfortunately I can't seem to find that branch anymore, so I will have
to reconstruct it from memory...

That said, I agree with Thomas that it's not useful (and potentially
even dangerous) to add the .remove() at this point in time.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/9c9556dc/attachment-0001.sig>
