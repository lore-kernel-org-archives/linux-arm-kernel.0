From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 29 Oct 2014 11:49:29 +0100
Subject: [PATCH RESEND V4 6/9] usb: xhci: Add NVIDIA Tegra xHCI
 host-controller driver
In-Reply-To: <1414535277-15645-7-git-send-email-abrestic@chromium.org>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-7-git-send-email-abrestic@chromium.org>
Message-ID: <20141029104927.GC28356@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:27:53PM -0700, Andrew Bresticker wrote:
[...]
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
[...]
> +#define TEGRA_XHCI_NUM_SUPPLIES 8
> +static const char *tegra_xhci_supply_names[TEGRA_XHCI_NUM_SUPPLIES] = {
> +	"avddio-pex",
> +	"dvddio-pex",
> +	"avdd-usb",
> +	"avdd-pll-utmip",
> +	"avdd-pll-erefe",
> +	"avdd-pex-pll",
> +	"hvdd-pex",
> +	"hvdd-pex-plle",
> +};

This could be in a per-SoC structure since it's likely to change in a
future SoC. That could be done later on when it really becomes relevant,
though.

> +
> +static const struct {
> +	const char *name;
> +	int num;

unsigned?

> +} tegra_xhci_phy_types[] = {
> +	{
> +		.name = "usb3",
> +		.num = TEGRA_XUSB_USB3_PHYS,
> +	}, {
> +		.name = "utmi",
> +		.num = TEGRA_XUSB_UTMI_PHYS,
> +	}, {
> +		.name = "hsic",
> +		.num = TEGRA_XUSB_HSIC_PHYS,
> +	},
> +};

Should these constants perhaps be in a per-SoC structure like
tegra_xhci_soc_config rather than defined in a global header?

