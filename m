From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 20:55:21 +0200
Subject: [PATCH 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
In-Reply-To: <1493194200.27023.79.camel@mtkswgap22>
References: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
 <1492935543-18190-2-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a39TFkJ5=jp8me+Dyg-Qi-N_1ZKxpJGvnhmPEo4csnFCw@mail.gmail.com>
 <1493194200.27023.79.camel@mtkswgap22>
Message-ID: <CAK8P3a0DjPL8uWuXfCmEwt05SCPJ0yEQTAJmZAPtFDEfsn4a1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 10:10 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Tue, 2017-04-25 at 14:38 +0200, Arnd Bergmann wrote:
>> On Sun, Apr 23, 2017 at 10:19 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:

>> > +static int mtk_pcie_enable_ports(struct mtk_pcie *pcie)
>> > +{
>> > +       struct device *dev = pcie->dev;
>> > +       struct mtk_pcie_port *port, *tmp;
>> > +       int err, linkup = 0;
>> > +
>> > +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>> > +               err = clk_prepare_enable(port->sys_ck);
>> > +               if (err) {
>> > +                       dev_err(dev, "failed to enable port%d clock\n",
>> > +                               port->index);
>> > +                       continue;
>> > +               }
>> > +
>> > +               /* assert RC */
>> > +               reset_control_assert(port->reset);
>> > +               /* de-assert RC */
>> > +               reset_control_deassert(port->reset);
>> > +
>> > +               /* power on PHY */
>> > +               err = phy_power_on(port->phy);
>> > +               if (err) {
>> > +                       dev_err(dev, "failed to power on port%d phy\n",
>> > +                               port->index);
>> > +                       goto err_phy_on;
>> > +               }
>> > +
>> > +               mtk_pcie_assert_ports(port);
>> > +
>>
>> Similar to the comment I had for the binding, I wonder if it would be
>> better to keep all the information about the ports in one place and
>> then just deal with it at the root level.
>>
>> Alternatively, we could decide to standardize on the properties
>> you have added to the pcie port node, but then I would handle
>> them in the pcieport driver rather than in the host bridge driver.
>
> Sorry, I'm not sure what you want me to do here.
>
> I could move all clock operation in root level. But we need to keep the
> reset and PHY operation sequence in the loop, In addition, we could
> easily free resources if ports link fail.
>
> How about moving this function to mtk_pcie_parse_and_add_res()?

That could work, please try it out and see if the code gets better or
worse. This may depend on what we end up doing with the DT
properties.

>> > +/*
>> > + * This IP lacks interrupt status register to check or map INTx from
>> > + * different devices at the same time.
>> > + */
>> > +static int __init mtk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>> > +{
>> > +       struct mtk_pcie *pcie = dev->bus->sysdata;
>> > +       struct mtk_pcie_port *port;
>> > +
>> > +       list_for_each_entry(port, &pcie->ports, list)
>> > +               if (port->index == slot)
>> > +                       return port->irq;
>> > +
>> > +       return -1;
>> > +}
>>
>> This looks odd, what is it needed for specifically? It looks like
>> it's broken for devices behind bridges, and the interrupt mapping
>> should normally come from the interrupt-map property, without
>> the need for a driver specific map_irq override.
>
> Our hardware just has a GIC for each port and lacks interrupt status for
> host driver to distinguish INTx. So I return port IRQ here.

You should still be able to express this with standard interrupt-map
DT property, without having to resort to your own map_irq
callback handler.

In the interrupt-map-mask, you can ignore the interrupt line
only list the devfn of the root ports for each entry.

>> > +static int mtk_pcie_register_ports(struct mtk_pcie *pcie)
>> > +{
>> > +       struct pci_bus *bus, *child;
>> > +
>> > +       bus = pci_scan_root_bus(pcie->dev, 0, &mtk_pcie_ops, pcie,
>> > +                               &pcie->resources);
>>
>> Can you use the new pci_register_host_bridge() method instead of
>> pci_scan_root_bus() here?
>
> May I know what's difference between pci_scan_root_bus() and using
> pci_register_host_bridge() directly? What situation should we use it?
> It seems that just tegra use this new method currently.

We introduced the new function for tegra for now, in the long run
I would hope we can convert all other drivers to it as well, to make it
easier to add further parameters.

The new function also has a cleaner way of dealing with the memory
allocations, similar to how other subsystems work.

     Arnd
