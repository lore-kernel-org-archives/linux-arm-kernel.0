From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Oct 2013 17:57:58 +0200
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <CAKohpok2scsSU7eFOP5LYmQar8xfOqG4-b3z4sVS6JOgnxVcpw@mail.gmail.com>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
 <1382186261-14482-2-git-send-email-andrew@lunn.ch>
 <CAKohpok2scsSU7eFOP5LYmQar8xfOqG4-b3z4sVS6JOgnxVcpw@mail.gmail.com>
Message-ID: <20131022155758.GA26694@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh

Thanks for your comments. I will include them in the next version.

> > +static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
> > +{
> > +       return IRQ_HANDLED;
> > +}
> 
> what is this for?

The hardware raises an interrupt when the change is complete. This
interrupt is what brings the CPU out of the WFI. I don't know the
interrupt code too well, but i think it is necessary for the driver to
acknowledged it. The interrupt core code counts interrupts which
nobody acknowledges, and after 1000 are received, it disables the
interrupt. That would probably result in the machine locking solid,
never coming out of the WFI. So i'm playing it safe and handling the
interrupt.

> > +static int dove_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np;
> > +       struct resource *res;
> > +       int err;
> > +       int irq;
> 
> Above two can be merged.

Well, i was told the exact opposite by the USB serial maintainer :-) 
I will use your coding style here, and his for USB code, and try to
keep everybody happy.

 
> > +       priv.dev = &pdev->dev;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv.dfs))
> > +               return PTR_ERR(priv.dfs);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +       priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv.pmu_cr))
> > +               return PTR_ERR(priv.pmu_cr);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> > +       priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv.pmu_clk_div))
> > +               return PTR_ERR(priv.pmu_clk_div);
> > +
> > +       np = of_find_node_by_path("/cpus/cpu at 0");
> > +       if (!np)
> > +               return -ENODEV;
> > +
> > +       priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
> > +       if (IS_ERR(priv.cpu_clk)) {
> > +               dev_err(priv.dev, "Unable to get cpuclk");
> > +               return PTR_ERR(priv.cpu_clk);
> > +       }
> > +
> > +       clk_prepare_enable(priv.cpu_clk);
> 
> this can fail..

In theory yes. In practice no. It is a fixed rate clock. prepare and
enable are actually NOPs for this type of clock. However the API
documentation explicitly states you need to call prepare and enable
before you can call clk_get_rate(). But i can add error checking if
you want.

> 
> > +       dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;

  Andrew
