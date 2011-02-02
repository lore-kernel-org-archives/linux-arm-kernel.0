From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 Feb 2011 16:43:57 +0100
Subject: [patch 1/5] Introduce EFIKA_COMMON
In-Reply-To: <20110202112119.373997404@rtp-net.org>
References: <20110202112104.380352125@rtp-net.org>
	<20110202112119.373997404@rtp-net.org>
Message-ID: <20110202154357.GY9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 12:21:05PM +0100, Arnaud Patard wrote:
> The Genesi EFIKA MX and EFIKA Smartbook are sharing a lot of things
> so it makes sense to create a common file for both devices and a specific
> file for each. No functionnal change except dropping uart 1 & 2.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> +
> +/* Serial ports */
> +#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
> +static const struct imxuart_platform_data uart_pdata = {
> +	.flags = IMXUART_HAVE_RTSCTS,
> +};
> +
> +static inline void mxc_init_imx_uart(void)
> +{
> +	imx51_add_imx_uart(0, &uart_pdata);
> +	imx51_add_imx_uart(1, &uart_pdata);
> +	imx51_add_imx_uart(2, &uart_pdata);
> +}
> +#else /* !SERIAL_IMX */
> +static inline void mxc_init_imx_uart(void)
> +{
> +}
> +#endif /* SERIAL_IMX */

Please remove the ifdefs around the serial port initialization. Also, I
remember that the efikamx only has one serial port connected.

> +
> +/* This function is board specific as the bit mask for the plldiv will also
> + * be different for other Freescale SoCs, thus a common bitmask is not
> + * possible and cannot get place in /plat-mxc/ehci.c.
> + */
> +static int initialize_otg_port(struct platform_device *pdev)
> +{
> +	u32 v;
> +	void __iomem *usb_base;
> +	void __iomem *usbother_base;
> +	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> +	if (!usb_base)
> +		return -ENOMEM;
> +	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
> +
> +	/* Set the PHY clock to 19.2MHz */
> +	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> +	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> +	v |= MX51_USB_PLL_DIV_24_MHZ;
> +	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> +	iounmap(usb_base);
> +	return 0;
> +}
> +
> +static struct mxc_usbh_platform_data dr_utmi_config = {
> +	.init   = initialize_otg_port,
> +	.portsc = MXC_EHCI_UTMI_16BIT,
> +	.flags  = MXC_EHCI_INTERNAL_PHY,
> +};

Could you rebase this on the ehci cleanup patches I recently sent and
thereby also test the patches for your board?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
