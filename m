From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 13:27:12 +0200
Subject: [PATCH v3 4/4] ARM: msm: Describe MSM 8660 SURF FPGA registers in
	DT
In-Reply-To: <1313688345-17699-5-git-send-email-davidb@codeaurora.org>
References: <1313688345-17699-1-git-send-email-davidb@codeaurora.org>
	<1313688345-17699-5-git-send-email-davidb@codeaurora.org>
Message-ID: <201108251327.13146.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, David Brown wrote:
> +static void __init msm8660_surf_fpga_init(void __iomem *fpga_mem)
> +{
> +       /* Advanced mode */
> +       writew(0xFFFF, fpga_mem + 0x15C);
> +       /* FPGA_UART_SEL */
> +       writew(0, fpga_mem + 0x172);
> +       /* FPGA_GPIO_CONFIG_117 */
> +       writew(1, fpga_mem + 0xEA);
> +       /* FPGA_GPIO_CONFIG_118 */
> +       writew(1, fpga_mem + 0xEC);
> +       dmb();
> +}

Does the dmb() do the right thing here? It seems strange to combine a strictly
ordered I/O instruction with another ordering instruction, and I think it would
be better to use writew_relaxed for the first one, followed by a 'wmb()'.

> +#ifdef CONFIG_OF
> +static void __init msm8660_surf_fpga_init_dt(void)
> +{
> +       struct device_node *node;
> +       void __iomem *fpga_mem;
> +
> +       node = of_find_compatible_node(NULL, NULL, "qcom,msm8660-surf-fpga");
> +       if (!node)
> +               return;
> +
> +       fpga_mem = of_iomap(node, 0);
> +       of_node_put(node);
> +       if (!fpga_mem) {
> +               printk(KERN_ERR "%s: Can't map fpga registers\n", __func__);
> +               return;
> +       }
> +
> +       msm8660_surf_fpga_init(fpga_mem);
> +       iounmap(fpga_mem);
> +}
> +#endif

Is the serial port connected through the FPGA or just configured by it?

In the former case, I think it would be better to make this a proper device driver that
binds to the qcom,msm8660-surf-fpga device, configures it and then creates the
platform_devices for the child nodes (the serial port, possibly others) by calling
of_platform_bus_probe.

	Arnd
