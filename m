From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 May 2016 13:58:05 -0700
Subject: [PATCH v3 1/4] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1464021024-29380-2-git-send-email-carlo@caione.org> (Carlo
 Caione's message of "Mon, 23 May 2016 18:30:21 +0200")
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
 <1464021024-29380-2-git-send-email-carlo@caione.org>
Message-ID: <m2posco5k2.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> Introduce a driver to provide calls into secure monitor mode.
>
> In the Amlogic SoCs these calls are used for multiple reasons: access to
> NVMEM, set USB boot, enable JTAG, etc...
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

[...]

> +static int meson_sm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct meson_sm_firmware *fw;
> +	u32 sm_phy_in_base, sm_phy_out_base;
> +	int cmd_in, cmd_out;
> +
> +	fw = devm_kzalloc(&pdev->dev, sizeof(*fw), GFP_KERNEL);
> +	if (!fw)
> +		return -ENOMEM;
> +
> +	fw->dev = &pdev->dev;
> +
> +	if (of_property_read_u32(np, "amlogic,sm-cmd-input-base", &cmd_in))
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(np, "amlogic,sm-cmd-output-base", &cmd_out))
> +		return -EINVAL;
> +
> +	sm_phy_in_base = meson_sm_call(cmd_in, 0, 0, 0, 0, 0);

Should there be any error checking here?  Do we have any info on the
return values here in case of error, or in case of missing firmware,
etc.

Kevin