> +static int tegra_xhci_load_firmware(struct tegra_xhci_hcd *tegra)
> +{
[...]
> +	/* Start Falcon CPU. */
> +	csb_writel(tegra, CPUCTL_STARTCPU, XUSB_FALC_CPUCTL);
> +	usleep_range(1000, 2000);
> +
> +	fw_time = le32_to_cpu(cfg_tbl->fwimg_created_time);
> +	time_to_tm(fw_time, 0, &fw_tm);
> +	dev_info(dev,
> +		 "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC, "
> +		 "Falcon state 0x%x\n", fw_tm.tm_year + 1900,
> +		 fw_tm.tm_mon + 1, fw_tm.tm_mday, fw_tm.tm_hour,
> +		 fw_tm.tm_min, fw_tm.tm_sec,
> +		 csb_readl(tegra, XUSB_FALC_CPUCTL));
> +
> +	/* Make sure Falcon CPU is now running. */
> +	if (csb_readl(tegra, XUSB_FALC_CPUCTL) == CPUCTL_STATE_HALTED)
> +		return -EIO;

It seems somewhat strange to output the dev_info() message when in fact
it could be that the Falcon wasn't successfully booted. Also is it
guaranteed that the Falcon will always be up after 1 ms? Perhaps better
would be to use a timed loop?

> +static int tegra_xhci_set_ss_clk(struct tegra_xhci_hcd *tegra,
> +				 unsigned long rate)
> +{
> +	unsigned long new_parent_rate, old_parent_rate;
> +	int ret, div;
> +	struct clk *clk = tegra->ss_src_clk;
> +
> +	if (clk_get_rate(clk) == rate)
> +		return 0;
> +
> +	switch (rate) {
> +	case TEGRA_XHCI_SS_CLK_HIGH_SPEED:
> +		/*
> +		 * Reparent to PLLU_480M. Set divider first to avoid
> +		 * overclocking.
> +		 */
> +		old_parent_rate = clk_get_rate(clk_get_parent(clk));
> +		new_parent_rate = clk_get_rate(tegra->pll_u_480m);
> +		div = new_parent_rate / rate;
> +		ret = clk_set_rate(clk, old_parent_rate / div);
> +		if (ret)
> +			return ret;
> +		ret = clk_set_parent(clk, tegra->pll_u_480m);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The rate should already be correct, but set it again just
> +		 * to be sure.
> +		 */
> +		ret = clk_set_rate(clk, rate);
> +		if (ret)
> +			return ret;
> +		break;
> +	case TEGRA_XHCI_SS_CLK_LOW_SPEED:
> +		/* Reparent to CLK_M */
> +		ret = clk_set_parent(clk, tegra->clk_m);
> +		if (ret)
> +			return ret;
> +		ret = clk_set_rate(clk, rate);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(tegra->dev, "Invalid SS rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (clk_get_rate(clk) != rate) {
> +		dev_err(tegra->dev, "SS clock doesn't match requested rate\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

So this is why you need pllu_480m and clk_m clocks. I would've thought
it nice to use something like the assigned-clocks properties to take
care of this, but it seems like this may actually be required to be
updated dynamically at runtime, so a fixed property is not going to be
an option.

> +static int tegra_xhci_clk_enable(struct tegra_xhci_hcd *tegra)
> +{
> +	clk_prepare_enable(tegra->pll_e);
> +	clk_prepare_enable(tegra->host_clk);
> +	clk_prepare_enable(tegra->ss_clk);
> +	clk_prepare_enable(tegra->falc_clk);
> +	clk_prepare_enable(tegra->fs_src_clk);
> +	clk_prepare_enable(tegra->hs_src_clk);

You should error-check these.

> +static int tegra_xhci_phy_enable(struct tegra_xhci_hcd *tegra)
> +{
> +	int ret;
> +	int i;

I prefer unsigned when the value can't be negative as in this case.

> +
> +	for (i = 0; i < ARRAY_SIZE(tegra->phys); i++) {
> +		ret = phy_init(tegra->phys[i]);
> +		if (ret)
> +			goto disable_phy;
> +		ret = phy_power_on(tegra->phys[i]);
> +		if (ret) {
> +			phy_exit(tegra->phys[i]);
> +			goto disable_phy;
> +		}
> +	}

Perhaps a phy_init_and_power_on() helper would be useful. Nothing that
needs to be done as part of this patch, though.

> +
> +	return 0;
> +disable_phy:
> +	for (i = i - 1; i >= 0; i--) {
> +		phy_power_off(tegra->phys[i]);
> +		phy_exit(tegra->phys[i]);

You could write this as:

	for (i = i; i > 0; i--) {
		phy_power_off(tegra->phys[i - 1]);
		...
	}

for the unsigned case. But I guess this would be a reasonable exception
to let i be signed.

> +static void tegra_xhci_phy_disable(struct tegra_xhci_hcd *tegra)
> +{
> +	int i;

There's no reason for it to be signed here, though.

> +
> +	for (i = 0; i < ARRAY_SIZE(tegra->phys); i++) {
> +		phy_power_off(tegra->phys[i]);
> +		phy_exit(tegra->phys[i]);
> +	}
> +}
> +
> +static bool is_host_mbox_message(u32 cmd)
> +{
> +	switch (cmd) {
> +	case MBOX_CMD_INC_SSPI_CLOCK:
> +	case MBOX_CMD_DEC_SSPI_CLOCK:
> +	case MBOX_CMD_INC_FALC_CLOCK:
> +	case MBOX_CMD_DEC_FALC_CLOCK:
> +	case MBOX_CMD_SET_BW:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void tegra_xhci_mbox_work(struct work_struct *work)
> +{
> +	struct tegra_xhci_hcd *tegra = container_of(work, struct tegra_xhci_hcd,
> +						    mbox_req_work);

There's only a single instance of this, but it might still be useful to
wrap it in a static inline for readability.

> +	/*
> +	 * Set the xHCI pointer before xhci_plat_setup() (aka hcd_driver.reset)

I don't think this driver calls xhci_plat_setup() (anymore?).

> +	 * is called by usb_add_hcd().
> +	 */
> +	*((struct xhci_hcd **) xhci->shared_hcd->hcd_priv) = xhci;

This makes me a little uneasy. Perhaps this should be an XHCI wrapper to
make it look less like you're doing something you shouldn't.

> +static int tegra_xhci_probe(struct platform_device *pdev)
> +{
> +	struct tegra_xhci_hcd *tegra;
> +	struct usb_hcd *hcd;
> +	struct resource	*res;

There's a tab between resource and *res which should be a space.

> +	struct phy *phy;
> +	const struct of_device_id *match;
> +	int ret, i, j, k;
> +
> +	BUILD_BUG_ON(sizeof(struct tegra_xhci_fw_cfgtbl) != 256);
> +
> +	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	if (!tegra)
> +		return -ENOMEM;
> +	tegra->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, tegra);
> +
> +	match = of_match_device(tegra_xhci_of_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "No device match found\n");
> +		return -ENODEV;
> +	}

I don't think this can happen. If there's no match in the table then
this function shouldn't have been called in the first place.

> +	tegra->soc_config = match->data;
> +
> +	/*
> +	 * Right now device-tree probed devices don't get dma_mask set.
> +	 * Since shared usb code relies on it, set it here for now.
> +	 * Once we have dma capability bindings this can go away.
> +	 */
> +	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;

I think that's no longer necessary. of_dma_configure() should take care
of this now.

> +	k = 0;
> +	for (i = 0; i < ARRAY_SIZE(tegra_xhci_phy_types); i++) {

I think a more idiomatic way to write this would be:

	for (i = 0, k = 0; ...)

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/abba4609/attachment.sig>
