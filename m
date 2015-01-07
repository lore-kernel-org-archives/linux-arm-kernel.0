From: mchitale@apm.com (Mayuresh Chitale)
Date: Wed, 7 Jan 2015 21:35:22 +0530
Subject: [PATCH 4/4] dma: X-Gene PCIE DMA Driver
In-Reply-To: <9430055.pMHRTP0RMA@wuerfel>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <4187918.PUaMnn04Vq@wuerfel>
 <CAL-zptNyLVBEvMBjSUbhE0WEj7-E81g7PF7_WFX1nM4AdYj7_g@mail.gmail.com>
 <9430055.pMHRTP0RMA@wuerfel>
Message-ID: <CAL-zptNW81KwWXnMcsh_S5KQFMNGysm=ATmixMge6RXj_U-_zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks again for your inputs. Please see inline.

--Mayuresh.

On Wed, Jan 7, 2015 at 6:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 January 2015 16:55:33 Mayuresh Chitale wrote:
>>
>> On Wed, Jan 7, 2015 at 2:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 07 January 2015 10:58:57 Mayuresh Chitale wrote:
>> >> This patch implements DMA engine API for DMA controller on APM
>> >> X-Gene PCIe controller. DMA engine can support up to 4 channels per port
>> >> and up to 2048 outstanding requests per channel.  This is intended
>> >> to be used on ports that are configured in EP mode or to transfer
>> >> data from a RC port that is connected to a X-Gene EP port.
>> >
>> > Linux currently does not support PCIe endpoints. Do you plan to submit
>> > a driver for that as well?
>> >
>> >> +
>> >> +static void xpdma_setup_dma_dev(struct dma_device *dev)
>> >> +{
>> >> +     dma_cap_zero(dev->cap_mask);
>> >> +     dma_cap_set(DMA_SLAVE, dev->cap_mask);
>> >> +     dma_cap_set(DMA_PRIVATE, dev->cap_mask);
>> >> +
>> >> +     dev->device_alloc_chan_resources = xpdma_alloc_chan_resources;
>> >> +     dev->device_free_chan_resources = xpdma_free_chan_resources;
>> >> +     dev->device_tx_status = xpdma_tx_status;
>> >> +     dev->device_issue_pending = xpdma_issue_pending;
>> >> +     dev->device_prep_slave_sg = xpdma_prep_slave_sg;
>> >> +     dev->device_control = xpdma_device_control;
>> >> +}
>> >
>> > You are setting up DMA_SLAVE here but do not use the DT binding
>> > for slave DMA. Can your driver handle slave DMA? If it can,
>> > you should use the appropriate binding, if not then don't
>> > set DMA_SLAVE here.
>>
>> Are you referring to  DT DMA helpers? If so, I will add it.
>
> Yes, you will need a '#dma-cells' property in the device node,
> and call of_dma_controller_register with an appropriate xlate
> function so a slave can find the right channel.
>
>> >> +static int xpdma_setup_dma_channel(struct platform_device *pdev,
>> >> +             struct xpdma_port *port)
>> >> +{
>> >> +     int i, ret = 0;
>> >> +     struct xpdma_chan *chan;
>> >> +     resource_size_t dma_base;
>> >> +
>> >> +     dma_base = MAKE_U64(readl(port->cfg + PORT_CFG_HI), readl(port->cfg)) +
>> >> +             CHAN_REG_BASE;
>> >> +     port->dma = devm_ioremap(&pdev->dev, dma_base,
>> >> +                     CHAN_REG_SIZE * MAX_DMA_CHAN);
>> >> +     if (port->dma == NULL) {
>> >> +             dev_err(&pdev->dev, "Could not get base addressc$\n");
>> >> +             return -ENOMEM;
>> >> +     }
>> >
>> > The registers are not listed in the 'reg' property. Why is that?
>> Actually these registers have to accessed via the PCIe config space
>> region for that port. Since the config space base address is
>> programmed by host controller driver we can know the base address only
>> by reading the corresponding config space bar at runtime.
>
> I think I'm missing something important here. What exactly is the
> interaction with PCI here? Is it possible to use the dmaengine
> driver at all when the PCI host controller is not in endpoint mode?
Yes. Dmaengine driver can be used when port is configured as RC or EP.
>
> Does the dmaengine show up as a PCI device when the PCI controller is
> in host mode?
No. It sits between AXI and PCI interfaces but it needs to be
programmed via the config bar.
>
>> > You should probably use devm_request_mem_region or devm_ioremap_resource
>> > here to ensure manage the mmio range.
>> >
>> >> +static int xpdma_probe(struct platform_device *pdev)
>> >> +{
>> >> +     int err;
>> >> +     u32 mask;
>> >> +     struct resource *res;
>> >> +     struct xpdma_port *port;
>> >> +
>> >> +     port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
>> >> +     if (!port)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     port->dma_dev.dev = &pdev->dev;
>> >> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >> +     if (!res) {
>> >> +             dev_err(&pdev->dev, "No cfg resource\n");
>> >> +             return -EINVAL;
>> >> +     }
>> >> +
>> >> +     port->cfg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> >> +     if (IS_ERR(port->cfg))
>> >> +             return PTR_ERR(port->cfg);
>> >> +
>> >> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> >> +     if (!res) {
>> >> +             dev_err(&pdev->dev, "No intr resource\n");
>> >> +             return -EINVAL;
>> >> +     }
>> >
>> > from binding, these two register ranges look like they are part of
>> > another device. Which device is that:
>> >
>> > +                       reg = < 0x0 0x1f2b0154 0x0 0xc
>> > +                               0x0 0x1f2b0058 0x0 0x8>;
>>
>> These are registers inside PCIe host controller that contains
>> information required such as the dma base address, interrupt
>> configuration. So this will be used for the channels. I am not aware
>> about syscon but will see if it better represents these registers.
>
> If the dmaengine is tightly connected to the PCI host controller
> and only usable in endpoint mode, maybe it's better to use a completely
> different model here, depending on how the PCI endpoint programming
> model will look like in the end. We are in fact in need of a generic
> abstraction for endpoints. There are some beginnings in drivers/ntb,
> and maybe it should build on that instead?
It can be used in both RC and EP modes but let me look in the ntb code too.

>
>         Arnd
