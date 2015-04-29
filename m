From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 29 Apr 2015 10:59:52 -0700
Subject: [PATCH V7 5/9] mfd: Add driver for NVIDIA Tegra XUSB
In-Reply-To: <20150429092348.GQ9169@x1>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
 <1430174242-29465-6-git-send-email-abrestic@chromium.org>
 <20150429092348.GQ9169@x1>
Message-ID: <CAL1qeaHNVVzMFg5r5ghg3zJTbaYOSf5Ms+Af_U5fhKc+vfWMHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee,

On Wed, Apr 29, 2015 at 2:23 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 27 Apr 2015, Andrew Bresticker wrote:
>
>> Add an MFD driver for the XUSB host complex found on NVIDIA Tegra124
>> and later SoCs.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>

>> --- /dev/null
>> +++ b/drivers/mfd/tegra-xusb.c

>> +struct tegra_xusb_soc_data {
>> +     struct mfd_cell *devs;
>> +     unsigned int num_devs;
>> +};
>> +
>> +static struct resource tegra_xhci_resources[] = {
>> +     {
>> +             .name = "host",
>> +             .flags = IORESOURCE_IRQ,
>> +     },
>> +     {
>> +             .name = "xhci",
>> +             .flags = IORESOURCE_MEM,
>> +     },
>> +     {
>> +             .name = "ipfs",
>> +             .flags = IORESOURCE_MEM,
>> +     },
>> +};
>> +
>> +static struct resource tegra_xusb_mbox_resources[] = {
>> +     {
>> +             .name = "smi",
>> +             .flags = IORESOURCE_IRQ,
>> +     },
>> +};
>
> DEFINE_RES_IRQ_NAMED()
>
>> +static struct mfd_cell tegra124_xusb_devs[] = {
>> +     {
>> +             .name = "tegra-xhci",
>> +             .of_compatible = "nvidia,tegra124-xhci",
>> +     },
>> +     {
>> +             .name = "tegra-xusb-mbox",
>> +             .of_compatible = "nvidia,tegra124-xusb-mbox",
>> +     },
>> +};
>> +
>> +static const struct tegra_xusb_soc_data tegra124_xusb_data = {
>> +     .devs = tegra124_xusb_devs,
>> +     .num_devs = ARRAY_SIZE(tegra124_xusb_devs),
>> +};
>> +
>> +static const struct of_device_id tegra_xusb_of_match[] = {
>> +     { .compatible = "nvidia,tegra124-xusb", .data = &tegra124_xusb_data },
>
> Yuk!  Why are you mixing platform data and DT in this way?
>
> Why can't you just stick all of this in DT?

I assume you mean the resources?  The compatible strings will at least
need to be SoC-specific since they will change from SoC to SoC.

>> +     {},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
>> +static struct regmap_config tegra_fpci_regmap_config = {
>> +     .reg_bits = 32,
>> +     .val_bits = 32,
>> +     .reg_stride = 4,
>> +};
>> +
>> +static int tegra_xusb_probe(struct platform_device *pdev)
>> +{
>> +     const struct tegra_xusb_soc_data *soc;
>> +     const struct of_device_id *match;
>> +     struct tegra_xusb *xusb;
>> +     struct resource *res;
>> +     void __iomem *fpci_base;
>> +     int irq, ret;
>> +
>> +     xusb = devm_kzalloc(&pdev->dev, sizeof(*xusb), GFP_KERNEL);
>> +     if (!xusb)
>> +             return -ENOMEM;
>> +     platform_set_drvdata(pdev, xusb);
>> +
>> +     match = of_match_node(tegra_xusb_of_match, pdev->dev.of_node);
>> +     soc = match->data;
>> +
>> +     irq = platform_get_irq_byname(pdev, "host");
>> +     if (irq < 0)
>> +             return irq;
>> +     tegra_xhci_resources[0].start = irq;
>> +     tegra_xhci_resources[0].end = irq;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
>> +     if (!res)
>> +             return -ENODEV;
>> +     tegra_xhci_resources[1].start = res->start;
>> +     tegra_xhci_resources[1].end = res->end;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ipfs");
>> +     if (!res)
>> +             return -ENODEV;
>> +     tegra_xhci_resources[2].start = res->start;
>> +     tegra_xhci_resources[2].end = res->end;
>> +
>> +     soc->devs[0].resources = tegra_xhci_resources;
>> +     soc->devs[0].num_resources = ARRAY_SIZE(tegra_xhci_resources);
>> +
>> +     irq = platform_get_irq_byname(pdev, "smi");
>> +     if (irq < 0)
>> +             return irq;
>> +     tegra_xusb_mbox_resources[0].start = irq;
>> +     tegra_xusb_mbox_resources[0].end = irq;
>> +
>> +     soc->devs[1].resources = tegra_xusb_mbox_resources;
>> +     soc->devs[1].num_resources = ARRAY_SIZE(tegra_xusb_mbox_resources);
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fpci");
>> +     fpci_base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(fpci_base))
>> +             return PTR_ERR(fpci_base);
>
> This stuff is not good.
>
> Either let MFD handle it with mfd_cells or stick all of this stuff in
> DT and parse it from the child devices.

I'm not sure what exactly you mean by "let MFD handle it with
mfd_cells" here - is that not what I'm doing now?  Anyway I think that
leaves two ways of representing this in DT.

Either have the MFD take a single IOMEM resource and divide it up
statically within the driver:

usb at 0,70090000 {
        compatible = "nvidia,tegra124-xusb";
        reg = <0x0 0x70090000 0x0 0xa000>;

        usb-host {
                compatible = "nvidia,tegra124-xhci";
                interrupts = <...>;
                ...
        }:

        mailbox {
                compatible = "nvidia,tegra124-xusb-mbox";
                interrupts = <...>;
                ...
        };
};

... or have the MFD take only the shared FPCI resource and have the
sub-devices parse the rest from DT:

usb at 0,70098000 {
        compatible = "nvidia,tegra124-xusb";
        reg = <0x0 0x70098000 0x0 0x1000>;
        ranges;

        usb-host at 0,70090000 {
                compatible = "nvidia,tegra124-xhci";
                reg = <0x0 0x70090000 0x0 0x8000>,
                        <0x0 0x70099000 0x0 0x1000>;
                interrupts = <...>;
                ...
        }:

        mailbox {
                compatible = "nvidia,tegra124-xusb-mbox";
                interrupts = <...>;
                ...
        };
};

I don't have a strong preference here, but I think the former more
accurately represents the resource hierarchy.  Since Thierry requested
the use of an MFD, I'd like him to weigh in on this - Thierry?

>> +     tegra_fpci_regmap_config.max_register = res->end - res->start - 3;
>> +     xusb->fpci_regs = devm_regmap_init_mmio(&pdev->dev, fpci_base,
>> +                                             &tegra_fpci_regmap_config);
>> +     if (IS_ERR(xusb->fpci_regs)) {
>> +             ret = PTR_ERR(xusb->fpci_regs);
>> +             dev_err(&pdev->dev, "Failed to init regmap: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = mfd_add_devices(&pdev->dev, -1, soc->devs, soc->num_devs,
>> +                           NULL, 0, NULL);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Failed to add MFD devices: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}

>> --- /dev/null
>> +++ b/include/soc/tegra/xusb.h

>> +struct tegra_xusb {
>> +     struct regmap *fpci_regs;
>
> Are you going to add to this?

No, I don't have any plans to add to this struct.

-Andrew
